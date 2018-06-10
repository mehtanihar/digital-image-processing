function [] = myPCADenoising2(image,k)
%PCA denoising using 25/200 patches obtained by KNN to create eigenspace
tic;

    [M, N] = size(image);

    % new_image is the corrupted image
    new_image = image + 20*randn(M, N);
    
    final_image = double(zeros(M, N));
    final_mask = double(zeros(M, N));

    for i=1:M-6
        i
        for j=1:N-6
            % Generate the subimage
            subpatch = reshape(new_image(i:i+6, j:j+6), 49, 1);
            min_x = max(i-15,1);
            max_x = min(i+15-6,M-6);
            min_y = max(j-15,1);
            max_y = min(j+15-6,N-6);
            patches = zeros([49 (max_x-min_x+1)*(max_y-min_y+1)]);
            for k=min_x:max_x
                for l=min_y:max_y
                    patch = reshape(image(k:k+6, l:l+6), 49, 1);
                    patches(:,(max_x-min_x+1)*(k-min_x+1)-(max_x-min_x+1)+(l-min_y+1)) = patch;
                end
            end
            
            patchIndices = knnsearch(patches', transpose(subpatch), 'k', k);
            best_patches = patches(:,patchIndices);
            % Get eigenvectors
            L = best_patches*best_patches';
            [W,D] = eig(L);
            % Normalize
            norms = sqrt(sum(W.^2));
            W = W ./ kron(norms, ones([7*7 1]));
            % Get alpha
            alpha = W'*best_patches;
            % Get estimates of original coefficients
            orig_coeff = (sum(transpose(alpha.^2)))'/min(200, size(best_patches,2));
            orig_coeff_estimate  = max(0, orig_coeff-400);
            % Change coefficients
            denoised_coeff = alpha ./ (1 + 20./ kron(orig_coeff_estimate, ones([1 min(200, size(best_patches,2))])));
            denoised_patch = W*denoised_coeff(:, 1);
            final_image(i:i+6, j:j+6) = final_image(i:i+6, j:j+6) + reshape(denoised_patch, 7, 7);
            final_mask(i:i+6, j:j+6) = final_mask(i:i+6, j:j+6) + 1;

        end
    end

    final_image = final_image./final_mask;
    
    rmsd = sqrt(sum(sum(image-final_image)).^2)/(255*255)
    figure;%('units','normalized','outerposition',[0 0 1 1]);
    subplot(1, 2, 1), imshow(new_image/max(max(new_image)));
    title('Original Image');
    subplot(1, 2, 2), imshow(final_image/max(max(final_image)));
    title('PCA-denoised Image');
    time = toc;
    disp(num2str(time));
end