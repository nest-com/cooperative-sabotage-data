%amplitude 0.1



%amplitude 0.07

for t=1:L7b
    tp(t)=0;
    fn(t)=0;    
    for i=1:6
        if i==1
            count(i,t)=0;
            for j=1:320
                if (GroundTruth(i,j)==1) && (resultMatrix7b(i,j,t)==1)
                    count(i,t)=count(i,t)+1;
                end
            end
            if count(i,t)>0
                tp(t)=tp(t)+1;
            else
                fn(t)=fn(t)+1;
            end
        else
            if i==2
                count(i,t)=0;
                for j=1:420
                    if (GroundTruth(i,j)==1) && (resultMatrix7b(i,j,t)==1)
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
                for j=(i*100-220):(i*100+220)
                    if (GroundTruth(i,j)==1) && (resultMatrix7b(i,j,t)==1)
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
    tpr7b(t)= tp(t)/(tp(t)+fn(t));
end



%lambda 1

