function final_image = myAHE(old_image_path, N,save_path)
    figure
    hold on
    old_image=imread(old_image_path);
     
    
    %Reflection of image to take care of boundary pixels
    
    [old_rows,old_cols,dim]=size(old_image);
    new_image=zeros(old_rows,old_cols);
    
    num_elem=old_rows*old_cols;
   
    final_image=old_image;
    for d=1:dim
        new_image=old_image(:,:,d);
        
        for i=1:((N-1)/2)
           col=old_image(:,i,d);
           new_image=[col new_image]; 

        end

        for i=1:((N-1)/2)
           col=old_image(:,old_cols-i+1,d);
           new_image=[new_image col]; 

        end

        new_image1=new_image;

        for i=1:((N-1)/2)
           row=new_image1(i,:);
           new_image=[row; new_image]; 

        end


         for i=1:((N-1)/2)
           row=new_image1(old_rows-i+1,:);
           new_image=[new_image; row]; 

         end



        final_image(:,:,d)=old_image(:,:,d);


        for j=1:old_cols
            stack=new_image(1:N,j:j+N-1);
            final_image(1,j,d)=HE(stack);
            for i=2:old_rows
               stack=stack(2:N,:);
               stack=[stack; new_image(i+N-1,j:j+N-1)];
               final_image(i,j,d)=HE(stack);
            end
        end
    end
    
    save(save_path,'final_image')
    for i=1:dim
        myNumOfColors = 254;
        myColorScale = [ [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' ];
        imagesc (single (final_image(:,:,i))); 
        colormap (myColorScale);

        daspect ([1 1 1]);
        axis tight
        colorbar
    end

end

function final=HE(old_image)
    [old_rows,old_cols]=size(old_image);
    num_elem=old_rows*old_cols;
    
    unravel_image=reshape(old_image,[num_elem,1]);
   
    stack=zeros(256,1);
    
    for i=1:num_elem
       stack(unravel_image(i)+1)=stack(unravel_image(i)+1)+1; 
    end
    total=0;
    for i=1:256
        total=total+stack(i);
        stack(i)=total;
    end
    
    min_cdf=stack(min(unravel_image)+1);
    i=(old_rows+1)/2;
    j=i;
    
    final=round((stack(old_image(i,j)+1)-min_cdf)/(num_elem-1)*255);
    hold off
  
    
end
