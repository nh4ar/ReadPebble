depStartDate = datetime('2017-08-10 00:00:00');
depEndDate = datetime('2017-09-14 23:59:59');

totalDepDays = hours(depEndDate-depStartDate) / 24;

for i = 1:totalDepDays+1
    try
        filenameStr = ['day' num2str(i,'%02d')]; 
        eval(['xyz = table2array(' filenameStr '(:,1:3));']); % xyz = table2array(dayXX(:,1:3));
        xyz = ((xyz-2048)./84).^2;
        val = sqrt(sum(xyz,2));
        
        eval(['timeIndex = ' filenameStr '.timeIndex;']); % timeIndex = dayXX.timeIndex;
        
        saveFileName = ['d' num2str(i,'%02d')];
        eval([ saveFileName '= table(val, timeIndex);']); % dXX = table(mag, timeIndex);
        
        eval(['save ' saveFileName '.mat ' saveFileName]); % save d04.mat d04
    catch
        
        
    end
end

% xyz = table2array(day04(:,1:3));
% xyz = ((xyz-2048)./84).^2;
% mag = sqrt(sum(xyz,2));
% 
% timeIndex = day04.timeIndex;
% d04 = table(mag, timeIndex);
% 
% save d04.mat d04




