clear
clc
clf

Fs=1000     //Sampling frequency
L=1000;     //Length of signal
Freq=110;   //signal freq

h=[1 1 1 1 1 1 1];
TAP=length(h)
[hm,fr]=frmag(h,100);   //calc freq response

[del,frq]=group(100,h);     //calc group delay
del(1)=del(2);

subplot(2,3,1)
plot(h,"o-")    //plot impulse response (also coefficient)
xgrid()
title("Impulse Response","fontsize",5)
xlabel("Time","fontsize",5)
ylabel("Amplitude","fontsize",5)
hp=gca();   //get axis object
//hp.data_bounds(:,2)=[-1;1];   //y axis scale
hp.font_size=3

subplot(2,3,2)
plot(fr,20*log10(hm),"o-")  //plot freq response
xgrid()
title("Freq Response","fontsize",5)
xlabel("Normalized Freq","fontsize",5)
ylabel("Gain [dB]","fontsize",5)
gp=gca();   //get axis object
gp.data_bounds(:,1)=[0;0.5];    ///x axis scale
//gp.data_bounds(:,2)=[-40;10];   //y axis scale
gp.font_size=3

subplot(2,3,3)
plot(frq,del,"o-")
xgrid()
title("Group Delay","fontsize",5)
xlabel("Normalized Freq","fontsize",5)
ylabel("Delay [samples]","fontsize",5)
gr=gca();   //get axis object
gr.data_bounds(:,1)=[0;0.5];    ///x axis scale
gr.data_bounds(:,2)=[0;20];   //y axis scale
gr.font_size=3

//gen. time vector and waves
t=0:1/Fs:(L-1)/Fs;    //time vector
y1=sin(2*%pi*Freq*t);

//process filter
lfsr1=zeros(1,size(h)(2));
for i=1:L
    lfsr1=cat(2,y1(i),lfsr1(1:size(h)(2)-1))
    out1(1,i)=sum(h.*lfsr1)
end

subplot(2,1,2)
plot(t(1:L-TAP/2),y1(TAP/2+1:L),"o-",t,out1,"o-")
legend("Re", "Im", 1)
xgrid()
title("Input/Output","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
gt=gca();   //get axis object
gt.data_bounds(:,1)=[0;10/Freq];    //x axis scale
gt.data_bounds(:,2)=[-1.2;1.2];   //y axis scale
gt.font_size=3
e2=gce();
e2.font_size=3
