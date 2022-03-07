img = imread('RGBD Data/food_bag_8_1_1.png');
depth = imread('RGBD Data/food_bag_8_1_1_depth.png');
depth_gray = double(im2uint8(depth));
figure, imshow(depth_gray, []);
img_gray = rgb2gray(img);
kernel_size = 5*5;
allsig = 5*5;
gaussian_kernel = fspecial('gaussian', [kernel_size kernel_size], allsig);
img_gray_gaussian = imfilter(depth_gray, gaussian_kernel, 'replicate');
figure, imshow(img_gray_gaussian, []);
imwrite(uint8(img_gray_gaussian),"nani.png")

% Preparation for BF
indent = (kernel_size - 1)/2;
[height, width] = size(img_gray);
img_results = zeros(height,width);
img_gray = double(img_gray);
sigma_range = allsig;
% Compute range kernel
for i = indent + 1:height - indent
for j = indent + 1:width - indent
range_kernel = exp(-abs(img_gray(i - indent:i + indent,j - indent:j + indent )-img_gray(i,j)).^2/(sigma_range * sigma_range));
depth_kernel = exp(-abs(depth_gray(i - indent:i + indent,j - indent:j + indent )-depth_gray(i,j)).^2/(sigma_range * sigma_range));
kernel = gaussian_kernel .* range_kernel .*depth_kernel; 
normalization = 1/sum(kernel(:));
temp = (kernel.*double(depth_gray(i - indent:i + indent,j - indent:j + indent))) * normalization;
img_results(i,j) = sum(temp(:));
end
end
figure, imshow(img_results, []);
imwrite(uint8(img_results),"555.png")
