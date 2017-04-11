function hog_features = feature_extraction(file_names,angle,centX,centY,cropW,cropH)
    hog_features = [];
    num_of_image = 5;
    for i = 1:length(file_names)
        image = imread(strcat('data/',file_names{i}));
        grayscale = rgb2gray(image);
        rect = [centX(i) - cropW(i)/2, centY(i) - cropH(i)/2, cropW(i), cropH(i)];
        cropped_image = imcrop(grayscale,rect);
        if(num_of_image > 0)
            imwrite(cropped_image,strcat('cropped_image_',mat2str(num_of_image),'.png'));
            num_of_image = num_of_image - 1;
        end
        resize_image = imresize(cropped_image,[108 96]);
        bias_term = 1;
        extract_hog_feature = [bias_term, hog_feature_vector(resize_image)];
        hog_features = [hog_features; extract_hog_feature];
    end
    hog_features = hog_features';
end
        