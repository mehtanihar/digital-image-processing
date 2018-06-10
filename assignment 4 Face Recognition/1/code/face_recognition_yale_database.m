image_directory='../../../../../CroppedYale/CroppedYale/yaleB';


k_arr=[2; 3; 5; 10; 15; 20; 30; 50; 60; 65; 75; 100; 200; 300; 500; 1000];
k_arr=transpose(k_arr);
list=[];
for m=1:length(k_arr)
    k=k_arr(m)
    image_array=zeros(192*168,38*40);
    iter=0;
    for i=1:39  
        if(i~=14)
            iter=iter+1;
            if(i<10)
                folder_name=strcat(image_directory,'0',int2str(i));
            else
                folder_name=strcat(image_directory,int2str(i));
            end
            file_list=dir(folder_name);
            file_list=file_list(3:42);

            for j=1:length(file_list)

                image_path=strcat(folder_name,'/',file_list(j).name);
                image=imread(image_path);
                image_array(:,(iter-1)*40+j)=im2double(image(:));
            end
        end
    end




    image_centroid=mean(image_array,2);
    for i=1:38*40
        image_array(:,i)=image_array(:,i)-image_centroid;
    end
    X=image_array;
    L=transpose(X)*X;
    [W,D]=eigs(L,k+3);
    [m,n]=size(W);
    W=W(:,4:n);
    V=X*W;
    norm_factor=sqrt(sum(V.^2,1));
    for i=1:k
        V(:,i)=V(:,i)/norm_factor(i);
    end

    alpha=transpose(V)*X;
    norm_factor=sqrt(sum(alpha.^2,1));
    
    for i=1:1520
        alpha(:,i)=alpha(:,i)/norm_factor(i);
    end

    count=0;


    iter=0;
    for i=1:39
        if(i~=14)
            iter=iter+1;
            if(i<10)
                folder_name=strcat(image_directory,'0',int2str(i));
            else
                folder_name=strcat(image_directory,int2str(i));
            end
            file_list=dir(folder_name);
            file_list=file_list(43:length(file_list));

            for j=1:length(file_list)

                image_path=strcat(folder_name,'/',file_list(j).name);
                image=imread(image_path);
                image=im2double(image(:));
                image=image-image_centroid;
                new_alpha=transpose(V)*image;

                new_alpha=new_alpha*ones(1,1520);

                norm_factor=sqrt(sum(new_alpha.^2,1));
                for it=1:1520
                    new_alpha(:,it)=new_alpha(:,it)/norm_factor(it);
                end


                alpha1=(alpha-new_alpha).^2;
                alpha1=sum(alpha1,1);

                [minimum,arg]=min(alpha1);            
                arg=max(arg);
                if(iter==floor((arg-1)/40)+1)
                    count=count+1;
                end
            end

        end

    end
    count/(38*24)
    list=[list count/(38*24)];
end
list
plot(k_arr,list)