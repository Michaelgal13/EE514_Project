function cost = costClay(simOut)

t = simOut.xk.time;
X = simOut.xk.data;
ctrleff = simOut.xu.data;
totCtrl = trapz(t,ctrleff);
totX=trapz(t, X(:,1));
totXdot = trapz(t,X(:,2));
cost = abs(totCtrl + totX + totXdot);

%cost = y(1)^2;