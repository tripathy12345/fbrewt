function Show_EWT_Boundaries(magf,boundaries,R,SamplingRate,InitBounds,presig)

%===============================================================================
% function Show_EWT_Boundaries(magf,boundaries,R,SamplingRate,InitBounds,presig)
% 
% This function plot the boundaries by superposition on the graph 
% of the magnitude of the Fourier spectrum on the frequency interval 
% [0,pi]. If the sampling rate is provided, then the horizontal axis
% will correspond to the real frequencies. If provided, the plot will
% superimposed a set of initial boundaries (in black). The input presig 
% will be superimposed on the original plot (useful to visualize regularized 
% version of magf)
%
% Input:
%   - magf: magnitude of the Fourier spectrum
%   - boundaries: list of all boundaries
%   - R: ratio to plot only a portion of the spectrum (we plot the
%        interval [0,pi/R]. R must be >=1
%   - SamplingRate: sampling rate used during the signal acquisition (must
%                   be set to -1 if it is unknown)
%		- InitBounds: initial bounds when you use an adaptive detection method
%		- presig: preprocessed version of the spectrum on which the detection is made
%
% Optional inputs:
%   - InitBounds: optional initial boundaries
%   - presig: preprocessed signal
%
% Author: Jerome Gilles
% Institution: UCLA - Department of Mathematics
% Year: 2013
% Version: 2.0
%===============================================================================

figure;
freq=2*pi*[0:length(magf)-1]/length(magf);

if SamplingRate~=-1
    freq=freq*SamplingRate/(2*pi);
    boundaries=boundaries*SamplingRate/(2*pi);
end

if R<1
    R=1;
end
R=round(length(magf)/(2*R));
plot(freq(1:R),magf(1:R));
hold on
if nargin>5
   plot(freq(1:R),presig(1:R),'color',[0,0.5,0],'LineWidth',2); 
end
NbBound=length(boundaries);
 
for i=1:NbBound
     if boundaries(i)>freq(R)
         break
     end
     %line([boundaries(i)-2*pi/length(magf) boundaries(i)-2*pi/length(magf)],[0 max(magf)],'LineWidth',2,'LineStyle','--','Color',[1 0 0]);
     line([boundaries(i) boundaries(i)],[0 max(magf)],'LineWidth',2,'LineStyle','--','Color',[1 0 0]);
end
 
if nargin>4
    NbBound=length(InitBounds);
    InitBounds=InitBounds*2*pi/length(magf);
    
    for i=1:NbBound
        if InitBounds(i)>freq(R)
            break
        end
        line([InitBounds(i) InitBounds(i)],[0 max(magf)],'LineWidth',1,'LineStyle','--','Color',[0 0 0]);
    end
end
