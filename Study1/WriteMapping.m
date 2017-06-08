%% WriteMapping(userID)
% Opens up config files to find the overallStrokeNumber for each stroke and
% augments the analyzed file with it.
function WriteMapping(userID)
    cStr = {'traditional', 'hybrid', 'vr'};
    pStr = {'vertical', 'sideways', 'horizontal'};
    sStr = {'uline', 'vline', 'circle'};
    lStr = {'small', 'medium', 'large'};
    
    f0 = fopen([num2str(userID) '/config/0.txt']);
    f1 = fopen([num2str(userID) '/config/1.txt']);
    f2 = fopen([num2str(userID) '/config/2.txt']);
    
    count = 1;
    map = cell(243, 6);
    
    while(~feof(f0))
        line = fgetl(f0);
        switch line(1)
            case 'c'
                c = cStr{1+str2num(line(2))};
            case 'p'
                p = pStr{1+str2num(line(2))};
            case 's'
                s = sStr{1+str2num(line(2))};
            case 't'
                t = str2num(line(2));
            case 'l'
                l = lStr{1+str2num(line(2))};
                map{count, 1} = c;
                map{count, 2} = p;
                map{count, 3} = s;
                map{count, 4} = l;
                map{count, 5} = t;
                map{count, 6} = count;
                count = count + 1;
        end
    end
    
    while(~feof(f1))
        line = fgetl(f1);
        switch line(1)
            case 'c'
                c = cStr{1+str2num(line(2))};
            case 'p'
                p = pStr{1+str2num(line(2))};
            case 's'
                s = sStr{1+str2num(line(2))};
            case 't'
                t = str2num(line(2));
            case 'l'
                l = lStr{1+str2num(line(2))};
                map{count, 1} = c;
                map{count, 2} = p;
                map{count, 3} = s;
                map{count, 4} = l;
                map{count, 5} = t;
                map{count, 6} = count;
                count = count + 1;
        end
    end
    
    while(~feof(f2))
        line = fgetl(f2);
        switch line(1)
            case 'c'
                c = cStr{1+str2num(line(2))};
            case 'p'
                p = pStr{1+str2num(line(2))};
            case 's'
                s = sStr{1+str2num(line(2))};
            case 't'
                t = str2num(line(2));
            case 'l'
                l = lStr{1+str2num(line(2))};
                map{count, 1} = c;
                map{count, 2} = p;
                map{count, 3} = s;
                map{count, 4} = l;
                map{count, 5} = t;
                map{count, 6} = count;
                count = count + 1;
        end
    end
    
    fclose(f0);
    fclose(f1);
    fclose(f2);
    
    fIn = fopen(['Analysis/' num2str(userID) '.txt']);
    d = textscan(fIn, '%d %s %s %s %s %d %f %f %f %f');
    fclose(fIn);
    
    fOut = fopen(['Analysis/' num2str(userID) '.txt'], 'w');
    for i=1:243
        idx = strcmp(d{2}, map{i, 1}) &...
                    strcmp(d{3}, map{i, 2}) &...
                    strcmp(d{4}, map{i, 3}) &...
                    strcmp(d{5}, map{i, 4}) &...
                    d{6} == map{i, 5};
%         disp(find(idx));
        assert(sum(idx) == 1, 'Assertion failed!');
        fprintf(fOut, '%d %s %s %s %s %d %d %f %f %f %f\n',...
            d{1}(idx), d{2}{idx}, d{3}{idx}, d{4}{idx}, d{5}{idx}, d{6}(idx),...
            map{i, 6}, d{7}(idx), d{8}(idx), d{9}(idx), d{10}(idx));
    end
    fclose(fOut);
end