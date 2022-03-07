function o_depth = bilateral_filter_depth(img,depth, kernel_size, sigmaG, sigmaC, sigmaD)
%BILATERAL_FILTER_DEPTH Bilerate filter for depth image. The kernel
% equation is form Depth Image Enhancement for Kinect Using Region Growing
% and Bilateral Filter (Chen et al).
% Args: 
%       img: color image (height, width, 3), uint8
%       depth: depth image (height, width), uint16
%       kernel_size: the kernel size, scalar
%       sigmaG: sigma for gaussian kernel
%       sigmaC: sigma for color/range kernel
%       sigmaD: sigma for depth kernel
% Returns:
%       o_depth: depth image after filering (height, width), uint16
%
    depth_rescale = double(depth) * 255.0 / 65535.0;
    img_gray = rgb2gray(img);
    img_gray = double(img_gray);
    indent = (kernel_size - 1)/2;
    [height, width] = size(img_gray);
    gaussian_kernel = fspecial('gaussian', [kernel_size kernel_size], sigmaG);   
    img_results = zeros(height,width);
    % Compute range kernel
    for i = indent + 1:height - indent
        for j = indent + 1:width - indent
            range_kernel = exp(-abs(img_gray(i - indent:i + indent,j - indent:j + indent )-img_gray(i,j)).^2/(sigmaC * sigmaC));
            depth_kernel = exp(-abs(depth_rescale(i - indent:i + indent,j - indent:j + indent )-depth_rescale(i,j)).^2/(sigmaD * sigmaD));
            kernel = gaussian_kernel .* range_kernel .*depth_kernel; 
            normalization = 1/sum(kernel(:));
            temp = (kernel.*double(depth_rescale(i - indent:i + indent,j - indent:j + indent))) * normalization;
            img_results(i,j) = sum(temp(:));
        end
    end
    o_depth = img_results * 65535 / 255;
    o_depth = uint16(o_depth);
end

