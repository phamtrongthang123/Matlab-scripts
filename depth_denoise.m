all_depths = dir("RGBD Data/*depth.png");
for indx=1:length(all_depths)
    fn = all_depths(indx).name;
    depth_path = fullfile(all_depths(indx).folder, fn);
    [a,~] = split(all_depths(indx).name,"_depth");
    img_path = string(fullfile(all_depths(indx).folder,append(a(1),a(2))));
    fprintf(1, 'Now running img "%s" and depth "%s"\n', img_path, depth_path);

    img = imread(img_path);
    depth = imread(depth_path);
    allsig = 5*5;
    img_results = bilateral_filter_depth(img,depth,5*5,allsig,allsig,allsig);
    %figure, imshow(uint16(img_results), []);

    save_path = fullfile('outputs_depth_easy', fn);
    scalemin = img_results - min(img_results(:));
    scalemin = double(scalemin ) * 65535 / double(max(scalemin(:)));
    imwrite(uint16(scalemin),save_path);
    save_path = fullfile('outputs_depth', fn);
    imwrite(uint16(img_results),save_path);
end