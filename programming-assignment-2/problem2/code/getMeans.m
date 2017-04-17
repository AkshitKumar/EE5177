function means = getMeans(I,cluster,K)
    means = [];
    image_red_channel = I(:,:,1);
    image_green_channel = I(:,:,2);
    image_blue_channel = I(:,:,3);
    for i = 1:K
        means(i,1) = mean(image_red_channel(cluster == i));
        means(i,2) = mean(image_green_channel(cluster == i));
        means(i,3) = mean(image_blue_channel(cluster == i));
    end
end