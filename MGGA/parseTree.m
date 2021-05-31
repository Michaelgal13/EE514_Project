%%
function strName = parseTree(tree, filName)
maxRec = 30;


% DOES NOT WORK IF LOOKING AT THE END DIRECTORY IDFK KNOW WHY BUT DON'T
% LOOK AT IT. A WATCHED POT NEVER BOILS AND OBSERVER EFFECT AND STUFF
%passes tree to helper function that returns sting
check = parseTreeHelper(tree);
%generate hash for naming the file
c = clock;
c2 = strcat(dec2hex(c(1)), dec2hex(c(2)), dec2hex(c(3)), dec2hex(c(4)), dec2hex(c(5)), num2hex(c(6)));
% sets directory
dirName = "genFiles/";
%adds MG to function name to ensure it will be valid, also to claim
%ownership :)
if isempty(filName)
    strName = strcat("MG", c2);
else
    strName = filName;
end
%creates folder/filename.extension
fullStrName = strcat(dirName, strName, ".m");
%opens the new file
fileID = fopen(strcat(fullStrName),'w+');
%check validity of string

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
[maxVal,maxInd] = max(pars(:,1));
if  maxVal > maxRec
    % attempts to open the file until it is open
    % DONT LOOK AT THE DIRECTORY. IT GETS NERVOUS!
    while fileID == -1
        fileID = fopen(strcat(fullStrName),'w+');
    end
    %writes function name
    stringName = strcat("function k = ", strName, "(x, xdot, theta, thetadot)");
    fprintf(fileID, stringName);
    while maxVal > maxRec
        %disp(B);
        %         RInd = maxInd;
        %         recLevel = maxVal;
        %         while recLevel < maxVal - maxRec
        %             RInd = RInd + 1;
        %             recLevel = pars(RInd,1);
        %         end
        %         RstrInd = pars(RInd,2);
        par = maxRec;
        RstrInd = pars(maxInd,2);
        while par > 0
            RstrInd = RstrInd + 1;
            if B(RstrInd) == '('
                par = par + 1;
            elseif B(RstrInd) == ')'
                par = par - 1;
            end
        end
        LstrInd = RstrInd;
        par = 1;
        while par > 0
            LstrInd = LstrInd - 1;
            if B(LstrInd) == '('
                par = par - 1;
            elseif B(LstrInd) == ')'
                par = par + 1;
            end
        end
        %         recLevel = maxVal;
        %         LInd = maxInd;
        %         while recLevel > maxVal - maxRec
        %             LInd = LInd - 1;
        %             recLevel = pars(LInd,1);
        %           end
        %         recLevel = maxVal;
        %
        %
        %         LstrInd = pars(LInd,2);
        if(B(LstrInd-1) == 's')
            modInd = LstrInd-1;
            while B(modInd) >= 97 && B(modInd) <=122
                modInd = modInd - 1;
            end
            newstr = B(modInd+1:RstrInd);
            B = strcat(B(1:modInd) , 'k' , B(RstrInd + 1:size(B,2)));
        else
            disp("READ ERROR")
            newstr = k;
            disp(B);
            disp(LstrInd);
            disp(B(LstrInd - 1));
        end
        fprintf(fileID, "\nk = ");
        fprintf(fileID, newstr);
        fprintf(fileID, ";");
        pars = zeros(size(pars));
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
        [maxVal,maxInd] = max(pars(:,1));
    end
    fprintf(fileID, "\nk = ");
    fprintf(fileID, B);
    fprintf(fileID, ";");
    %closes the file
    fclose(fileID);
    
else
    % attempts to open the file until it is open
    % DONT LOOK AT THE DIRECTORY. IT GETS NERVOUS!
    while fileID == -1
        fileID = fopen(strcat(fullStrName),'w+');
    end
    %writes function name
    stringName = strcat("function k = ", strName, "(x, xdot, theta, thetadot)");
    %writes function code
    fprintf(fileID, stringName);
    fprintf(fileID, "\nk = ");
    fprintf(fileID, check);
    fprintf(fileID, ";\n");
    %closes the file
    fclose(fileID);
    %returns function name
end



end
