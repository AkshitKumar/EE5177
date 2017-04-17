function clustered_image = getClusteredImage(K,means,I,cluster)
    image_red_channel = I(:,:,1);
    image_green_channel = I(:,:,2);
    image_blue_channel = I(:,:,3);
    for j = 1 : K
        image_red_channel(cluster == j) = means(j,1);
        image_green_channel(cluster == j) = means(j,2);
        image_blue_channel(cluster == j) = means(j,3);
    end
    clustered_image = cat(3,image_red_channel, image_green_channel, image_blue_channel);
end