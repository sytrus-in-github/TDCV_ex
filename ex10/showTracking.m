function showTracking( img, xReg, yReg, hReg, wReg )
    % show image and tracked region
    imshow(img);
    hold on;
    rectangle('Position',[yReg, xReg, wReg, hReg],'EdgeColor','g');
end

