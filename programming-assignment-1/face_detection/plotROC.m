function [tpr,fpr] =  plotROC(threshold_start,threshold_step,threshold_finish,mu,Sigma,face_test,non_face_test,model_no)
    if model_no == 1
        fprintf('Plotting ROC for faces model .....................\n');
        tpr = [];
        fpr = [];
        for threshold = threshold_start:threshold_step:threshold_finish
            faces_tp = [];
            faces_fp = [];
            for i = 1:size(face_test,1)
                t = face_test(i,:);
                faces_tp = [faces_tp; loglikelihood(t,mu,Sigma) > threshold];
            end
            tp = sum(faces_tp);
            for i = 1:size(non_face_test,1)
                t = non_face_test(i,:);
                faces_fp = [faces_fp; loglikelihood(t,mu,Sigma) > threshold];
            end
            fp = sum(faces_fp);
            tpr = [tpr; tp/size(face_test,1)];
            fpr = [fpr; fp/size(non_face_test,1)];
        end
        figure();
        plot(fpr,tpr);
        title('ROC Plot for Faces-Model');
        ylabel('True Positive Rate (TPR)');
        xlabel('False Positive Rate (FPR)');
    end
    
    if model_no == 2
        fprintf('Plotting ROC for non faces model ...................\n');
        tpr = [];
        fpr = [];
        for threshold = threshold_start:threshold_step:threshold_finish
            non_faces_tp = [];
            non_faces_fp = [];
            for i = 1:size(face_test,1)
                t = face_test(i,:);
                non_faces_tp = [non_faces_tp; loglikelihood(t,mu,Sigma) > threshold];
            end
            fp = sum(non_faces_tp);
            for i = 1:size(non_face_test,1)
                t = non_face_test(i,:);
                non_faces_fp = [non_faces_fp; loglikelihood(t,mu,Sigma) > threshold];
            end
            tp = sum(non_faces_fp);
            tpr = [tpr; tp/size(non_face_test,1)];
            fpr = [fpr; fp/size(face_test,1)];
        end
        x = linspace(0,1);
        figure();
        
        plot(fpr,tpr,x,x);
        title('ROC Plot for Non-faces Model');
        ylabel('True Positive Rate (TPR)');
        xlabel('False Positive Rate (FPR)');
        legend('ROC for Non-face Model', 'ROC for random model');
    end
end
        