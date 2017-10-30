function [ lcss ] = LCSS( path1, path2, delta, epsi, rho )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    m = length(path1);
    n = length(path2);  
    if min(m, n) < rho * max (m, n)
        lcss = 0;
    else 
        lcss = LCSS_nest(path1, path2, delta, epsi);
    end;

    function [ new_path ] = head(old_path)
        new_path = old_path(1:length(old_path)-1);
    end;
    
    function [ lcss_max ] = LCSS_max (path_11, path_22)
        m_11 = length(path_11);
        n_11 = length(path_22);
        if m_11 > n_11
            lcss_max = path_11;
        else
            lcss_max = path_22;
        end;
        
    end;
    
    function [delta_test] = LCSS_delta (path_11, path_22, delta_11)
        m_11 = length(path_11);
        n_11 = length(path_22);
        delta_test = [];
        if n_11 - delta_11 > 1
            l = 1;
            for k = n_11 : -1 : n_11 - delta_11
                delta_test(l) = abs(path_11(m_11) - path_22(n_11));
                l = l + 1;
            end;
        else
            l = 1;
            for k = n_11 : -1 : 1
                delta_test(l) = abs(path_11(m_11) - path_22(n_11));
                l = l + 1;
            end;
        end;
        
        delta_test = max(delta_test);
           
    end;
    
    function [ lcss_nest ] = LCSS_nest(path_1, path_2, delta1, epsi1)
        m1 = length(path_1);
        n1 = length(path_2);
        if isempty(path_1) || isempty(path_2)
            lcss_nest = 0;
        else
            delta_test1 = LCSS_delta(path_1, path_2, delta1);
            if delta_test1 <= epsi1 
                lcss_nest =  [LCSS_nest(head(path_1), head(path_2), delta1, epsi1); path_1(m1)];
            else
                lcss_nest = LCSS_max(LCSS_nest(head(path_1), path_2, delta1, epsi1), LCSS_nest(path_1, head(path_2), delta1, epsi1));
            end;
        end;
        
    end;
end

