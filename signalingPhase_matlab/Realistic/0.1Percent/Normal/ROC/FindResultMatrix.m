maxSecMix1=[max1Sec100;max1Sec200;max1Sec300;max1Sec400;max1Sec500;max1Sec600;max1Sec700];
maxSecMix2=[max2Sec100;max2Sec200;max2Sec300;max2Sec400;max2Sec500;max2Sec600;max2Sec700];
maxSecMix7=[max7Sec100;max7Sec200;max7Sec300;max7Sec400;max7Sec500;max7Sec600;max7Sec700];




%%%%%%%%%%%%%%for amplitude 0.1

%Trial1= [max1Sec100,max1Sec200,max1Sec300,max1Sec400,max1Sec500,max1Sec600,max1Sec700];
%Trial1= sort(Trial1);
%Trial1b = unique(Trial1);
L1b= length(Trial1b)

for i=1:7
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
% Trial2= [max2Sec100,max2Sec200,max2Sec300,max2Sec400,max2Sec500,max2Sec600,max2Sec700];
% Trial2= sort(Trial2);
% Trial2b = unique(Trial2);
L2b= length(Trial2b)

for i=1:7
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


%%%%%%%%%%%%%%for amplitude 0.07
% Trial7= [max7Sec100,max7Sec200,max7Sec300,max7Sec400,max7Sec500,max7Sec600,max7Sec700];
% Trial7= sort(Trial7);
% Trial7b = unique(Trial7);
L7b= length(Trial7b)
for i=1:7
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