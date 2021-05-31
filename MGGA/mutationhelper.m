function endTree = mutationhelper(tree, opts)
%checks for options
if isempty(opts) || (size(opts,2) < 2)
    loops = 1;
    mutDepth = 4;
    maxSize = inf;
else
    %number of mutations per cycle
    a = find(opts(:) == "MutationLoops");
    if isempty(a)
        loops = 1;
    else
        loops = opts(a(1)+1);
        loops = str2double(loops);
    end
    % maximum size of generated tree
    a = find(opts(:) == "MutationDepth");
    if isempty(a)
        mutDepth = 4;
    else
        mutDepth = opts(a(1)+1);
        mutDepth = str2double(mutDepth);
    end
    % maximum size allowed
    a = find(opts(:) == "MaxSize");
    if isempty(a)
        maxSize = inf;
    else
        maxSize = opts(a(1)+1);
        maxSize = str2double(maxSize);
    end
end
% loops number of times set by options
for i = 1: loops
    %randomly choose tree node
    val = cast(rand * tree.nnodes() + 1, 'int32');
    %checks node validity
    if val > tree.nnodes()
        val = tree.nnodes();
    elseif val <= 0
        val = 1;
    end
    %checks if the new tree will be too deep and fixes it
    deep1 = depth(tree);
    deep2 = depth(tree.subtree(val));
    newDeep2 = rand * mutDepth;
    if newDeep2 < 1
        newDeep2 = 1;
    elseif (deep1-deep2)+newDeep2 > maxSize
        newDeep2 = maxSize - (deep1-deep2);
    end
    %generates new tree
    newTree = genTree(newDeep2, opts);
    %chops off old tree and grafts on new tree
    par = tree.Parent(val);
    if par == 0
        tree = newTree;
    else
        tree=tree.chop(val);
        tree = tree.graft(par, newTree);
    end
end
%return
endTree = tree;

end
