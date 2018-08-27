depStartDate = datetime('2017-08-10 00:00:00');
depEndDate = datetime('2017-09-14 23:59:59');

totalDepDays = hours(depEndDate-depStartDate) / 24;

for i = 1:totalDepDays+1
    try
        filenameStr = ['d' num2str(i,'%02d')]; 
        eval(['teager = SVLteager(' filenameStr '.val,100);']);
        eval(['timeIndex = ' filenameStr '.timeIndex(1:size(teager));']);

        saveFileName = ['t' num2str(i,'%02d')];
        eval([ saveFileName '= table(timeIndex, teager);']);
        eval(['save ' saveFileName '.mat ' saveFileName]);
    catch
        
        
    end
end

% i=4;
% filenameStr = ['d' num2str(i,'%02d')]; 
% eval(['teager = SVLteager(' filenameStr '.val,100);']);
% eval(['timeIndex = ' filenameStr '.timeIndex(1:size(teager));']);
% 
% saveFileName = ['t' num2str(i,'%02d')];
% eval([ saveFileName '= table(timeIndex, teager);']);
% eval(['save ' saveFileName '.mat ' saveFileName]);


