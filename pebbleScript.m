%% Pebble Data Parser %%

%%
depStartDate = '2017-08-10 00:00:00';
depEndDate = '2017-09-14 23:59:59';
% depStartDate = '2017-10-14 00:00:00';
% depEndDate = '2017-10-14 23:59:59';

%day_01 = datetime(depStartDate,'InputFormat','yyyy-MM-dd HH:mm:ss'); 
startDateNum = floor(datenum(depStartDate,'yyyy-mm-dd HH:MM:SS'));
endDateNum = ceil(datenum(depEndDate,'yyyy-mm-dd HH:MM:SS'));

refDateNum = datenum('1970', 'yyyy'); 
% refDateNum = datenum('1970-Jan-01 04', 'yyyy-mmm-dd HH'); % 5hr offset for March12-Nov05, 4hr otherwise
startUnixTime = (startDateNum-refDateNum)*8.64e7;
endUnixTime = (endDateNum-refDateNum)*8.64e7;

nindx_length = 0;
indx_length = 0;

%%
% pebbleID = 0;
% pebbleName = ['Pebble ' num2str(pebbleID,'%1d')];
% relayID = [105,106];

pebbleID = 1;
pebbleName = ['Pebble' num2str(pebbleID,'%1d')];
% relayID = [14,19,29,39];
relayID = [113,115,117,119];
% relayID = 14;


%%
for k = 1:length(relayID)
%     relayName = [num2str(relayID(k)) 'R'];
    relayName = ['r' num2str(relayID(k))];
%     fileDirName = fullfile('C:\Users\Nutta\Desktop\BESI Code',pebbleName,relayName,'rPebble');
    fileDirName = fullfile('E:\BESI\P2D8 data\BESI Deployment MTvCS5fn7u52KfP4'...
        ,pebbleName,relayName);
    filenames = dir(fullfile(fileDirName,'*.csv'));
    
    saveAsFileName = ['pbl' num2str(pebbleID,'%1d') 'r' num2str(k,'%02d') '.mat'];
    rTableName = ['pbl' num2str(pebbleID,'%1d') 'r' num2str(k,'%02d')];
    relayT = table;
    eval([ rTableName '=' 'relayT ;']);
    eval(['save(''' saveAsFileName ''',''' rTableName ''',''-v7.3'');']);
    
    for i=1:length(filenames)
        pblFile = fullfile(fileDirName,filenames(i).name);
        pblData = importPebbleData(pblFile); % place the importPebbleData.m in the same folder
        times=pblData.timestamp;
        indx = find(times<endUnixTime & times>startUnixTime);
        indx_length = indx_length + length(indx);
        nindx_length = nindx_length + (height(pblData)-length(indx));
        pblData = pblData(indx,:);
        pblData.t0 = pblData.timestamp + pblData.offset;
        pblData.timestamp = [];
        pblData.offset = [];
        pblData.timeIndex = datetime((pblData.t0)./1000,'ConvertFrom','posixtime');
        pblData.t0=[];
        
        relayT = [relayT;pblData];
        
        while(1)
            if height(pblData)==0
                break;
            end
            tempDateNum = floor(datenum(pblData.timeIndex(1)));
            tempInd = find(floor(datenum(pblData.timeIndex))==tempDateNum);
            if (~isempty(tempInd))
                newTableName = ['d' num2str(tempDateNum-startDateNum+1,'%02d') ...
                    'pbl' num2str(pebbleID,'%1d') 'r' num2str(k,'%02d') ...
                    'f' num2str(i)];
                eval([newTableName '=' 'pblData(tempInd,:);']);
                eval(['save(''' saveAsFileName ''',''' newTableName ''',''-append'');']);
                eval(['clear ' newTableName ';']);
                pblData(tempInd,:) = [];
            end
        end
        
        clear pblData pblFile indx nindx times tempDateNum tempInd newTableName;
    end
    
    
    eval([ rTableName '=' 'relayT ;']);
    clear relayT;
    eval(['save(''' saveAsFileName ''',''' rTableName ''',''-append'');']);
    eval(['clear ' rTableName ';']);
    clear i filenames fileDirName relayName saveAsFileName rTableName;

end
clear pebbleName pebbleID relayID k;


%%


