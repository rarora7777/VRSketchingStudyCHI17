%% CombineAnalyzedData(uidArray)
% Simply concatenates all analyzed data for user IDs in uidArray and saves
% to a file Analysis/all.txt.
function CombineAnalyzedData(uidArray)

    fAll = fopen('Analysis/all.txt', 'w');
    for i = uidArray
        fIn = fopen(['Analysis/' num2str(i) '.txt']);
        while(~feof(fIn))
            s = fgetl(fIn);
            fprintf(fAll, '%s\n', s);
        end
        fclose(fIn);
    end
    fclose(fAll);
end