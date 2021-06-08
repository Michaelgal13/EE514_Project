function k = simFunct(x, xdot, theta, thetadot)
k = times(times(times(plus(theta,xdot),plus(4,theta)),times(plus(-7,xdot),plus(5.5,-1))),times(times(times(xdot,xdot),times(theta,-9.5)),plus(plus(-1.5,-6),times(xdot,xdot))));
