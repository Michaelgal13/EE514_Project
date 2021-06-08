function cost = costFunction(simOut)

%set State Values to defined Q and R matrices to generate the same results
%as in the paper
Q = [10, 0; 0, 0];
R = 1/10000;
x = [   simOut.X(:,1)';...
        simOut.X(:,2)'];

t = simOut.tout;
u = simOut.ctrl_eff;
%X = simOut.X;
cost = 0;
for i=2:length(t)
    cost =  cost + (x(:,i)'*Q*x(:,i) + u(i)'*R*u(i)).*(t(i)-t(i-1));
end

l = 1;
% ctrleff = simOut.ctrl_eff;
% totCtrl = trapz(t,ctrleff);
% totX=trapz(t, X(:,1));
% totXdot = trapz(t,X(:,2));
% cost = abs(totCtrl + totX + totXdot);

%cost = y(1)^2;