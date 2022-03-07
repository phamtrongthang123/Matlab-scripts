function [ sm ] = lab_saliency( img )
% SALIENCY Compute saliency map using lab color space. This method is
% described from Frequency Tuned Saliency Detection (Achanta et al).
% Args:
%       img: color image (height, width, 3)
% Returns:
%       sm: saliency map
    gaussian_kernel = fspecial('gaussian', [10 10], 5);
    img_gaussian = imfilter(img, gaussian_kernel, 'replicate');
    lab = rgb2lab(img_gaussian);
    l = double(lab(:,:,1)); lm = mean(mean(l));
    a = double(lab(:,:,2)); am = mean(mean(a));
    b = double(lab(:,:,3)); bm = mean(mean(b));
    sm = (l-lm).^2 + (a-am).^2 + (b-bm).^2;
end