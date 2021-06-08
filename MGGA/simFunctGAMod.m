function k = simFunctGAMod(in1, in2)
Ka     = 5.1793;     % Power Amplifier
N      = 8.1;        % Speed Reduction Factor
Km     = 22.289;     % Motor gain [rad/s/V]
Km_lin = 19.763;     % Linearized motor gain [rad/s/V]
tau_m  = .2740;      % Motor time constant [s]
Kp     = 4.90379;    % Position Feedback Gain [V/rad]
Kt     = .1429;      % Tachometer Gain [V/rad/s]
theta = in1 * -1/Kp;
theta_dot = in2 * -1/Kt/N;

k = plus(plus(times(times(2,theta),4.5),plus(theta,theta_dot)),plus(plus(plus(theta_dot,plus(theta,plus(plus(theta,theta_dot),times(-1,theta_dot)))),times(-1,theta_dot)),theta));
k=k * 1/-Ka;
