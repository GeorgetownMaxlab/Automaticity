function [images] = loadimages(directory,filenames) 
    total = size(filenames,1);
    for i=1:total
        [value map] = imread([directory, filenames(i).name],'JPG');
        images(i,:,:) = value(:,:);
    end
end