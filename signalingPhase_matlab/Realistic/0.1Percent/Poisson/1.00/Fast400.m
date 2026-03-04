%This file is used to create a 0.1 amplitude ideal secret message using
%the agent simulation, secret come from using gama=0.75, sigma=0 and P=1, (and SpeedUnit 0.1) from
%the agent simulation file, from previous experimentation we want to have a
%long message, in this file 162 frame lenght, while the fastICA window is
%80, the secret is sent in frame 400

t = 1:1:901;
t2= t.*4;
t2= t2-4;
S1= 1000*DataSpain.Demand;
%S2 = 0.5*square(t/2);
S2 = ((secret)/10000)-0.5;  %alternating positive and negative values is important! the y axis displacement varies depending on 
%percentage of max amplitude
S3 = 0.1*(ones(length(t))); 
S2 = S2';
S3 = S3';
S4(1:400) = S3(1:400);
S4(401:562)= S2(1:162);
S4(563:901) = S3(1:339);
S4=S4';
ideal2 = ((secretIdeal)/10000)-0.5;
mix= [1 1
      1  1];
X = [S1,S4];
X=X';
meas = mix*X;


%[icasig, A, W]  = fastICA(meas,2);
%Adjust this value
wSize = 80;
DataEnd=length(DataSpain.Demand)


ST= ideal2(1:80);
for i=1:DataEnd-wSize  
    MeasT(1:2,1:wSize+1)= meas(:,i:i+wSize);
    icasigT3(1:2,1:wSize+1,i) = fastICA(MeasT,2);
    [c3(1:2*wSize+1, i) z3(1:2*wSize+1, i)] = xcorr(ST(:),icasigT3(1,:,i));
    [c4(1:2*wSize+1, i) z4(1:2*wSize+1, i)] = xcorr(ST(:),icasigT3(2,:,i));
    temA(i)= abs(max(c3(1:2*wSize+1, i)));
    temB(i)= abs(max(c4(1:2*wSize+1, i)));
    if temA(i)>temB(i)
        message(1:2*wSize+1,i) = c3(1:2*wSize+1, i);
        indexSec(i)=1;
    else
        message(1:2*wSize+1,i) = c4(1:2*wSize+1, i);
        indexSec(i)=2;
    end
    maxSec(i)= max(abs(message(:,i)));
end
    

max8Sec400=maxSec;

[icasig, A, W]  = fastICA(meas,2);
figure
subplot(2,3,2), plot(t2, meas(1,:));xlabel('Time (s)');title("Mixed signal");
subplot(2,3,5), plot(t, meas(2,:));
subplot(2,3,3), plot(t2, icasig(1,:));xlabel('Time (s)');title("Recovered signal");
subplot(2,3,6), plot(t2, icasig(2,:));xlabel('Time (s)');title("Recovered signal");
%subplot(2,3,1), plot(t2, S1);xlabel('Time (s)');title("Original demand");
%subplot(2,3,4), plot(t2, S2);xlabel('Time (s)');title("Secret message");

