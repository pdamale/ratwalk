function [ c, b] = LCS_length( path1, path2, delta, epsi, rho )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    m = length(path1);
    n = length(path2);
    if min(m, n) < rho * max(m, n)
        c = 0;
        b = 0;
    else
        b = zeros(m, n);
        c = zeros(m+1, n+1);
        for i = 1 : m
            for j = 1 : n
               
                if j - delta > 1
                    l = 1;
                    delta_test = [];
                    for k = j : -1 : j-delta
                        delta_test(l) = abs(path1(i) - path2(k));
                        l = l + 1;
                    end;
                    delta_test = max(delta_test);
                else 
                    l = 1;
                    delta_test = [];
                    for k = j : -1 : 1
                        delta_test(l) = abs(path1(i) - path2(k));
                        l = l + 1;
                    end;
                    delta_test = max(delta_test);
                end;
                
                
                if delta_test <= epsi
                    c(i+1, j+1) = c(i, j) + 1;
                    b(i, j) = 'D';
                elseif c(i, j+1) >= c(i+1, j)
                    c(i+1, j+1) = c(i, j+1);
                    b(i, j) = 'U';
                else
                    c(i+1, j+1) = c(i+1, j);
                    b(i, j) = 'L';
                end;
            end;
        end;
    end;
    
        
end

