%0.1 amplitude

for t=1:L1b
    fp(t)=0;
    tn(t)=0;
    for i=1:6
        if i==1 
            for j=320:821
                if (resultMatrix1(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                    fp(t)=fp(t)+1;
                else
                    if (resultMatrix1(i,j,t)==0)&& (GroundTruth(i,j)==0)
                        tn(t)=tn(t)+1;
                    end
                end
            end
        else
            if i==2
                for j=420:821
                    if (resultMatrix1(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix1(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            else
                for j=1:(i*100-220)
                    if (resultMatrix1(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix1(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
                for j=(i*100+220):821
                    if (resultMatrix1(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix1(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            end
        end
    end
    fpr1(t)= fp(t)/(fp(t)+tn(t));
end



%0.2 amplitude

for t=1:L2b
    fp(t)=0;
    tn(t)=0;
    for i=1:6
        if i==1 
            for j=320:821
                if (resultMatrix2(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                    fp(t)=fp(t)+1;
                else
                    if (resultMatrix2(i,j,t)==0)&& (GroundTruth(i,j)==0)
                        tn(t)=tn(t)+1;
                    end
                end
            end
        else
            if i==2
                for j=420:821
                    if (resultMatrix2(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix2(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            else
                for j=1:(i*100-220)
                    if (resultMatrix2(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix2(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
                for j=(i*100+220):821
                    if (resultMatrix2(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix2(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            end
        end
    end
    fpr2(t)= fp(t)/(fp(t)+tn(t));
end



%0.075 amplitude

for t=1:L7b
    fp(t)=0;
    tn(t)=0;
    for i=1:6
        if i==1 
            for j=320:821
                if (resultMatrix7(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                    fp(t)=fp(t)+1;
                else
                    if (resultMatrix7(i,j,t)==0)&& (GroundTruth(i,j)==0)
                        tn(t)=tn(t)+1;
                    end
                end
            end
        else
            if i==2
                for j=420:821
                    if (resultMatrix7(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix7(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            else
                for j=1:(i*100-220)
                    if (resultMatrix7(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix7(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
                for j=(i*100+220):821
                    if (resultMatrix7(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix7(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            end
        end
    end
    fpr7(t)= fp(t)/(fp(t)+tn(t));
end



%%for lambda 1
for t=1:L8b
    fp(t)=0;
    tn(t)=0;
    for i=1:6
        if i==1 
            for j=320:821
                if (resultMatrix8(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                    fp(t)=fp(t)+1;
                else
                    if (resultMatrix8(i,j,t)==0)&& (GroundTruth(i,j)==0)
                        tn(t)=tn(t)+1;
                    end
                end
            end
        else
            if i==2
                for j=420:821
                    if (resultMatrix8(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix8(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            else
                for j=1:(i*100-220)
                    if (resultMatrix8(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix8(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
                for j=(i*100+220):821
                    if (resultMatrix8(i,j,t) == 1) && (GroundTruth(i,j)== 0)
                        fp(t)=fp(t)+1;
                    else
                        if (resultMatrix8(i,j,t)==0)&& (GroundTruth(i,j)==0)
                            tn(t)=tn(t)+1;
                        end
                    end
                end
            end
        end
    end
    fpr8(t)= fp(t)/(fp(t)+tn(t));
end



%%for lambda 1.5
% for t=1:L9b
%     fp(t)=0;
%     tn(t)=0;
%     for i=1:7
%         if i==1 
%             for j=262:821
%                 if (resultMatrix9(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                     fp(t)=fp(t)+1;
%                 else
%                     if (resultMatrix9(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                         tn(t)=tn(t)+1;
%                     end
%                 end
%             end
%         else
%             if i==7
%                 for j=1:538
%                     if (resultMatrix9(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                         fp(t)=fp(t)+1;
%                     else
%                         if (resultMatrix9(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                             tn(t)=tn(t)+1;
%                         end
%                     end
%                 end
%             else
%                 for j=1:(i*100-123)
%                     if (resultMatrix9(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                         fp(t)=fp(t)+1;
%                     else
%                         if (resultMatrix9(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                             tn(t)=tn(t)+1;
%                         end
%                     end
%                 end
%                 for j=(i*100+123):821
%                     if (resultMatrix9(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                         fp(t)=fp(t)+1;
%                     else
%                         if (resultMatrix9(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                             tn(t)=tn(t)+1;
%                         end
%                     end
%                 end
%             end
%         end
%     end
%     fpr9(t)= fp(t)/(fp(t)+tn(t));
% end
% 
% %%for lambda 2
% for t=1:L10b
%     fp(t)=0;
%     tn(t)=0;
%     for i=1:7
%         if i==1 
%             for j=262:821
%                 if (resultMatrix10(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                     fp(t)=fp(t)+1;
%                 else
%                     if (resultMatrix10(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                         tn(t)=tn(t)+1;
%                     end
%                 end
%             end
%         else
%             if i==7
%                 for j=1:538
%                     if (resultMatrix10(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                         fp(t)=fp(t)+1;
%                     else
%                         if (resultMatrix10(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                             tn(t)=tn(t)+1;
%                         end
%                     end
%                 end
%             else
%                 for j=1:(i*100-123)
%                     if (resultMatrix10(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                         fp(t)=fp(t)+1;
%                     else
%                         if (resultMatrix10(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                             tn(t)=tn(t)+1;
%                         end
%                     end
%                 end
%                 for j=(i*100+123):821
%                     if (resultMatrix10(i,j,t) == 1) && (GroundTruth(i,j)== 0)
%                         fp(t)=fp(t)+1;
%                     else
%                         if (resultMatrix10(i,j,t)==0)&& (GroundTruth(i,j)==0)
%                             tn(t)=tn(t)+1;
%                         end
%                     end
%                 end
%             end
%         end
%     end
%     fpr10(t)= fp(t)/(fp(t)+tn(t));
% end
% 
