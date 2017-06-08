%% AnalyzeData(userID)
% Opens up all the cleaned-up datafiles for a given userID and calls the
% main analysis function AnalyzeCircle. The analyzed data is saved to a
% Analysis/userID.txt.
function AnalyzeData(userID)
            
    files = dir([num2str(userID) '/' 'clean*.txt']);
    error = repmat(struct('total', 0, 'projected', 0, 'depth', 0, 'fairness', 0), numel(files), 1);
    
    outFile = fopen(['analysis/' num2str(userID) '.txt'], 'w');
    
    for i=1:numel(files)
        inFile = files(i).name;

        data = dlmread([num2str(userID) '/' inFile]);
        
        strokeSize = 0.3;
        
        error(i) = AnalyzeCircle(data, strokeSize);
        
% Get factor names as a space-separated string from filename
        inFile = strrep(inFile, '.txt', '');
        inFile = strrep(inFile, '_', ' ');
        inFile = strrep(inFile, 'clean ', '');
        
        fprintf(outFile, ['%d ' inFile ' %f %f %f %f %f\n'],...
            userID, data(size(data, 1), 4)/1e7,...
            error(i).total, error(i).projected, error(i).depth,...
            error(i).fairness);
    end
    
    fclose(outFile);
end