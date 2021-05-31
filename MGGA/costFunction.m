function cost = costFunction(simOut)

t = simOut.tout;
y = simOut.yout;

cost = y(1)^2;