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
dim = [.2 .5 .3 .3];
str = 'y = Kp*x-';
annotation('textbox',dim,'String',str,'FitBoxToText','on');

hold off

%%
% clc
% clear 
% close all
%%
cycle = readtable("PositionCycleOrig.csv");

figure
plot(cycle.Time_s_, cycle.Math1_V_);

% -5.16 to -4.6125
% -4.17 to -3.595
% -3.1575 to - 2.595
% -2.1575 to -1.5975
% -1.16 to -0.5975
% -0.1625 to 0.4025
% 0.855 to 1.4025
% 1.8375 to 2.3875
% 2.8375 to 3.4
% 3.8425 to 4.3825
% 4.84 to 5.405
% 5.85 to 6.4
% 6.84 to 7.365

data1 = [cycle.Time_s_(1550:1775), cycle.Math1_V_(1550:1775)]; % -5.16 to -4.6125
data2 = [cycle.Time_s_(1950:2175), cycle.Math1_V_(1950:2175)]; % -4.17 to -3.595
data3 = [cycle.Time_s_(2350:2575), cycle.Math1_V_(2350:2575)]; % -3.1575 to - 2.595
data4 = [cycle.Time_s_(2750:2975), cycle.Math1_V_(2750:2975)]; % -2.1575 to -1.5975
data5 = [cycle.Time_s_(3150:3375), cycle.Math1_V_(3150:3375)]; % -1.16 to -0.5975
data6 = [cycle.Time_s_(3550:3775), cycle.Math1_V_(3550:3775)]; % -0.1625 to 0.4025
data7 = [cycle.Time_s_(3950:4175), cycle.Math1_V_(3950:4175)]; % 0.855 to 1.4025
data8 = [cycle.Time_s_(4350:4575), cycle.Math1_V_(4350:4575)]; % 1.8375 to 2.3875
data9 = [cycle.Time_s_(4750:4975), cycle.Math1_V_(4750:4975)]; % 2.8375 to 3.4
dataA = [cycle.Time_s_(5150:5375), cycle.Math1_V_(5150:5375)]; % 3.8425 to 4.3825
dataB = [cycle.Time_s_(5550:5775), cycle.Math1_V_(5550:5775)]; % 4.84 to 5.405
dataC = [cycle.Time_s_(5950:6175), cycle.Math1_V_(5950:6175)]; % 5.85 to 6.4
dataD = [cycle.Time_s_(6350:6575), cycle.Math1_V_(6350:6575)]; % 6.84 to 7.365

slop1 = (max(data1(:,2))- min(data1(:,2)))/(max(data1(:,1))- min(data1(:,1)));
slop2 = (max(data2(:,2))- min(data2(:,2)))/(max(data2(:,1))- min(data2(:,1)));
slop3 = (max(data3(:,2))- min(data3(:,2)))/(max(data3(:,1))- min(data3(:,1)));
slop4 = (max(data4(:,2))- min(data4(:,2)))/(max(data4(:,1))- min(data4(:,1)));
slop5 = (max(data5(:,2))- min(data5(:,2)))/(max(data5(:,1))- min(data5(:,1)));
slop6 = (max(data6(:,2))- min(data6(:,2)))/(max(data6(:,1))- min(data6(:,1)));
slop7 = (max(data7(:,2))- min(data7(:,2)))/(max(data7(:,1))- min(data7(:,1)));
slop8 = (max(data8(:,2))- min(data8(:,2)))/(max(data8(:,1))- min(data8(:,1)));
slop9 = (max(data9(:,2))- min(data9(:,2)))/(max(data9(:,1))- min(data9(:,1)));
slopA = (max(dataA(:,2))- min(dataA(:,2)))/(max(dataA(:,1))- min(dataA(:,1)));
slopB = (max(dataB(:,2))- min(dataB(:,2)))/(max(dataB(:,1))- min(dataB(:,1)));
slopC = (max(dataC(:,2))- min(dataC(:,2)))/(max(dataC(:,1))- min(dataC(:,1)));
slopD = (max(dataD(:,2))- min(dataD(:,2)))/(max(dataD(:,1))- min(dataD(:,1)));


