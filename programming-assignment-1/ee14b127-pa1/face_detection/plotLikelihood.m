function [face_model_on_faces,non_face_model_on_faces,face_model_on_non_faces,non_face_model_on_non_faces] =  plotLikelihood(mu_face,Sigma_face,mu_non_face,Sigma_non_face,face_test_data,non_face_test_data)
    face_model_on_faces = [];
    non_face_model_on_faces = [];
    for i = 1:size(face_test_data,1)
        t = face_test_data(i,:);
        face_model_on_faces = [face_model_on_faces;loglikelihood(t,mu_face,Sigma_face)];
        non_face_model_on_faces = [non_face_model_on_faces;loglikelihood(t,mu_non_face,Sigma_non_face)];
    end
    
    face_model_on_non_faces = [];
    non_face_model_on_non_faces = [];
    for i = 1:size(non_face_test_data,1)
        t = non_face_test_data(i,:);
        face_model_on_non_faces = [face_model_on_non_faces; loglikelihood(t,mu_face,Sigma_face)];
        non_face_model_on_non_faces = [non_face_model_on_non_faces; loglikelihood(t,mu_non_face,Sigma_non_face)];
    end
    
    points = 1:size(face_test_data,1);
    figure();
    plot(points,face_model_on_faces,points,non_face_model_on_faces);
    title('Loglikelihood plot for faces test set');
    xlabel('Data Points');
    ylabel('Loglikelihood value');
    legend('Loglikelihood value for face model','Loglikelihood value for non face model');
    
    points = 1:size(non_face_test_data,1);
    figure();
    plot(points,face_model_on_non_faces,points,non_face_model_on_non_faces);
    title('Loglikelihood plot for non faces test set');
    xlabel('Data Points');
    ylabel('Loglikelihood value');
    legend('Loglikelihood value for face model','Loglikelihood value for non face model');
    
end
    
    