img = imread('RGBD Data/food_bag_8_1_1.png');
importance_map = importance_computing(img);

% figure, imshow(importance_map);

vals = importance_map;
imghere = img;
[vals, imghere] = seamcarving(vals,imghere,100);
figure, imshow(vals, []);
figure, imshow(uint8(imghere), []);

