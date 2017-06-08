%% AnalyzeLine(data, isPlanar)
% Computes the error metrics for a line.
function error = AnalyzeLine(data, isPlanar)

% Align the initial point of the input stroke with that of the target
    data(:, 1) = data(:, 1) - data(1, 1);
    data(:, 2) = data(:, 2) - data(1, 2);
    data(:, 3) = data(:, 3) - data(1, 3);
    
% Arc length parametrization
    rdata = interparc(100, data(:, 1), data(:, 2), data(:, 3), 'linear');
    
    error = struct('depth', 0, 'total', 0, 'projected', 0);
    
    error.depth = sum(abs(rdata(:, 3)))/100;
    error.projected = sum(abs(rdata(:, 2)))/100;
    
    if isPlanar
        error.total = error.projected;
    else
        error.total = sum(sqrt(rdata(:, 2).^2 + rdata(:, 3).^2))/100;
    end
end