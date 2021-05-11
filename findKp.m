clc
close all
clear
%%
position = readtable("PositionSensorOrig.csv");
timeOut = position.Time_s_;
Vin = position.Channel2_V_;
Vp = position.Math1_V_;

plot(timeOut, Vp);

zeros = [];
VPlast = Vp(1);
VPCur = Vp(2);
for i = 2:size(Vp,1)
    if VPlast > 0 && VPCur < 0
        zeros = [zeros; timeOut(i), Vin(i), Vp(i)];
    end
    VPlast = Vp(i-1);
    VPCur = Vp(i);
end

tRev = zeros(4,1) - zeros(2,1);

%choosing 0.7 seconds as low end and 1.1 as high end
liveZone = 2 * pi * (1.1-0.7)/tRev;
denom = 2*pi - ((abs(zeros(2,1) - 0.7))+abs((zeros(4,1) - 1.1)));
num = Vp(5201) - Vp(3601);


Kp1 = num/denom;
Kp1p = num/liveZone;

figure
plot(timeOut(3601:5201), Vp(3601:5201));

%choosing 0.1 seconds as low end and 0.5 as high end
liveZone = 2 * pi * (0.5-0.1)/tRev;
denom = 2*pi - (abs(zeros(2,1) - 0.5)+abs(zeros(1,1) - 0.1));
num = Vp(2801) - Vp(1201);


Kp2 = num/denom;
Kp2p = num/liveZone;
figure
plot(timeOut(1201:2801), Vp(1201:2801));


Kpave = (Kp1+Kp2)/2;
Kpavep = (Kp1p+Kp2p)/2;

timeRad2 = timeOut(897:3225);
VpRad2 = Vp(897:3225);

radRad2 = (timeRad2-0.024) .* (2*pi/tRev);
x = linspace(0,7);
y = Kp2p*x + (1.4485-17);

B1 = radRad2\VpRad2;

xb1 =  linspace(0,7);
yb1 = B1*x;
figure
hold on
plot(radRad2, VpRad2);
line(x,y, 'Color', 'black', 'LineStyle', '--');
xlabel('Radians');
ylabel('Vp');
legend('Data', 'Calculated Kp','Location', 'North West');
im = [.2 .5 .3 .3];
str = 'y = Kp*x-';
annotation('textbox',dim,'String',str,'FitBoxToText','on');

hold off
