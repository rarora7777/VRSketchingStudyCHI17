%% AnalyzeCircle(data, strokeSize, isPlanar)
% Computes the error metrics for a circle. 
function error = AnalyzeCircle(data, strokeSize, isPlanar)

% Align the initial point of the input stroke with that of the target
    data(:, 1) = data(:, 1) - data(1, 1) + strokeSize/2;
    data(:, 2) = data(:, 2) - data(1, 2);
    data(:, 3) = data(:, 3) - data(1, 3);
    
% Arc length interpolation
    rdata = interparc(100, data(:, 1), data(:, 2), data(:, 3), 'linear');
    
    error = struct('depth', 0, 'total', 0, 'projected', 0);
    error.projected = sum(abs(sqrt(rdata(:, 1).^2 + rdata(:, 2).^2) - strokeSize/2))/100;
    error.depth = sum(abs(rdata(:, 3)))/100;
    
    if isPlanar
        error.total = error.projected;
    else
        errT = sqrt((sqrt(rdata(:, 1).^2 + rdata(:, 2).^2) - strokeSize/2).^2 + rdata(:, 3).^2);
        error.total = sum(errT)/100;
    end
    
end