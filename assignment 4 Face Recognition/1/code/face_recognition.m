image_directory='../../../../../att_faces/s';

image_array=zeros(92*112,32*6);
k=170;

for i=1:32
    for j=1:6
        image_path=strcat(image_directory,int2str(i),'/',int2str(j),'.pgm');
        image=imread(image_path);
        image_array(:,(i-1)*6+j)=im2double(image(:));
    end
end

image_centroid=mean(image_array,2);
for i=1:32*6
    image_array(:,i)=image_array(:,i)-image_centroid;
end
X=image_array;
L=transpose(X)*X;
[W,D]=eigs(L,k);
V=X*W;
norm_factor=sqrt(sum(V.^2));
for i=1:k
    V(:,i)=V(:,i)/norm_factor(i);
end

alpha=transpose(V)*X;
norm_factor=sqrt(sum(alpha.^2,1));
for i=1:192
    alpha(:,i)=alpha(:,i)/norm_factor(i);
end

count=0;

for i=1:32
    for j=7:10
        
        image_path=strcat(image_directory,int2str(i),'/',int2str(j),'.pgm');
        image=imread(image_path);
        image=im2double(image(:));
        
        image=image-image_centroid;
        
        
        new_alpha=transpose(V)*image;
        
        new_alpha=new_alpha*ones(1,192);
        
        norm_factor=sqrt(sum(new_alpha.^2,1));
        for it=1:192
            new_alpha(:,it)=new_alpha(:,it)/norm_factor(it);
        end
        
        alpha1=(alpha-new_alpha).^2;
        alpha1=sum(alpha1);
        
        [minimum,arg]=min(alpha1);
        arg=max(arg);
        
        if(i==floor((arg-1)/6)+1)
            count=count+1;
        end
    end
    
end
count/(32*4)
