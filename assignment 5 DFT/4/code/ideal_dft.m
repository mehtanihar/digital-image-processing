function[]=ideal_dft(image_path,d0)
image=imread(image_path);
[M,N]=size(image);

%Zero pad the image
new_image=zeros(2*M,2*N);
new_image(M/2+1:3*M/2,N/2+1:3*N/2)=image;

%Fourier transform of the image
image_f=fftshift(fft2(new_image));
fftshow(image_f)


filter=zeros(2*M,2*N);

for i=1:2*M
    for j=1:2*N
        if ((i-M)^2 + (j-N)^2 < d0^2 )
            filter(i,j)=1;
        end
    end
end

%Filter
fftshow(filter)
image_f1=image_f.*filter;


%Frequency domain response of filtered image
fftshow(image_f1)

image_fli=ifft2(ifftshift(image_f1));
filtered_image=real(image_fli(M/2+1:3*M/2,N/2+1:3*N/2));
%Filtered image in space domain
ifftshow(filtered_image);

end

function []=fftshow(f)
f1=log(1+abs(f));
fm=max(f1(:));
figure, imshow(im2double(f1/fm))
end

function []=ifftshow(f)
f1=abs(f);
fm=max(f1(:));
figure, imshow(im2double(f1/fm))
end