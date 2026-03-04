
maxSecMix8=[max8Sec100;max8Sec200;max8Sec300;max8Sec400;max8Sec500;max8Sec600];


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

GroundTruth(1,1:400)=1;
GroundTruth(2,1:500)=1;
GroundTruth(3,1:600)=1;
GroundTruth(4,100:700)=1;
GroundTruth(5,200:800)=1;
GroundTruth(6,300:861)=1;
