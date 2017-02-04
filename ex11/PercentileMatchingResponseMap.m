function binaryMap = PercentileMatchingResponseMap( map, sizeImage, percentage )
    % keeps the percentage% highest values of the map
    binaryMap = false(sizeImage(1),sizeImage(2));
    mapSize = size(map);
    binaryMap(1:mapSize(1),1:mapSize(2)) = (map >= prctile(map(map>0),100-percentage));
end
