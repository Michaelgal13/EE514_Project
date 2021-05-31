%%
% Tree Testing
maxRec = 5;
B = convertStringsToChars(check);
pars = 0;
k = 1;

for i = 1:size(B,2)
    if B(i) == '('
        pars(k+1,1) = pars(k) + 1;
        pars(k+1,2) = i;
        k=k+1;
    elseif B(i) == ')'
        pars(k+1,1) = pars(k) - 1;
        pars(k+1,2) = i;
        k=k+1;
    end
end
iter = 1;
[maxVal,maxInd] = max(pars(:,1));
if  maxVal > maxRec
    recLevel = maxVal;
    LInd = maxInd;
    while recLevel > maxVal - maxRec
        LInd = LInd - 1;
        recLevel = pars(recLevel,1);
    end
    recLevel = maxVal;
    RInd = maxInd;
    while recLevel > maxVal - maxRec
        RInd = RInd + 1;
        recLevel = pars(recLevel,1);
    end
   RstrInd = pars(RInd,2);
   LstrInd = pars(LInd,2);
   if(B(LstrInd-1) == 's')
       modInd = LstrInd-1;
    while B(modInd) >= 97 && B(modInd) <=122
        modInd = modInd - 1;
    end
    newstr(iter) = B(modInd+1:RstrInd);
    iter = iter + 1;
    B = B(1:modInd) + 'k' + B(RstrInd + 1:size(B,2));
   end

else
end
