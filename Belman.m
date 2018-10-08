clear
close
clc

global vlast beta delta theta k0 kt

figure(1)
hold off 
hold all
vlast=zeros(1,1000);
k0=linspace(5,20,1000);
beta=0.96;
delta=0.04;
theta=0.4;
numits=240;
for k=1:numits
    for j=1:1000
        kt=k0(j);
        ktp1=fminbnd(@valfun,4.5,kt);
        v(j)=-valfun(ktp1);
        kt1(j)=ktp1;
    end
    if k/2==round(k/2)
        plot(k0,v)
        drawnow
    end
    vlast=v;
end
hold off

figure(2)
hold on
plot(k0,kt1)
title('policy')

disp('finished')
