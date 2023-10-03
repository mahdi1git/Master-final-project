%% Targets and receiver
clc
close all;
Targ= 12;% assuming target at 16.4 meters
D=(Targ*2*Fs)/c;
Rx=[Tx(end-D:end) Tx(1:(end-(D+1)))];
% Rx=[zeros(1 , int32(D)) Tx(1:(end-(D+1)))]; %% add by me
% Rx = Rx +0.5* randn(1 ,length(Rx))/sqrt(2);%% add by me 
Cm=zeros(1,M+1);
for i=1:1:M+1
    if i==1
        Cm(i)=mean(Tx(1:corr_lengths(i)).*Rx(1:corr_lengths(i)));
    else
        Cm(i)=mean(Tx(corr_lengths(i-1)+1:corr_lengths(i)).*Rx(corr_lengths(i-1)+1:corr_lengths(i)));
    end
end
scl=2.5;
figure
plot(1:1:length(Cm),Cm)
hold on 
plot(1:1:length(cumsum(Cm)),cumsum(Cm))
grid on
title('cross correlation of SST as function of coherence lengths')
xlabel('distance(m)')
ylabel('cross correlation(Cm)')
axis([1 M -inf inf])
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt/scl)
CM=diff(Cm); % differentiating cross correlation
[pk,loc]=max(CM)
target_plc = loc /scl
figure
plot(1:1:length(CM),CM)
grid on
title('Derivative of cross correlation of SST as function of coherence lengths')
xlabel('distance(m)')
ylabel('cross correlation(CM)')
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt/scl)
