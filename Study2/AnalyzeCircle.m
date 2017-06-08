%% AnalyzeCircle(data, strokeSize, isPlanar)
% Computes the error metrics for a circle.
function error = AnalyzeCircle(data, strokeSize)
	
% Arc length interpolation
	rdata = interparc(100, data(:, 1), data(:, 2), data(:, 3), 'linear');
    error = struct('total', 0, 'projected', 0, 'depth', 0, 'fairness', 0);
    
    error.projected = sum(abs(sqrt(rdata(:, 1).^2 + rdata(:, 2).^2) - strokeSize/2))/100;
    error.depth = sum(abs(rdata(:, 3)))/100;
    errT = sqrt((sqrt(rdata(:, 1).^2 + rdata(:, 2).^2) - strokeSize/2).^2 + rdata(:, 3).^2); 
	error.total = sum(errT)/100;

% Use frenet.m to get discrete curvature, then take derivative
    [~, ~, ~, k] = frenet(rdata(:, 1), rdata(:, 2), rdata(:, 3));
    dk = abs(diff(k));
    pairwiseAvgK = (k(1:99) + k(2:100))/2;
    error.fairness = sum(dk./pairwiseAvgK)/99;
end