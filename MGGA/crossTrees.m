%% Cross Trees
function [newTree1, newTree2] = crossTrees(tree1, tree2, opts)
%checks for options
if isempty(opts) || (size(opts,2) < 2)
    maxSize = inf;
else
    %maximum allowable depth of the tree
    a = find(opts(:) == "MaxSize");
    if isempty(a)
        maxSize = inf;
    else
        maxSize = opts(a(1)+1);
        maxSize = str2double(maxSize);
    end
end
% generates and checks validity of a random node on tree 1
val1 = cast(rand * tree1.nnodes() + 1, 'int32');
if val1 > tree1.nnodes()
    val1 = tree1.nnodes();
elseif val1 <= 0
    val1 = 1;
end
% generates and checks validity of a random node on tree 2
val2 = cast(rand * tree2.nnodes() + 1, 'int32');
if val2 > tree2.nnodes()
    val2 = tree2.nnodes();
elseif val2 <= 0
    val2 = 1;
end
%generates sub trees and checks if the depths are too big
sub1 = tree1.subtree(val1);
sub2 = tree2.subtree(val2);
deepOld1 = depth(tree1);
deepSub1 = depth(sub1);
deepOld2 = depth(tree2);
deepSub2 = depth(sub2);

deepNew1 = deepOld1 - deepSub1 + deepSub2;
deepNew2 = deepOld2 - deepSub2 + deepSub1;

%if the depths are too big randomly choose new nodes and subtrees
while deepNew1 > maxSize || deepNew2 > maxSize
    val1 = cast(rand * tree1.nnodes() + 1, 'int32');
    if val1 > tree1.nnodes()
        val1 = tree1.nnodes();
    elseif val1 <= 0
        val1 = 1;
    end
    val2 = cast(rand * tree2.nnodes() + 1, 'int32');
    if val2 > tree2.nnodes()
        val2 = tree2.nnodes();
    elseif val2 <= 0
        val2 = 1;
    end
    sub1 = tree1.subtree(val1);
    sub2 = tree2.subtree(val2);
    deepOld1 = depth(tree1);
    deepSub1 = depth(sub1);
    deepOld2 = depth(tree2);
    deepSub2 = depth(sub2);
    
    deepNew1 = deepOld1 - deepSub1 + deepSub2;
    deepNew2 = deepOld2 - deepSub2 + deepSub1;
end

%stores parent node
par1 = tree1.Parent(val1);
par2 = tree2.Parent(val2);

if par1 == 0
    % if root node replaces the tree
    tree1 = sub2;
else
    % cuts off old node and associated branches and replaces it with new
    % subtree
    tree1=tree1.chop(val1);
    tree1 = tree1.graft(par1, sub2);
end

if par2 == 0
    % if root node replaces the tree
    tree2 = sub1;
else
    % cuts off old node and associated branches and replaces it with new
    % subtree
    tree2 = tree2.chop(val2);
    tree2 = tree2.graft(par2, sub1);
end
%return
newTree1 = tree1;
newTree2 = tree2;

end