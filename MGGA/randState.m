function endNode = randState(opts)
%checks for options
if isempty(opts) || (size(opts,2) < 2)
statexSeed = 0;
StatexdotSeed = 0;
    StatethetaSeed = 0.5;
else
    %All state seeds should sum up to less than 1. StatexSeed should be the
    %odds of an x appearing. StatexdotSeed is the odds of an sdot
    %appearing, theta is the odds of a theta appearing and the remainder of
    %1 - all of those probabilities is the odds of theta dot. 
    a = find(opts(:) == "StatexSeed");
    if isempty(a)
        StatexSeed = 0;
    else
        StatexSeed = opts(a(1)+1);
        StatexSeed = str2double(StatexSeed);
    end
    a = find(opts(:) == "StatexdotSeed");
    if isempty(a)
        StatexdotSeed = 0;
    else
        StatexdotSeed = opts(a(1)+1);
        StatexdotSeed = str2double(StatexdotSeed);
    end
    a = find(opts(:) == "StatethetaSeed");
    if isempty(a)
        StatethetaSeed = 0.25;
    else
        StatethetaSeed = opts(a(1)+1);
        StatethetaSeed = str2double(StatethetaSeed);
    end
end

%generates a single random number between 0 and 1
b = rand;
%chooses a state variable to add

if b < StatethetaSeed
    endNode = 'theta';
else
    endNode = 'theta_dot';
end
end