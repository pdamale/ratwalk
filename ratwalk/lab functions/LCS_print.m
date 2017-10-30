function [ lcs ] = LCS_print( b, path1, i, j )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    
    if i == 0 || j == 0
        lcs = [0];
%         lcs = lcs;
    else
        if b(i, j) == 'D'
            lcs = LCS_print(b, path1, i-1, j-1);
            lcs = [lcs; path1(i)];
        elseif b(i, j) == 'U'
            lcs = LCS_print(b, path1, i-1, j);
%             lcs = [lcs; lcs];
        else
            lcs = LCS_print(b, path1, i, j-1);
%             lcs = [lcs ; lcs];
        end;
    end;


end

