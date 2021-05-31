function cost = costFunction(simOut)

t = simOut.tout;
X = simOut.X;
ctrleff = simOut.ctrl_eff;
totCtrl = trapz(t,ctrleff);
totX=trapz(t, X(:,1));
totXdot = trapz(t,X(:,2));
cost = abs(totCtrl + totX + totXdot);

%cost = y(1)^2;