% for i = 1:size(data,1)
%     data(i,3) = (i-1)*0.0005;
% end
%     
% figure
% hold on
% plot(data(:,3), data(:,2));
% 
% p1 = polyfit(data(:,3), data(:,2), 1);
% p2 = polyfit(data(:,3), data(:,2), 2);
% p3 = polyfit(data(:,3), data(:,2), 3);
% p4 = polyfit(data(:,3), data(:,2), 4);
% p5 = polyfit(data(:,3), data(:,2), 5);
% p6 = polyfit(data(:,3), data(:,2), 6);
% p7 = polyfit(data(:,3), data(:,2), 7);
% p8 = polyfit(data(:,3), data(:,2), 8);
% p9 = polyfit(data(:,3), data(:,2), 9);
% pA = polyfit(data(:,3), data(:,2), 10);
% 
% y1 = polyval(p1, data(:,3));
% y2 = polyval(p2, data(:,3));
% y3 = polyval(p3, data(:,3));
% y4 = polyval(p4, data(:,3));
% y5 = polyval(p5, data(:,3));
% y6 = polyval(p6, data(:,3));
% y7 = polyval(p7, data(:,3));
% y8 = polyval(p8, data(:,3));
% y9 = polyval(p9, data(:,3));
% yA = polyval(pA, data(:,3));
% 
% 
% 
% plot(data(:,3),y1);
% plot(data(:,3),y2);
% plot(data(:,3),y3);
% plot(data(:,3),y4);
% plot(data(:,3),y5);
% plot(data(:,3),y6);
% plot(data(:,3),y7);
% plot(data(:,3),y8);
% plot(data(:,3),y9);
% plot(data(:,3),yA);


hold off

%%

horVals = 1:13;
vertVals = [slop1, slop2, slop3, slop4, slop5, slop6, slop7, slop8, slop9, slopA, slopB, slopC, slopD];

%plot(horVals,vertVals);

average = mean(vertVals);

totslop = sum(vertVals);
vertNorm = vertVals./totslop;
horNorm = 2*pi .* vertNorm;
for i = size(horNorm,2) : -1: 1
    horNorm(i) = sum(horNorm(1:i));
end
figure
plot(horNorm, vertVals);
figure
hold on
plot(horNorm, vertVals);
%225 step time steps
p1 = polyfit(horNorm, vertVals, 1);
p2 = polyfit(horNorm, vertVals, 2);
p3 = polyfit(horNorm, vertVals, 3);
p4 = polyfit(horNorm, vertVals, 4);
p5 = polyfit(horNorm, vertVals, 5);
p6 = polyfit(horNorm, vertVals, 6);
p7 = polyfit(horNorm, vertVals, 7);
p8 = polyfit(horNorm, vertVals, 8);
p9 = polyfit(horNorm, vertVals, 9);
pA = polyfit(horNorm, vertVals, 10);

y1 = polyval(p1, horNorm);
y2 = polyval(p2, horNorm);
y3 = polyval(p3, horNorm);
y4 = polyval(p4, horNorm);
y5 = polyval(p5, horNorm);
y6 = polyval(p6, horNorm);
y7 = polyval(p7, horNorm);
y8 = polyval(p8, horNorm);
y9 = polyval(p9, horNorm);
yA = polyval(pA, horNorm);



plot(horNorm,y1);
plot(horNorm,y2);
plot(horNorm,y3);
plot(horNorm,y4);
plot(horNorm,y5);
plot(horNorm,y6);
plot(horNorm,y7);
plot(horNorm,y8);
plot(horNorm,y9);
plot(horNorm,yA);

legend("Stepwise", "Polyfit 1", "Polyfit 2", "Polyfit 3", "Polyfit 4", "Polyfit 5", "Polyfit 6", "Polyfit 7", "Polyfit 8", "Polyfit 9", "Polyfit 10")


hold off

%%
% find tau m
checkConst = 20;

