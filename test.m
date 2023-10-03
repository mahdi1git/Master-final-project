clc;
clear all;
close all;
format short
%% time specifications
M= 300;   % M+1 coherence lengths 
N= 15 ;  % N+1 phase jumps in each coherence window <=8
Fc=6e9; % carrier frequency
Fs=16*Fc; % sampling Frequency
c=3e8; % speed of light
init_cycles=2; % no. of cycles in 1st coherence window, per phase length
incr_cycles=1; % no. of  cycles to be  added to each coherence length, per phase length
phi=(-pi+(2*pi/((N+1)*(M+1))):(2*pi/((N+1)*(M+1))):pi); % uniform phase jumps
% phi= 2*pi*rand(1,(N+1)*(M+1)) - pi; % random phase jumps
Tx=[];
corr_lengths=[];
tic
%% Transmission Signal Synthesis
for i=1:1:M+1
    for j=1:1:N+1
        t=0:1/Fs:(init_cycles/Fc+(i-1)*incr_cycles/Fc)-(1/Fs);
        Tx=horzcat(Tx,cos(2*pi*Fc*t+phi(j+(i-1)*(N+1))));
    end
    corr_lengths(i)=(N+1)*(length(t)); % coherence lengths 
end
toc


% plot(Tx)

% 
% 
% %--------------------------------------------------------------------------
% %% Targets and receiver
% close all;
% Targ=30; % assuming target at 16.4 meters
% D=(Targ*2*Fs)/c;
% Rx=[Tx(end-D:end) Tx(1:(end-(D+1)))];
% % Rx=[zeros(1 , int32(D)) Tx(1:(end-(D+1)))]; %% add by me
% Rx = Rx + randn(1 ,length(Rx))/sqrt(2);%% add by me 
% Cm=zeros(1,M+1);
% for i=1:1:M+1
%     if i==1
%         Cm(i)=mean(Tx(1:corr_lengths(i)).*Rx(1:corr_lengths(i)));
%     else
%         Cm(i)=mean(Tx(corr_lengths(i-1)+1:corr_lengths(i)).*Rx(corr_lengths(i-1)+1:corr_lengths(i)));
%     end
% end
% scl = 2.5;
% figure
% % plot(1:1:length(Cm),Cm)
% % hold on 
% plot(1:1:length(cumsum(Cm)),cumsum(Cm))
% grid on
% title('cross correlation of SST as function of coherence lengths')
% xlabel('distance(m)')
% ylabel('cross correlation(Cm)')
% axis([1 M -inf inf])
% xt = get(gca, 'XTick');                                 % 'XTick' Values
% set(gca, 'XTick', xt, 'XTickLabel', xt/scl)
% CM=diff(Cm); % differentiating cross correlation
% [pk,loc]=max(CM);
% target_plc = (loc + 1 )/scl
% figure
% plot(1:1:length(CM),CM)
% grid on
% title('Derivative of cross correlation of SST as function of coherence lengths')
% xlabel('distance(m)')
% ylabel('cross correlation(CM)')
% xt = get(gca, 'XTick');                                 % 'XTick' Values
% set(gca, 'XTick', xt, 'XTickLabel', xt/scl)
