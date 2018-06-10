function[]=notch_filter(image_path)
image=load(image_path);
image=im2double(image.Z);
[M,N]=size(image);


%Fourier transform of the image
image_f=fftshift(fft2(image));
f1=log(1+abs(image_f));
fm=max(f1(:));
image_fft=f1/fm;
figure, imshow(im2double(image_fft))
%Threshold= high pass filter
image_f(image_fft<0.3)=0;

image_fli=ifft2(ifftshift(image_f));
ifftshow(image_fli);
end


function []=ifftshow(f)
f1=abs(f);
fm=max(f1(:));
figure, imshow(im2double(f1/fm))
end
