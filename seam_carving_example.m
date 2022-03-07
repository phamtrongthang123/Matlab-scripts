img = imread('RGBD Data/food_bag_8_1_1.png');
img_gray = rgb2gray(img);
importance_map = importance_computing(img_gray);

% figure, imshow(importance_map);

vals = importance_map;
imghere = img;
[vals, imghere] = seamcarving(vals,imghere,50);
figure, imshow(vals, []);
figure, imshow(uint8(imghere), []);

