clc
clear all
close all
%%
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
simulinkModel = "motomatic_pend_V2_GA";
t = 10;
simFunct = "simFunctGA";
costFunction = "costFunction";
generations = 100;
population = 20;
initDepth = 5;
opts = ["MaxSize", 40, "MutationLoops", 2, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25,...
    "ElitismNumber", 1, "CrossoverNumber", floor(population/2), "ReplicationNumber", 1];
endCond = 1;
loadOld = 1;
loadingTest = "bestTest.mat";
if loadOld == 1
    loaded = load(loadingTest);
    treeList = loaded.treeList;
else
    for i = 1: population
        treeList(i) = genTree(initDepth, opts);
    end
end

for i = 1:generations
    treeRes = zeros(size(treeList,2),1);
    for  j = 1:population
        err = 0;
        str = parseTree(treeList(j), simFunct);
        timre = timer('TimerFcn', 'err = 1; set_param(simulinkModel,''SimulationCommand'',''stop'')',...
            'StartDelay',60);
        try
            start(timre);
            simOut = sim(simulinkModel, t);
            %         simOut = sim(simulinkModel, simTime);
            treeRes(j) = feval(costFunction, simOut);
        catch e
            %fprintf(1,'The identifier was:\n%s\n',e.identifier);
            fprintf(1,'There was an error! The message was:\n%s\n',e.message);
            fprintf("ERROR: Setting cost to inf\n");
            treeRes(j) = inf;
        end
        %testingIssue = simOut;
        stop(timre);
        delete(timre);
        if err ~= 0
            fprintf("TIMEOUT\n");
            treeRes(j) = inf;
        end
        fprintf("Currently: %d out of %d at %s\n", (i-1)*population + j, (generations)*population, datestr(now,'HH:MM:SS.FFF'));
    end
    genRes(i) = min(treeRes);
    figure(202)
    plot(1:i,genRes);
    xlim([1 generations]);
    xlabel("Generations");
    ylabel("Minimum Cost");
    [~,I] = min(treeRes);
    result = treeList(I);
    parseTree(result, simFunct);
    simOut = sim(simulinkModel, t);
    figure(101)
    subplot(2,2,1)
    % plot (t,simOut.xnew.Data(:,1)')
    plot (simOut.tout,simOut.X(:,1)')
    xlabel ('Time')
    ylabel ('Angle')
    subplot(2,2,2)
    % plot (t,simOut.xnew.Data(:,2)')
    plot (simOut.tout,simOut.X(:,2)')
    xlabel ('Time')
    ylabel ('Angular Velocity')
    subplot(2,2,3)
    %plot (t,simOut.xnew.Data(:,3)')
    plot (simOut.tout,simOut.ctrl_eff')
    xlabel ('Time')
    ylabel ('Effort')
    drawnow;
    pause(0.01)
    if endCond == 1
        if min(treeRes) == 0
            fprintf("End Condition Occured on generation %d at %s\n",i, datestr(now,'HH:MM:SS.FFF'));
            break;
        end
    end
    treeList = evolveGen(treeList, treeRes, opts);
    population = size(treeList,2);
end
%%
[~,I] = min(treeRes);
result = treeList(I);


%%
parseTree(result, simFunct);
simOut = sim(simulinkModel, t);
% simOut = sim(simulinkModel, simTime);
y = feval(costFunction, simOut);

figure(101)
subplot(2,2,1)
% plot (t,simOut.xnew.Data(:,1)')
plot (simOut.tout,simOut.X(:,1)')
xlabel ('Time')
ylabel ('Angle')
subplot(2,2,2)
% plot (t,simOut.xnew.Data(:,2)')
plot (simOut.tout,simOut.X(:,2)')
xlabel ('Time')
ylabel ('Angular Velocity')
subplot(2,2,3)
%plot (t,simOut.xnew.Data(:,3)')
plot (simOut.tout,simOut.ctrl_eff')
xlabel ('Time')
ylabel ('Effort')
% subplot(2,3,4)
% % plot (t,simOut.xnew.Data(:,4)')
% plot (simOut.tout,simOut.xnew.Data(:,4)')
% % xlabel ('Time')
% % ylabel ('Angular Velocity')
% subplot(2,3,5)
% plot (t,simOut.yout)
% plot (simOut.tout,simOut.yout)
% xlabel ('Time')
% ylabel ('Acutator Effort')
% xlabel ('Time')
% ylabel ('Magnitude')
% legend ({'Position', 'Velocity', 'Angle', 'Angular Velocity', 'Actuator Effort'}, 'Location', 'Best') 
sgtitle('Genetic Algorithm Results','interpreter','latex');

%%
% parseTree(result, simFunct);
% simOut = sim("untitled_pi5.slx", t);
% % simOut = sim(simulinkModel, simTime);
% y = feval(costFunction, simOut);
% 
% figure(201)
% subplot(2,3,1)
% % plot (t,simOut.xnew.Data(:,1)')
% plot (simOut.tout,simOut.xnew.Data(:,1)')
% xlabel ('Time')
% ylabel ('Position')
% subplot(2,3,2)
% % plot (t,simOut.xnew.Data(:,2)')
% plot (simOut.tout,simOut.xnew.Data(:,2)')
% xlabel ('Time')
% ylabel ('Velocity')
% subplot(2,3,3)
% % plot (t,simOut.xnew.Data(:,3)')
% plot (simOut.tout,simOut.xnew.Data(:,3)')
% xlabel ('Time')
% ylabel ('Angle')
% subplot(2,3,4)
% % plot (t,simOut.xnew.Data(:,4)')
% plot (simOut.tout,simOut.xnew.Data(:,4)')
% xlabel ('Time')
% ylabel ('Angular Velocity')
% subplot(2,3,5)
% % plot (t,simOut.yout)
% plot (simOut.tout,simOut.yout)
% xlabel ('Time')
% ylabel ('Acutator Effort')
% 
% sgtitle('Genetic Algorithm Results at$$\frac{\pi}{4}$$','interpreter','latex');
% 


%%
save('midTest', 'treeList', 'result', 'opts', 'population', 'generations', 'initDepth', 'simulinkModel')