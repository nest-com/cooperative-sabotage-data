maxSecMix8a=[max8Sec100;max8Sec200;max8Sec300;max8Sec400;max8Sec500;max8Sec600;max8Sec700];





clear Trial87 bigger8 Trial8b L8b


%%%%%%%%%%%%%%for lamba 0.75
Trial8= [max8Sec100,max8Sec200,max8Sec300,max8Sec400,max8Sec500,max8Sec600,max8Sec700];
bigger8 = max(Trial8)+1;
Trial8(end+1)=bigger8;
Trial8= sort(Trial8);
Trial8b = unique(Trial8);
L8b= length(Trial8b)
for i=1:7
    for j=1:821
        for k8=1:L8b
            if maxSecMix8a(i,j)<Trial8b(k8)
                resultMatrix8a(i,j,k8)=0;
            else
                resultMatrix8a(i,j,k8)=1;
            end
        end
    end
end



for i=1:7
    for j=1:821
        GroundTruth(i,j)=0;
    end
end

GroundTruth(1,1:262)=1;
GroundTruth(2,38:362)=1;
GroundTruth(3,138:462)=1;
GroundTruth(4,238:562)=1;
GroundTruth(5,338:662)=1;
GroundTruth(6,438:762)=1;
GroundTruth(7,538:821)=1;