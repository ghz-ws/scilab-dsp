clear
clc
clf

//make sinc filter transfer function
function out=sincf(M)
    out=syslin('d',(1-%z^(-M))/(1-%z^-1))//discreted time system
endfunction

rate=32
cas=4

[frq1,amp1]=repfreq(sincf(rate)^cas,0,0.5,0.001)

plot(frq1,20*log10(amp1))
xgrid()
title("CIC filter","fontsize",5)
xlabel("Normalized Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g1=gca();   //get axis object
g1.data_bounds(:,1)=[0;0.5];   //y axis scale
g1.data_bounds(:,2)=[-60;120];   //y axis scale
g1.font_size=3
