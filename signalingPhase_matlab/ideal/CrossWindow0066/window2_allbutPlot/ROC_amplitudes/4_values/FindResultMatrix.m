
maxSecMix7b=[max7Sec100;max7Sec200;max7Sec300;max7Sec400;max7Sec500;max7Sec600];



clear Trial7 bigger7 Trial7b L7b

%%%%%%%%%%%%%%for lamba 0.75
Trial7= [max7Sec100,max7Sec200,max7Sec300,max7Sec400,max7Sec500,max7Sec600];
bigger7 = max(Trial7)+1;
Trial7(end+1)=bigger7;
Trial7= sort(Trial7);
Trial7b = unique(Trial7);
L7b= length(Trial7b)
for i=1:6
    for j=1:821
        for k7=1:L7b
            if maxSecMix7b(i,j)<Trial7b(k7)
                resultMatrix7b(i,j,k7)=0;
            else
                resultMatrix7b(i,j,k7)=1;
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
