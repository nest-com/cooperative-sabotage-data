%amplitude 0.1

for t=1:L1b
    tp(t)=0;
    fn(t)=0;    
    for i=1:7 
        if i==1
            count(i,t)=0;
            for j=1:262
                if (GroundTruth(i,j)==1) && (resultMatrix1(i,j,t)==1)
                    count(i,t)=count(i,t)+1;
                end
            end
            if count(i,t)>0
                tp(t)=tp(t)+1;
            else
                fn(t)=fn(t)+1;
            end
        else
            if i==7
                count(i,t)=0;
                for j=538:821
                    if (GroundTruth(i,j)==1) && (resultMatrix1(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            else 
                count(i,t)=0;
                for j=(i*100-162):(i*100+162)
                    if (GroundTruth(i,j)==1) && (resultMatrix1(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            end
        end
    end   
    tpr1(t)= tp(t)/(tp(t)+fn(t));
end


%amplitude 0.2

for t=1:L2b
    tp(t)=0;
    fn(t)=0;    
    for i=1:7 
        if i==1
            count(i,t)=0;
            for j=1:262
                if (GroundTruth(i,j)==1) && (resultMatrix2(i,j,t)==1)
                    count(i,t)=count(i,t)+1;
                end
            end
            if count(i,t)>0
                tp(t)=tp(t)+1;
            else
                fn(t)=fn(t)+1;
            end
        else
            if i==7
                count(i,t)=0;
                for j=538:821
                    if (GroundTruth(i,j)==1) && (resultMatrix2(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            else 
                count(i,t)=0;
                for j=(i*100-162):(i*100+162)
                    if (GroundTruth(i,j)==1) && (resultMatrix2(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            end
        end
    end   
    tpr2(t)= tp(t)/(tp(t)+fn(t));
end


%amplitude 0.07

for t=1:L7b
    tp(t)=0;
    fn(t)=0;    
    for i=1:7 
        if i==1
            count(i,t)=0;
            for j=1:262
                if (GroundTruth(i,j)==1) && (resultMatrix7(i,j,t)==1)
                    count(i,t)=count(i,t)+1;
                end
            end
            if count(i,t)>0
                tp(t)=tp(t)+1;
            else
                fn(t)=fn(t)+1;
            end
        else
            if i==7
                count(i,t)=0;
                for j=538:821
                    if (GroundTruth(i,j)==1) && (resultMatrix7(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            else 
                count(i,t)=0;
                for j=(i*100-162):(i*100+162)
                    if (GroundTruth(i,j)==1) && (resultMatrix7(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            end
        end
    end   
    tpr7(t)= tp(t)/(tp(t)+fn(t));
end



%lambda 1

for t=1:L8b
    tp(t)=0;
    fn(t)=0;    
    for i=1:7 
        if i==1
            count(i,t)=0;
            for j=1:262
                if (GroundTruth(i,j)==1) && (resultMatrix8(i,j,t)==1)
                    count(i,t)=count(i,t)+1;
                end
            end
            if count(i,t)>0
                tp(t)=tp(t)+1;
            else
                fn(t)=fn(t)+1;
            end
        else
            if i==7
                count(i,t)=0;
                for j=538:821
                    if (GroundTruth(i,j)==1) && (resultMatrix8(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            else 
                count(i,t)=0;
                for j=(i*100-162):(i*100+162)
                    if (GroundTruth(i,j)==1) && (resultMatrix8(i,j,t)==1)
                        count(i,t)=count(i,t)+1;
                    end
                end
                if count(i,t)>0
                    tp(t)=tp(t)+1;
                else
                    fn(t)=fn(t)+1;
                end
            end
        end
    end   
    tpr8(t)= tp(t)/(tp(t)+fn(t));
end

%lambda 1
% for t=1:L9b
%     tp(t)=0;
%     fn(t)=0;    
%     for i=1:7 
%         if i==1
%             count(i,t)=0;
%             for j=1:262
%                 if (GroundTruth(i,j)==1) && (resultMatrix9(i,j,t)==1)
%                     count(i,t)=count(i,t)+1;
%                 end
%             end
%             if count(i,t)>0
%                 tp(t)=tp(t)+1;
%             else
%                 fn(t)=fn(t)+1;
%             end
%         else
%             if i==7
%                 count(i,t)=0;
%                 for j=538:821
%                     if (GroundTruth(i,j)==1) && (resultMatrix9(i,j,t)==1)
%                         count(i,t)=count(i,t)+1;
%                     end
%                 end
%                 if count(i,t)>0
%                     tp(t)=tp(t)+1;
%                 else
%                     fn(t)=fn(t)+1;
%                 end
%             else 
%                 count(i,t)=0;
%                 for j=(i*100-162):(i*100+162)
%                     if (GroundTruth(i,j)==1) && (resultMatrix9(i,j,t)==1)
%                         count(i,t)=count(i,t)+1;
%                     end
%                 end
%                 if count(i,t)>0
%                     tp(t)=tp(t)+1;
%                 else
%                     fn(t)=fn(t)+1;
%                 end
%             end
%         end
%     end   
%     tpr9(t)= tp(t)/(tp(t)+fn(t));
% end
% 
% 
% %lambda 2
% 
% for t=1:L10b
%     tp(t)=0;
%     fn(t)=0;    
%     for i=1:7 
%         if i==1
%             count(i,t)=0;
%             for j=1:262
%                 if (GroundTruth(i,j)==1) && (resultMatrix10(i,j,t)==1)
%                     count(i,t)=count(i,t)+1;
%                 end
%             end
%             if count(i,t)>0
%                 tp(t)=tp(t)+1;
%             else
%                 fn(t)=fn(t)+1;
%             end
%         else
%             if i==7
%                 count(i,t)=0;
%                 for j=538:821
%                     if (GroundTruth(i,j)==1) && (resultMatrix10(i,j,t)==1)
%                         count(i,t)=count(i,t)+1;
%                     end
%                 end
%                 if count(i,t)>0
%                     tp(t)=tp(t)+1;
%                 else
%                     fn(t)=fn(t)+1;
%                 end
%             else 
%                 count(i,t)=0;
%                 for j=(i*100-162):(i*100+162)
%                     if (GroundTruth(i,j)==1) && (resultMatrix10(i,j,t)==1)
%                         count(i,t)=count(i,t)+1;
%                     end
%                 end
%                 if count(i,t)>0
%                     tp(t)=tp(t)+1;
%                 else
%                     fn(t)=fn(t)+1;
%                 end
%             end
%         end
%     end   
%     tpr10(t)= tp(t)/(tp(t)+fn(t));
% end
% 
