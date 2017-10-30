function vibrationSeries(obj, event, vib, logoSurf, L) %#ok<*INUSL>
%% Calculate and displays L-shape membrane eigenfunctions
% Uses code from VIBES and BENCH/BENCH_3D

%  Copyright 1984-2013 The MathWorks, Inc.

% Coefficients
global busyinit
persistent t dt c lambda eigens mu

switch vib
    case 4
        %% Vibration Series 4
        % This series uses incrementing time and all 12 eigen values.
        %
        if isempty(busyinit)
            t = 0;
            
            % Eigenvalues.
            eigens = 12;
            lambda = [9.6397238445, 15.19725192, 2*pi^2, ...
                29.5214811, 31.9126360, 41.4745099, 44.948488, ...
                5*pi^2, 5*pi^2, 56.709610, 65.376535, 71.057755];
            
            % Get coefficients from eigenfunctions.
            for k = 1:eigens
                c(k) = L{k}(25,23)/3;
            end
            
            % Time delta
            dt = 0.025;
            
            % Throw flag to say initialization has been done
            busyinit = 1;
        end
        
        t = t + dt;
        
        s = c.*sin(sqrt(lambda)*t);
        
        % Amplitude
        A = zeros(size(L{1}));
        for k = 1:eigens
            A = A + s(k)*L{k};
        end
        
        % Velocity
        s = lambda .*s;
        V = zeros(size(L{1}));
        for k = 1:eigens
            V = V + s(k)*L{k};
        end
        V(16:31,1:15) = NaN;
        
        % Surface plot of height, colored by velocity.
        try
            set(logoSurf,'zdata',A,'cdata',V);
            drawnow
        catch
        end
        
        
        
    case 3
        %% Vibration Series 3
        % This series uses incrementing time and only 3 eigen values.
        %
        
        if isempty(busyinit)
            mu = sqrt([9.6397238445, 15.19725192, 2*pi^2]);
            t = 0;
            dt = 0.025;
            
            % Throw flag to say initialization has been done
            busyinit = 1;
        end
        
        t = t + dt;
        
        L = cos(mu(1)*t)*L{1} + sin(mu(2)*t)*L{2}*.25 + sin(mu(3)*t)*L{3}*.25;
        try
            set(logoSurf,'zdata',L)
            drawnow
        catch
        end
        
        
    case 2
        %% Vibration Series 2
        % This series uses incrementing time and the first
        % eigen value.  This is the MathWorks Logo.
        
        if isempty(busyinit)
            t = 0;
            
            % Eigenvalues.
            lambda = [9.6397238445, 15.19725192, 2*pi^2, ...
                29.5214811, 31.9126360, 41.4745099, 44.948488, ...
                5*pi^2, 5*pi^2, 56.709610, 65.376535, 71.057755];
            
            % Get coefficients from eigenfunctions.
            c = L{1}(25,23)/3;
            
            % Time delta
            dt = 0.025;
            
            % Throw flag to say initialization has been done
            busyinit = 1;
        end
        
        t = t + dt;
        
        s = c.*sin(sqrt(lambda)*t);
        
        % Amplitude
        A = zeros(size(L{1}));
        A = A + s(1)*10*L{1};
        
        % Velocity
        s = lambda .*s;
        V = zeros(size(L{1}));
        V = V + s(1)*L{1};
        V(16:31,1:15) = NaN;
        
        % Surface plot of height, colored by velocity.
        try
            set(logoSurf,'zdata',A,'cdata',V);
            drawnow
        catch
        end
        
        
        
    case 1
        %% Vibration Series 1
        % This series uses incrementing and decrementing time and the first
        % eigen value.  This is the MathWorks Logo.
        %
        
        
        if isempty(busyinit)
            t = 0;
            
            % Eigenvalues.
            lambda = [9.6397238445, 15.19725192, 2*pi^2, ...
                29.5214811, 31.9126360, 41.4745099, 44.948488, ...
                5*pi^2, 5*pi^2, 56.709610, 65.376535, 71.057755];
            
            % Get coefficients from eigenfunctions.
            c = L{1}(25,23)/3;
            
            % Time delta
            dt = 0.025;
            
            % Throw flag to say initialization has been done
            busyinit = 1;
        end
        
        if t > 0.5
            dt = -0.025;
        elseif t < 0
            dt = 0.025;
        end
        t = t + dt;
        
        s = c.*sin(sqrt(lambda)*t);
        
        % Amplitude
        A = zeros(size(L{1}));
        A = A + s(1)*10*L{1};
        
        % Velocity
        s = lambda .*s;
        V = zeros(size(L{1}));
        V = V + s(1)*L{1};
        V(16:31,1:15) = NaN;
        
        % Surface plot of height, colored by velocity.
        try
            set(logoSurf,'zdata',A,'cdata',V);
            drawnow
        catch
        end 
        
end % End of Switch