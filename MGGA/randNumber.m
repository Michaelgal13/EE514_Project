function operator = randNumber(opts)
%check for inputs
if isempty(opts) || (size(opts,2) < 2)
    % default cases
    numMax = 4;
    numLim = 0.5;
else
    %Check for specific inputs
    % Maximum absolute value allowed for end numbers
    a = find(opts(:) == "NumberMax");
    if isempty(a)
        numMax = 4;
    else
        numMax = opts(a(1)+1);
        numMax = str2double(numMax);
    end
    % delimiter controlling steps between -numMax and numMax
    a = find(opts(:) == "NumberDelims");
    if isempty(a)
        numLim = 0.5;
    else
        numLim = opts(a(1)+1);
        numLim = str2double(numLim);
    end
end
%create list of numbers from -numMax to numMax
a = -numMax:numLim:numMax;
%choose a random number from the list
val = cast(rand * size(a,2) + 1, 'int32');
%check the number's validity
if val > size(a,2)
    val = size(a,2);
elseif val <= 0
    val = 1;
end
%return the number
operator = a(val);
end