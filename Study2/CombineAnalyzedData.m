%% CombineAnalyzedData(uidArray)
% Concatenates all analyzed data for user IDs in uidArray and saves
% to a file Analysis/all.txt. Performs a simple string replacement to make
% SPSS-based analysis easier.
function CombineAnalyzedData(uidArray)

    fAll = fopen('Analysis/all.txt', 'w');

    for i = uidArray
        fIn = fopen(['Analysis/' num2str(i) '.txt']);
        while(~feof(fIn))
            s = fgetl(fIn);
            
% SPSS does not play well with the '-' character. Also, removing spaces
% from variable names makes processing easier.
            s = strrep(s, ' 0 0 p', ' 0_0 p');
            s = strrep(s, ' 0 0 c', ' 0_0 c');
            s = strrep(s, ' 0 45 p', ' 0_45 p');
            s = strrep(s, ' 0 45 c', ' 0_45 c');
            s = strrep(s, ' 0 90 p', ' 0_90 p');
            s = strrep(s, ' 0 90 c', ' 0_90 c');
            s = strrep(s, ' 0 -45 p', ' 0_m45 p');
            s = strrep(s, ' 0 -45 c', ' 0_m45 c');
            s = strrep(s, ' 0 -90 p', ' 0_m90 p');
            s = strrep(s, ' 0 -90 c', ' 0_m90 c');
            s = strrep(s, ' 45 0 p', ' 45_0 p');
            s = strrep(s, ' 45 0 c', ' 45_0 c');
            s = strrep(s, ' 45 45 p', ' 45_45 p');
            s = strrep(s, ' 45 45 c', ' 45_45 c');
            s = strrep(s, ' 45 -45 p', ' 45_m45 p');
            s = strrep(s, ' 45 -45 c', ' 45_m45 c');
            s = strrep(s, ' 90 0 p', ' 90_0 p');
            s = strrep(s, ' 90 0 c', ' 90_0 c');
            s = strrep(s, ' -45 0 p', ' m45_0 p');
            s = strrep(s, ' -45 0 c', ' m45_0 c');
            s = strrep(s, ' -45 45 p', ' m45_45 p');
            s = strrep(s, ' -45 45 c', ' m45_45 c');
            s = strrep(s, ' -45 -45 p', ' m45_m45 p');
            s = strrep(s, ' -45 -45 c', ' m45_m45 c');
            s = strrep(s, ' -90 0 p', ' m90_0 p');
            s = strrep(s, ' -90 0 c', ' m90_0 c');
            fprintf(fAll, '%s\n', s);
        end
        fclose(fIn);
    end

    fclose(fAll);
end