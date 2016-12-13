function It = getImage(index)
    It = imread(strcat('data/img_sequence/', sprintf('%04d',index), '.png'));
end