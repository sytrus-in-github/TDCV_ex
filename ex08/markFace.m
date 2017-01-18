function markFace(imgfile, pt, scale)
    SQUARESIZE=19;
    img = imresize(imread(imgfile),scale);
    figure;
    imshow(img);
    hold on;
    rectangle('Position',[pt(2) pt(1) SQUARESIZE SQUARESIZE],'EdgeColor','r');
end