% after running pebbleScript -> open every pebble data files

depStartDate = datetime('2017-08-10 00:00:00');
depEndDate = datetime('2017-09-14 23:59:59');

totalDepDays = hours(depEndDate-depStartDate) / 24;

for i = 1:totalDepDays+1
    str = ['d' num2str(i,'%02d') '\w'];
    list = who('-regexp', str);

    z = -99;
    y = -99;
    x = -99;
    timeIndex = datetime('2011-11-11 11:11:11');
    filenameStr = ['day' num2str(i,'%02d')];
    eval([filenameStr '= table(z,y,x,timeIndex);']); % dayXX = table(z,y,x,timeIndex);


    for j=1:length(list)
        eval([filenameStr '= [' filenameStr ';' list{j} '];']); % dayXX = [dayXX ; list{j}];
    end


    eval([filenameStr '= ' filenameStr '(2:end,:);']); % dayXX = dayXX(2:end,:);
    eval([filenameStr '= sortrows(' filenameStr ', ''timeIndex'');']); % dayXX = sortrows(dayXX, 'timeIndex');
    
end


