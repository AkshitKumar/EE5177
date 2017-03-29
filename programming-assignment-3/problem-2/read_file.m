function [names,angle,centX,centY,cropW,cropH] = read_file(file_name)
    formatspec = '%s %d %d %d %d %d';
    data = readtable(file_name,'Delimiter',' ','Format',formatspec);
    names = data.fileName;
    angle = double(data.angle);
    centX = double(data.centX);
    centY = double(data.centY);
    cropW = double(data.cropW);
    cropH = double(data.cropH);
end