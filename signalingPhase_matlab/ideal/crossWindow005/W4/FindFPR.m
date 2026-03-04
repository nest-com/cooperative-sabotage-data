
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
    fpr8d(t)= fp(t)/(fp(t)+tn(t));
end
