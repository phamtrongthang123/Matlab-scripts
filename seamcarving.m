function [o_importance_map,o_image] = seamcarving(importance_map,img,n)
% SEAMCARVING Seam carving algorithm, it also removes the seam line after
% computing. Note that this function only compute vertically, if you want
% horizontally, please transpose the input img.
% Args: 
%       importance_map: importance map
%       img: color img (height, width, 3)
%       n: number of seam lines we want to remove
% Returns:
%       o_importance_map: importance map after removing seam lines
%       o_image: image after removing seam lines
%
    [~, width] = size(importance_map);
    n = min(width, n);
    for l=1:n
        [height, width] = size(importance_map);
        dirs = zeros(height,width) - 2;
        costs = zeros(height,width);
        costs(height,:) = importance_map(height,:);
        
        for row = height-1:-1:1
            for col = 1:width
                triple = [realmax, costs(row+1, col), realmax];
                if (col-1 >= 1)
                    triple(1) = costs(row+1, col-1);
                end 
                if (col+1 <= width)
                    triple(3) = costs(row+1, col+1);
                end 
                [min_triple, argmin_triple] = min(triple);
                costs(row,col) = importance_map(row,col) + min_triple;
                dirs(row,col) = argmin_triple - 2;
            end
        end
        
        [~, mincol] = min(costs(1,:));
        seam = zeros(1,height);
        seam(1) = mincol;
        for row=1:height-1
            seam(row+1) = seam(row) + dirs(row,seam(row));
        end
        
        newimportance_map = zeros(height, width-1);
        newimg = zeros(height, width-1, 3);
        for i=1:height
            newimportance_map(i,1:seam(i)-1) = importance_map(i,1:seam(i)-1);
            newimportance_map(i,seam(i):width-1) = importance_map(i,seam(i)+1:width);
            newimg(i,1:seam(i)-1,:) = img(i,1:seam(i)-1,:);
            newimg(i,seam(i):width-1,:) = img(i,seam(i)+1:width, :);
        end
        importance_map = newimportance_map;
        img = newimg;
    end
    o_importance_map = importance_map;
    o_image = uint8(img);
end

