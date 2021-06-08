clc
clear all
close all
%%
%Defining Physical Parameters and Sensor Gains
%The following lines of code will define the sensor gains and physical parameters used for the simulation.
Ka     = 5.1793;     % Power Amplifier
N      = 8.1;        % Speed Reduction Factor
Km     = 22.289;     % Motor gain [rad/s/V]
Km_lin = 19.763;     % Linearized motor gain [rad/s/V]
tau_m  = .2740;      % Motor time constant [s]
Kp     = 4.90379;    % Position Feedback Gain
Kt     = .1429;
vmo    = 0.66;       % Voltage to hold pendulum at 90 degrees [V]
g      = 9.81;       % gravitational acceleration [m/s/s]
%Defining physical parameters of the pendulum
L = 11;      % Pendulum rod length [in]
L = L/39.37; % Pendulum rod length [m]
m = 28/1000; % Bob mass [kg]
physParam = [m, L, g, vmo, N];
%The next line will define the intial condition of the pendulum
th_init = deg2rad(110);
%%
simulinkModel = "motomatic_pendGA.slx";
simTime = 5;
simFunct = "simFunctGA";
costFunction = 'costClay';
% costFunction = 'costFunction';
generations = 10;
population = 10;
initDepth = 5;
opts = ["MaxSize", 30, "MutationLoops", 2, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25,...
    "ElitismNumber", 1, "CrossoverNumber", 1, "ReplicationNumber", 1, ...
    "StatexSeed", 0, "StatexdotSeed", 0];


for i = 1: population
    treeList(i) = genTree(initDepth, opts);
end

for i = 1:generations
    treeRes = zeros(size(treeList,2),1);
    for  j = 1:population
        str = parseTree(treeList(j), simFunct);
        try
        simOut = sim(simulinkModel, simTime);
        treeRes(j) = feval(costFunction, simOut);
        catch
        fprintf("ERROR: Setting cost to inf\n");
        treeRes(j) = inf;
        end
        fprintf("Currently: %d out of %d\n", (i-1)*population + j, (generations)*population);
    end
    treeList = evolveGen(treeList, treeRes, opts);
    population = size(treeList,2);
    
end
[~,I] = min(treeRes);
result = treeList(I);


%%
parseTree(result, simFunct);
simOut = sim(simulinkModel, simTime);
%%
cost = feval(costFunction, simOut);

t = simOut.xk.time;
X = simOut.xk.data;
ctrleff = simOut.xu.data;

figure
hold on
plot(t, ctrleff);
plot(t, X(:,1));
plot(t, X(:,2));
hold off
