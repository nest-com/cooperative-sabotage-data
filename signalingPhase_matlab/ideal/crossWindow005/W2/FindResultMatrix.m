
maxSecMix8=[max8Sec100;max8Sec200;max8Sec300;max8Sec400;max8Sec500;max8Sec600];

clear Trial87 bigger8 Trial8b L8b

%%%%%%%%%%%%%%for lamba 1
Trial8= [max8Sec100,max8Sec200,max8Sec300,max8Sec400,max8Sec500,max8Sec600];
bigger8 = max(Trial8)+1;
Trial8(end+1)=bigger8;
Trial8= sort(Trial8);
Trial8b = unique(Trial8);
L8b= length(Trial8b)
for i=1:6
    for j=1:821
        for k8=1:L8b
            if maxSecMix8(i,j)<Trial8b(k8)
                resultMatrix8(i,j,k8)=0;
            else
                resultMatrix8(i,j,k8)=1;
            end
        end
    end
end




for i=1:7
    for j=1:821
        GroundTruth(i,j)=0;
    end
end

GroundTruth(1,1:320)=1;
GroundTruth(2,1:420)=1;
GroundTruth(3,80:520)=1;
GroundTruth(4,180:620)=1;
GroundTruth(5,280:720)=1;
GroundTruth(6,380:820)=1;
