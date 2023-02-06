% boxcounts each image in a directory
% check to make sure the data is white against black background


function [dims, filelist] = boxcountdir(dirname)
    home = '/home/kdaniel/Dropbox/Work/projects/';
    path = [home, dirname, '/'];
    filelist = dir([path, '*.png']);
    %xlim = [7000:10000]; 
    %ylim = [6000:9000]; % to crop image

    for i = 1:length(filelist)
        piclist{i} = filelist(i).name;
        pic = imread([path, piclist{i}]);
        %pic = pic(xlim, ylim, :);
        pic = imbinarize(rgb2gray(pic));  %convert to grayscale
        pic = ~pic;  % reverse black/white (white is counted)
        %imagesc(pic)
        %histogram(pic(:)); set(gca, 'YScale', 'log')
        dims(i) = boxcount(pic, 1);
        subplot(1,2,1)
        title(piclist{i})
        saveas(gcf, [path, piclist{i}(1:end-4), '.boxcount.pdf']);
        save([path, 'boxcount.mat'], 'piclist', 'dims')
    end
    
return;