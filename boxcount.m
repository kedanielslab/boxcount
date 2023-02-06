% Usage: works on a BINARIZED image
% dim = boxcount(pic, 1);
%   returns the box-count dimension and also plots the results
% [dim, L, counts] = boxcount(pic, 1);
%   also returns the data from the plot
% [dim, L, counts] = boxcount(pic);
%   returns values and makes no plot

function [dim, L, tilecounts] = boxcount(pic, makeplots)

D = size(pic);
N = floor(log2(min(D/2))); % max box is half the image size
L = 2.^(0:N-1); % list of box sizes
%L = 2.^(1:2:N-1); % shorter list of box sizes, to run faster

tilecounts = zeros(1,length(L));

for i = 1:length(L)
    d = L(i) -1;
    % a better version of this would average over the (LxL) possible
    % staring points, not just from (1,1)
    for j = 1:L(i):D(1)-d
        for k = 1:L(i):D(2)-d
            tilecounts(i) = tilecounts(i) + any(pic(j:j+d, k:k+d), 'all');
        end
    end
end

fit = polyfit(log(L), log(tilecounts), 1);
dim = -fit(1);
A = exp(fit(2));

if exist('makeplots')
	clf;
    subplot(1,2,1)
    imagesc(pic)
    colormap gray
    axis equal
    axis off
    subplot(1,2,2)
    loglog(L,tilecounts, 'ok', 'MarkerFaceColor', 'k') 
    hold on;
    plot(L, A*L.^(-dim), '--k')
    %set(gca, 'XLim', [1 D(1)])
    title(['dim = ', mat2str(dim,3)])
    xlabel('Box Size')
    ylabel('Counts')
end

return 
