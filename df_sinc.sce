clear
clc
clf

//make sinc filter transfer function
function out=sincf(M)
    out=syslin('d',(1/M)*(1-%z^(-M))/(1-%z^-1))//discreted time system
endfunction

[frq1,amp1]=repfreq(sincf(2),0,0.5)
[frq2,amp2]=repfreq(sincf(3),0,0.5)
[frq3,amp3]=repfreq(sincf(4),0,0.5)

subplot(1,2,1)
plot(frq1,20*log10(amp1),frq2,20*log10(amp2),frq3,20*log10(amp3))
legend("M=2","M=3","M=4",1)
xgrid()
title("Sinc filter","fontsize",5)
xlabel("Normalized Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g1=gca();   //get axis object
g1.data_bounds(:,1)=[0;0.5];   //y axis scale
g1.data_bounds(:,2)=[-40;0];   //y axis scale
g1.font_size=3
e1=gce();
e1.font_size=3

[frq4,amp4]=repfreq(sincf(4),0,0.5)
[frq5,amp5]=repfreq(sincf(4)*sincf(4),0,0.5)
[frq6,amp6]=repfreq(sincf(4)*sincf(4)*sincf(4),0,0.5)

subplot(1,2,2)
plot(frq4,20*log10(amp4),frq5,20*log10(amp5),frq6,20*log10(amp6))
legend("1 cascaded","2 cascaded","3 cascaded",1)
xgrid()
title("Sinc filter","fontsize",5)
xlabel("Normalized Freq [Hz]","fontsize",5)
ylabel("Amplitude [dB]","fontsize",5)
g1=gca();   //get axis object
g1.data_bounds(:,1)=[0;0.5];   //y axis scale
g1.data_bounds(:,2)=[-40;0];   //y axis scale
g1.font_size=3
e1=gce();
e1.font_size=3
