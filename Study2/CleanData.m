%% CleanData(userID)
% Cleans the data for a given userID by removing duplicate points and
% applying a median filter to reduce tracking noise. The cleaned data is
% saved in a file prefixed with "clean_".
function CleanData(userID)

% Ignore files which have cleaned-up data
    files = dir([num2str(userID) '/' '*.txt']);
    
    for i=1:numel(files)
        inName = files(i).name;
        if numel(strfind(inName, 'clean'))
            continue;
        end
        
        d = dlmread([num2str(userID) '/' inName]);
        
        du = abs(diff(d(:, 1)));
        dv = abs(diff(d(:, 2)));
        dw = abs(diff(d(:, 3)));
        
% Remove duplicate points 
        d([true; du < 0.00001 & dv < 0.00001 & dw < 0.00001], :) = [];
        
% Apply median filter to remove tracking noise
        d(:, 1) = medfilt1(d(:, 1), 6, 'truncate');
        d(:, 2) = medfilt1(d(:, 2), 6, 'truncate');
        d(:, 3) = medfilt1(d(:, 3), 6, 'truncate');
        d(:, 5) = medfilt1(d(:, 5), 6, 'truncate');
        d(:, 6) = medfilt1(d(:, 6), 6, 'truncate');
        d(:, 7) = medfilt1(d(:, 7), 6, 'truncate');
        
        dlmwrite([num2str(userID) '/clean_' inName], d, ' ');
    end
end