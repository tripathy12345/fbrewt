clc;
clear all;
close all;

%%%%%%%%%%FFREWT Filter bank%%%%%%
%%%%if you use this code, please cite the following paper%%%%%%%%%
%Panda, R., Jain, S., Tripathy, R. K., & Acharya, U. R. (2020).
%Detection of shockable ventricular cardiac arrhythmias from ECG signals using FFREWT 
%filter-bank and deep convolutional neural network. Computers in Biology and Medicine, 124, 103939.
%%%%%Rohan Panda, Sahil Jain, Rajesh Kumar Tripathy, BITS Hyderabad%%%%%%%%%

load sl01t01_walking.mat;
Fs=100;
f=x1';
N=length(f);
params.SamplingRate=Fs;
       
ff=fft(f);
freq=[5 10 15 20 25 30 35 40]; %%%%%you can change this range
boundaries=(2*pi*freq)/Fs;
% We build the corresponding filter bank
div=1;
mfb=EWT_Meyer_FilterBank(boundaries,length(ff));
 Show_EWT_Boundaries(abs(fft(f)),boundaries,div,params.SamplingRate);
 figure
 xxx=(linspace(0,1,round(length(mfb{1,1}))))*Fs;
for i=1:size(mfb)
plot(xxx,mfb{i,1})
hold on
end
xlim([0 Fs/2])
ylim([0 2])
% We filter the signal to extract each subband
ewt=cell(length(mfb),1);
for k=1:length(mfb)
    mm=real(ifft(conj(mfb{k}).*ff));
    ewt{k}=mm;
    modes(k,:)=mm;
end

