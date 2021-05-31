%%
function treeOut = genTree(depth, opts)
%generates tree
%checks for options
if isempty(opts) || (size(opts,2) < 2)
    maxSize = inf;
else
    % maximum size allowed
    a = find(opts(:) == "MaxSize");
    if isempty(a)
        maxSize = inf;
    else
        maxSize = opts(a(1)+1);
        maxSize = str2double(maxSize);
    end
end
%sets depth to maximum allowed value if too big
if depth > maxSize
    depth = maxSize;
end
% if tree is not valid depth return -1
if depth <= 0
    treeOut = -1;
elseif depth == 1
    % return just an endnode
    treeOut = tree(randEndNode(opts));
else
    % generate new tree
    treeOut = tree(randOperator(opts));
    %loop through all non endnodes excluding the root node and add
    %operators. Tree will be a perfect tree
    for i = 2:2^(depth- 1)-1
        treeOut = treeOut.addnode(floor(i/2),randOperator(opts));
    end
    %loop through end nodes and set to be numbers of variables
    for i = 2^(depth - 1) : 2^(depth)-1
        treeOut = treeOut.addnode(floor(i/2),randEndNode(opts));
    end  
end
end
