%% AnalyzeData(userID)
% Opens up all the cleaned-up datafiles for a given userID and calls the
% main analysis functions AnalyzeCircle and AnalyzeLine. The analyzed data
% is saved to a file Analysis/userID.txt.
function AnalyzeData(userID)

    files = dir([num2str(userID) '/' 'clean*.txt']);
    error = repmat(struct('depth', 0, 'total', 0, 'projected', 0),...
        numel(files), 1);
    
    outFile = fopen(['analysis/' num2str(userID) '.txt'], 'w');
    
    for i=1:numel(files)
        inFile = files(i).name;
        
        data = dlmread([num2str(userID) '/' inFile]);

        isPlanar = true;
        
    
        if contains(inFile, 'small')
            strokeSize = 0.1;
        elseif contains(inFile, 'medium')
            strokeSize = 0.3;
        else
            strokeSize = 0.6;
        end
        
        
% strokes in VR are not supposed to be planar
% while the others are
        if contains(inFile, 'vr')
            isPlanar = false;
        end
        
        if contains(inFile, 'circle')
            error(i) = AnalyzeCircle(data, strokeSize, isPlanar);
        else
            error(i) = AnalyzeLine(data, isPlanar);
        end
        
% Get factor names as a space-separated string from filename
        inFile = strrep(inFile, '.txt', '');
        inFile = strrep(inFile, '_', ' ');
        inFile = strrep(inFile, 'clean ', '');
        inFile = strrep(inFile, '0', ' 0');
        inFile = strrep(inFile, '1', ' 1');
        inFile = strrep(inFile, '2', ' 2');
        
        fprintf(outFile, ['%d ' inFile ' %f %f %f %f\n'], userID, data(size(data, 1), 4)/1e7,...
            error(i).depth, error(i).total, error(i).projected);
        
    end
    
    fclose(outFile);
end