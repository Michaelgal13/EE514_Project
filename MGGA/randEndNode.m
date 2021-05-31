function endNode = randEndNode(opts)
%checks for options
if isempty(opts) || (size(opts,2) < 2)
    seed = 0.5;
else
    %seed used to randomly choose the type of endnode must be between 0 and
    %1
    a = find(opts(:) == "EndNodeSeed");
    if isempty(a)
        seed = 0.5;
    else
        seed = opts(a(1)+1);
        seed = str2double(seed);
    end
end
%randomly chooses number or variable
if rand > seed
    endNode = randState(opts);
else
    endNode = randNumber(opts);
end