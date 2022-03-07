function importance_map = importance_computing(img_gray)
    [height, width] = size(img_gray);
    importance_map = zeros(height,width);
    
    for i = 1:height
        for j = 1:width
            tmpres = 0;
            if (i - 1 >= 1)
                tmpres = tmpres + abs(img_gray(i,j) - img_gray(i-1,j));
            end
            if (i + 1 <= height)
                tmpres = tmpres + abs(img_gray(i,j) - img_gray(i+1,j));
            end
            if (j - 1 >= 1)
                tmpres = tmpres + abs(img_gray(i,j) - img_gray(i,j-1));
            end
            if (j + 1 <= width)
                tmpres = tmpres + abs(img_gray(i,j) - img_gray(i,j+1));
            end
            importance_map(i,j) = tmpres;
        end
    end
end