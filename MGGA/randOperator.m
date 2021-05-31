function operator = randOperator(opts)
%check for options
if isempty(opts) || (size(opts,2) < 2)
    seed = 0.5;
else
    %option that sets odds of addition or multipliplication
    %must be between 0 and 1
    a = find(opts(:) == "OperatorSeed");
    if isempty(a)
        seed = 0.5;
    else
        seed = opts(a(1)+1);
        seed = str2double(seed);
    end
end
%randomly chooses and operator
if rand > seed
        operator = '&+';
    else
        operator = '&*';
    end
end