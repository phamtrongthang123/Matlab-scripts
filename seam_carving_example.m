allfile = dir("prob2imgs/*.*g");
for indx=1:length(allfile)
    fn = allfile(indx).name;
    img_path = fullfile(allfile(indx).folder, fn);
    fprintf(1, 'Now running img "%s"\n', img_path);

    img = imread(img_path);
    importance_map = importance_computing(img);
    saliency_map = lab_saliency(img);
    save_path = fullfile('before_importance_map', fn);
    scalemin = importance_map - min(importance_map(:));
    scalemin = double(scalemin ) * 255 / double(max(scalemin(:)));
    imwrite(uint8(scalemin),save_path)
    save_path = fullfile('before_saliency', fn);
    scalemin = saliency_map - min(saliency_map(:));
    scalemin = double(scalemin ) * 255 / double(max(scalemin(:)));
    imwrite(uint8(scalemin),save_path)


    [vals, imghere] = seamcarving(importance_map,img,200);
    save_path = fullfile('importance_map', fn);
    scalemin = vals - min(vals(:));
    scalemin = double(scalemin ) * 255 / double(max(scalemin(:)));
    imwrite(uint8(scalemin),save_path)
    save_path = fullfile('importance_map_output', fn);
    imwrite(uint8(imghere),save_path);
    
    [vals, imghere] = seamcarving(saliency_map,img,200);
    save_path = fullfile('saliency', fn);
    scalemin = vals - min(vals(:));
    scalemin = double(scalemin ) * 255 / double(max(scalemin(:)));
    imwrite(uint8(scalemin),save_path)
    save_path = fullfile('saliency_output', fn);
    imwrite(uint8(imghere),save_path);
end