movdat1 =[ data1(:,1) movmean(data1(:,2), 10)];
movdat2 =[ data2(:,1) movmean(data2(:,2), 10)];
movdat3 =[ data3(:,1) movmean(data3(:,2), 10)];
movdat4 =[ data4(:,1) movmean(data4(:,2), 10)];
movdat5 =[ data5(:,1) movmean(data5(:,2), 10)];
movdat6 =[ data6(:,1) movmean(data6(:,2), 10)];
movdat7 =[ data7(:,1) movmean(data7(:,2), 10)];
movdat8 =[ data8(:,1) movmean(data8(:,2), 10)];
movdat9 =[ data9(:,1) movmean(data9(:,2), 10)];
movdatA =[ dataA(:,1) movmean(dataA(:,2), 10)];
movdatB =[ dataB(:,1) movmean(dataB(:,2), 10)];
movdatC =[ dataC(:,1) movmean(dataC(:,2), 10)];
movdatD =[ dataD(:,1) movmean(dataD(:,2), 10)];

tm1 = inf;
for i = 1: size(movdat1,1) - checkConst
    if (abs(movdat1(i + checkConst,2)- movdat1(i,2)))/(abs(movdat1(i + checkConst, 1)- movdat1(i,1))) >= (0.63 * slop1)
        tm1 = abs(movdat1(i + checkConst, 1) - movdat1(1, 1));
        break;
    end
end
    
tm2 = inf;
for i = 1: size(movdat2,1) - checkConst
    if (abs(movdat2(i + checkConst,2)- movdat2(i,2)))/(abs(movdat2(i + checkConst, 1)- movdat2(i,1))) >= (0.63 * slop1)
        tm2 = abs(movdat2(i + checkConst, 1) - movdat2(1, 1));
        break;
    end
end

tm3 = inf;
for i = 1: size(movdat3,1) - checkConst
    if (abs(movdat3(i + checkConst,2)- movdat3(i,2)))/(abs(movdat3(i + checkConst, 1)- movdat3(i,1))) >= (0.63 * slop1)
        tm3 = abs(movdat3(i + checkConst, 1) - movdat3(1, 1));
        break;
    end
end

tm4 = inf;
for i = 1: size(movdat4,1) - checkConst
    if (abs(movdat4(i + checkConst,2)- movdat4(i,2)))/(abs(movdat4(i + checkConst, 1)- movdat4(i,1))) >= (0.63 * slop1)
        tm4 = abs(movdat4(i + checkConst, 1) - movdat4(1, 1));
        break;
    end
end

tm5 = inf;
for i = 1: size(movdat5,1) - checkConst
    if (abs(movdat5(i + checkConst,2)- movdat5(i,2)))/(abs(movdat5(i + checkConst, 1)- movdat5(i,1))) >= (0.63 * slop1)
        tm5 = abs(movdat5(i + checkConst, 1) - movdat5(1, 1));
        break;
    end
end

tm6 = inf;
for i = 1: size(movdat6,1) - checkConst
    if (abs(movdat6(i + checkConst,2)- movdat6(i,2)))/(abs(movdat6(i + checkConst, 1)- movdat6(i,1))) >= (0.63 * slop1)
        tm6 = abs(movdat6(i + checkConst, 1) - movdat6(1, 1));
        break;
    end
end

tm7 = inf;
for i = 1: size(movdat7,1) - checkConst
    if (abs(movdat7(i + checkConst,2)- movdat7(i,2)))/(abs(movdat7(i + checkConst, 1)- movdat7(i,1))) >= (0.63 * slop1)
        tm7 = abs(movdat7(i + checkConst, 1) - movdat7(1, 1));
        break;
    end
end

tm8 = inf;
for i = 1: size(movdat8,1) - checkConst
    if (abs(movdat8(i + checkConst,2)- movdat8(i,2)))/(abs(movdat8(i + checkConst, 1)- movdat8(i,1))) >= (0.63 * slop1)
        tm8 = abs(movdat8(i + checkConst, 1) - movdat8(1, 1));
        break;
    end
end

tm9 = inf;
for i = 1: size(movdat9,1) - checkConst
    if (abs(movdat9(i + checkConst,2)- movdat9(i,2)))/(abs(movdat9(i + checkConst, 1)- movdat9(i,1))) >= (0.63 * slop1)
        tm9 = abs(movdat9(i + checkConst, 1) - movdat9(1, 1));
        break;
    end
