

for t=1:L8b
    tp(t)=0;
    fn(t)=0;    
    for i=1:7 
        if i==1
            count(i,t)=0;
            for j=1:262
                if (GroundTruth(i,j)==1) && (resultMatrix8a(i,j,t)==1)
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
                    if (GroundTruth(i,j)==1) && (resultMatrix8a(i,j,t)==1)
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
                    if (GroundTruth(i,j)==1) && (resultMatrix8a(i,j,t)==1)
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
    tpr8a(t)= tp(t)/(tp(t)+fn(t));
end
