clear
clc
clf

TAP=21
band1=[0 0.1];
band2=[0.2 0.5];
Fs=1000     //Sampling frequency
L=1000;     //Length of signal
Freq=100;   //signal freq
B=16;    //bit resolution

h=eqfir(TAP,[band1;band2],[1 0],[1 1]);

//show coefficient
txt="{";
for i=1:size(h)(2)-1
    tp=string(int(h(i)*2^B))+", ";
    txt=txt+tp;
end
txt=txt+string(int(h(size(h)(1))*2^B))+"}";
disp(txt);

[hm,fr]=frmag(h,200); //calc freq response
[del,frq]=group(100,h);     //calc group delay
del(1)=del(2);

subplot(2,3,1)
plot(h,"o-")    //plot impulse response (also coefficient)
xgrid()
title("Impulse Response","fontsize",5)
xlabel("Time","fontsize",5)
ylabel("Amplitude","fontsize",5)
hp=gca();   //get axis object
hp.data_bounds(:,2)=[-0.5;0.5];   //y axis scale
hp.font_size=3

subplot(2,3,2)
plot(fr,20*log10(hm),"o-")  //plot freq response
xgrid()
title("Freq Response","fontsize",5)
xlabel("Normalized Freq","fontsize",5)
ylabel("Gain [dB]","fontsize",5)
gp=gca();   //get axis object
gp.data_bounds(:,1)=[0;0.5];    ///x axis scale
gp.data_bounds(:,2)=[-100;10];   //y axis scale
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
for i=1:L
    if sin(2*%pi*Freq*t(i))>=0  //rect
        y2(1,i)=1;
    else
        y2(1,i)=-1;
    end
end

//process filter
lfsr1=zeros(1,size(h)(2));
for i=1:L
    lfsr1=cat(2,y1(i),lfsr1(1:size(h)(2)-1))
    out1(1,i)=sum(h.*lfsr1)
end

subplot(2,2,3)
plot(t,y1,"o-",t,out1,"o-")
legend("Input", "Output", 1)
xgrid()
title("Sin Input/Output","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
gs=gca();   //get axis object
gs.data_bounds(:,1)=[0;10/Freq];    //x axis scale
gs.data_bounds(:,2)=[-1.2;1.2];   //y axis scale
gs.font_size=3
e1=gce();
e1.font_size=3

//process filter
lfsr2=zeros(1,size(h)(2));
for i=1:L
    lfsr2=cat(2,y2(i),lfsr2(1:size(h)(2)-1))
    out2(1,i)=sum(h.*lfsr2)
end

subplot(2,2,4)
plot(t,y2,"o-",t,out2,"o-")
legend("Input", "Output", 1)
xgrid()
title("Rect. Input/Output","fontsize",5)
xlabel("Time [s]","fontsize",5)
ylabel("Amplitude","fontsize",5)
gt=gca();   //get axis object
gt.data_bounds(:,1)=[0;10/Freq];    //x axis scale
gt.data_bounds(:,2)=[-1.2;1.2];   //y axis scale
gt.font_size=3
e2=gce();
e2.font_size=3