end

tmA = inf;
for i = 1: size(movdatA,1) - checkConst
    if (abs(movdatA(i + checkConst,2)- movdatA(i,2)))/(abs(movdatA(i + checkConst, 1)- movdatA(i,1))) >= (0.63 * slop1)
        tmA = abs(movdatA(i + checkConst, 1) - movdatA(1, 1));
        break;
    end
end

tmB = inf;
for i = 1: size(movdatB,1) - checkConst
    if (abs(movdatB(i + checkConst,2)- movdatB(i,2)))/(abs(movdatB(i + checkConst, 1)- movdatB(i,1))) >= (0.63 * slop1)
        tmB = abs(movdatB(i + checkConst, 1) - movdatB(1, 1));
        break;
    end
end


tmC = inf;
for i = 1: size(movdatC,1) - checkConst
    if (abs(movdatC(i + checkConst,2)- movdatC(i,2)))/(abs(movdatC(i + checkConst, 1)- movdatC(i,1))) >= (0.63 * slop1)
        tmC = abs(movdatC(i + checkConst, 1) - movdatC(1, 1));
        break;
    end
end


tmD = inf;
for i = 1: size(movdatD,1) - checkConst
    if (abs(movdatD(i + checkConst,2)- movdatD(i,2)))/(abs(movdatD(i + checkConst, 1)- movdatD(i,1))) >= (0.63 * slop1)
        tmD = abs(movdatD(i + checkConst, 1) - movdatD(1, 1));
        break;
    end
end

horVals = 1:13;
vertVals = [tm1, tm2, tm3, tm4, tm5, tm6, tm7, tm8, tm9, tmA, tmB, tmC, tmD];
avCalc = mean(vertVals);
vertVals = (vertVals./avCalc).*0.274;

%plot(horVals,vertVals);

average = mean(vertVals);

totslop = sum(vertVals);
vertNorm = vertVals./totslop;
horNorm = 2*pi .* vertNorm;
for i = size(horNorm,2) : -1: 1
    horNorm(i) = sum(horNorm(1:i));
end
figure
plot(horNorm - pi, vertVals);
title("tau m");
figure
hold on
plot(horNorm - pi, vertVals);

%225 step time steps
p1 = polyfit(horNorm, vertVals, 1);
p2 = polyfit(horNorm, vertVals, 2);
p3 = polyfit(horNorm, vertVals, 3);
p4 = polyfit(horNorm, vertVals, 4);
p5 = polyfit(horNorm, vertVals, 5);
p6 = polyfit(horNorm, vertVals, 6);
p7 = polyfit(horNorm, vertVals, 7);
p8 = polyfit(horNorm, vertVals, 8);
p9 = polyfit(horNorm, vertVals, 9);
pA = polyfit(horNorm, vertVals, 10);
xvalues = linspace(0.47, 2*pi, 1000);
y1 = polyval(p1, xvalues);
y2 = polyval(p2, xvalues);
y3 = polyval(p3, xvalues);
y4 = polyval(p4, xvalues);
y5 = polyval(p5, xvalues);
y6 = polyval(p6, xvalues);
y7 = polyval(p7, xvalues);
y8 = polyval(p8, xvalues);
y9 = polyval(p9, xvalues);
yA = polyval(pA, xvalues);



%plot(xvalues,y1);
%plot(xvalues,y2);
%plot(xvalues,y3);
%plot(xvalues,y4);
%plot(xvalues,y5);
%plot(xvalues,y6);
%plot(xvalues,y7);
%plot(xvalues,y8);
%plot(xvalues,y9);
plot(xvalues - pi,yA);
title('$\tau_m$','Interpreter','Latex','FontSize',12);
legend("Stepwise", "Polyfit 10", "Polyfit 2", "Polyfit 3", "Polyfit 4", "Polyfit 5", "Polyfit 6", "Polyfit 7", "Polyfit 8", "Polyfit 9", "Polyfit 10")
xlim([-pi pi]);

xlabel("Radians");
ylabel("Time (s)");
hold off
