maxSecMix1=[max1Sec100;max1Sec200;max1Sec300;max1Sec400;max1Sec500;max1Sec600];
maxSecMix2=[max2Sec100;max2Sec200;max2Sec300;max2Sec400;max2Sec500;max2Sec600];
maxSecMix7=[max7Sec100;max7Sec200;max7Sec300;max7Sec400;max7Sec500;max7Sec600];
maxSecMix8=[max8Sec100;max8Sec200;max8Sec300;max8Sec400;max8Sec500;max8Sec600];
% maxSecMix9=[max9Sec100;max9Sec200;max9Sec300;max9Sec400;max9Sec500;max9Sec600;max9Sec700];
% maxSecMix10=[max10Sec100;max10Sec200;max10Sec300;max10Sec400;max10Sec500;max10Sec600;max10Sec700];

%%%%%%%%%%%%%%for amplitude 0.1
Trial1= [max1Sec100,max1Sec200,max1Sec300,max1Sec400,max1Sec500,max1Sec600];
bigger1 = max(Trial1)+1;
Trial1(end+1)=bigger1;
Trial1= sort(Trial1);
Trial1b = unique(Trial1);
L1b= length(Trial1b)
for i=1:6
    for j=1:821
        for k1=1:L1b
            if maxSecMix1(i,j)<Trial1b(k1)
                resultMatrix1(i,j,k1)=0;
            else
                resultMatrix1(i,j,k1)=1;
            end
        end
    end
end



%%%%%%%%%%%%%%for amplitude 0.2
Trial2= [max2Sec100,max2Sec200,max2Sec300,max2Sec400,max2Sec500,max2Sec600];
bigger2 = max(Trial2)+1;
Trial2(end+1)=bigger2;
Trial2= sort(Trial2);
Trial2b = unique(Trial2);
L2b= length(Trial2b)
for i=1:6
    for j=1:821
        for k2=1:L2b
            if maxSecMix2(i,j)<Trial2b(k2)
                resultMatrix2(i,j,k2)=0;
            else
                resultMatrix2(i,j,k2)=1;
            end
        end
    end
end


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
            if maxSecMix7(i,j)<Trial7b(k7)
                resultMatrix7(i,j,k7)=0;
            else
                resultMatrix7(i,j,k7)=1;
            end
        end
    end
end


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


%%%%%%%%%%%%%%for lamba 1.5
% Trial9= [max9Sec100,max9Sec200,max9Sec300,max9Sec400,max9Sec500,max9Sec600,max9Sec700];
% bigger9 = max(Trial9)+1;
% Trial9(end+1)=bigger9;
% Trial9= sort(Trial9);
% Trial9b = unique(Trial9);
% L9b= length(Trial9b)
% for i=1:7
%     for j=1:821
%         for k9=1:L9b
%             if maxSecMix9(i,j)<Trial9b(k9)
%                 resultMatrix9(i,j,k9)=0;
%             else
%                 resultMatrix9(i,j,k9)=1;
%             end
%         end
%     end
% end


%%%%%%%%%%%%%%for lamba 2
% Trial10= [max10Sec100,max10Sec200,max10Sec300,max10Sec400,max10Sec500,max10Sec600,max10Sec700];
% bigger10 = max(Trial10)+1;
% Trial10(end+1)=bigger10;
% Trial10= sort(Trial10);
% Trial10b = unique(Trial10);
% L10b= length(Trial10b)
% for i=1:7
%     for j=1:821
%         for k10=1:L10b
%             if maxSecMix10(i,j)<Trial9b(k10)
%                 resultMatrix10(i,j,k10)=0;
%             else
%                 resultMatrix10(i,j,k10)=1;
%             end
%         end
%     end
% end


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
