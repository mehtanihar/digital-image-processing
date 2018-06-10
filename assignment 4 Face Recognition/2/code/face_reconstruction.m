image_directory='../../../../../CroppedYale/CroppedYale/yaleB';

width=192;
breadth=168;

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


k_arr=[2; 10; 20; 50; 75; 100; 125; 150; 175];
k_arr=transpose(k_arr);
list=[];

image_centroid=mean(image_array,2);
for i=1:38*40
    image_array(:,i)=image_array(:,i)-image_centroid;
end
X=image_array;
L=transpose(X)*X;
[W,D]=eigs(L,200);
V=X*W;
[a,b]=size(V)
norm_factor=sqrt(sum(V.^2,1));
for i=1:b
    V(:,i)=V(:,i)/norm_factor(i);
end

alpha=transpose(V)*X;
norm_factor=sqrt(sum(alpha.^2,1));

for i=1:1520
    alpha(:,i)=alpha(:,i)/norm_factor(i);
end

new_image=imread(strcat(image_directory,'01/yaleB01_P00A+000E+00.pgm'));
new_image=im2double(new_image(:));

%Reconstruction
for m=1:length(k_arr)
    k=k_arr(m);
    new_V=V(:,1:k);
    new_alpha=alpha(:,1:k);
    coeffs = transpose(new_V)*(new_image-image_centroid);
    reconstructedImage = reshape(new_V*coeffs + image_centroid,width,breadth) ;
    subplot(2, 5, m), imshow(mat2gray(reconstructedImage));
    title(['k = ' num2str(k)]);
end
figure('units','normalized','outerposition',[0 0 1 1]);

%Eigenfaces

for m = 1:25
    E = V(:,m);
    eigenface = reshape(E, width, breadth);
    subplot(5, 5, m), imshow(mat2gray(eigenface));
    title(['k = ' num2str(m)]);
end


