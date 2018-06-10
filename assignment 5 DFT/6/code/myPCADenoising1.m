function [] = myPCADenoising1(image)
% PCA denoising using all the patches in the image to create eigenspace
    
    [M, N] = size(image);

    % new_image is the corrupted image
    new_image = image + 20*randn(M, N);
    P = zeros([49 (M-6)*(N-6)]);

    for i=1:M-6
        for j=1:N-6
            %Subimage
            patch = new_image(i:i+6, j:j+6);
            P(:, (N-6)*i-(N-6)+j) = patch(:);

        end
    end

    % Eigvectors
    L = P*P';
    [W,D] = eig(L);

    % Normalize
    norms = sqrt(sum(W.^2));
    W = W ./ kron(norms, ones([7*7 1]));
    % Get alpha
    alpha = W'*P;
    % Get estimates of original coefficients
    orig_coeff = transpose(sum(transpose(alpha.^2)))/((M-6)*(N-6));
    orig_coeff_estimate  = max(0, orig_coeff-400);
    % get denoised coeffiecients
    denoised_coeff = alpha ./ (1 + 20./ kron(orig_coeff_estimate, ones([1 62500])));
    denoised_patches = W*denoised_coeff;
    % Reconstruct image
    final_Image = double(zeros(M, N));
    final_Mask = double(zeros(M, N));

    for i=1:M-6
        for j=1:N-6
            final_Image(i:i+6, j:j+6) = final_Image(i:i+6, j:j+6) + reshape(denoised_patches(:, (N-6)*i-(N-6)+j), 7, 7);
            final_Mask(i:i+6, j:j+6) = final_Mask(i:i+6, j:j+6) + 1;

        end
    end
    
    
    
    final_Image = final_Image./final_Mask;
    final_Mask
    rmsd = sqrt(sum(sum(image-final_Image)).^2)/(255*255)
    %Display original vs PCA denoised image
    figure;%('units','normalized','outerposition',[0 0 1 1]);
    subplot(1, 2, 1), imshow(new_image/max(max(new_image)));
    title('Original Image');
    subplot(1, 2, 2), imshow(final_Image/max(max(final_Image)));
    title('PCA-denoised image');
    
end
