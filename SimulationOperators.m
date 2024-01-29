clear all
close all

resdir = 'D:\studies\computationalVision\MAX_averageOperatorDemo\res';

dimension =             [4, 4, 5, 5, 6, 6, 4, 4, 5, 5, 6, 6]+10;
line_intensity =        [255 0 255 0 255 0 0 255 0 255 0 255];  % You can adjust this value
background_intensity =  [0 255 0 255 0 255 255 0 255 0 255 0];  % You can adjust this value
          
num_inputpatterns = length(background_intensity);
filter_size =  [2, 2, 2, 2, 2, 2, 5, 5, 5, 5, 5, 5]+5;
stride = 1% [repmat(1,1,12)];
maxl = 25;

ModeNames = {'Diagonal', 'Left', 'Right'};
Modes = [1,2,3];

for mode = 1:size(Modes,2)
    for pattern = 1:num_inputpatterns
        if Modes(mode) == 1
            input_matrix = generate_square_pattern(dimension(pattern), line_intensity(pattern), background_intensity(pattern))
        elseif Modes(mode) == 2
            input_matrix = generate_shifted_diagonal_pattern(dimension(pattern), line_intensity(pattern), background_intensity(pattern), 'left');
        elseif Modes(mode) == 3
            input_matrix = generate_shifted_diagonal_pattern(dimension(pattern), line_intensity(pattern), background_intensity(pattern), 'right');
        end
            
        % Max Pooling
        max_output = zeros(size(input_matrix) - filter_size(pattern) + 1);
        for i = 1:size(max_output, 1)
            for j = 1:size(max_output, 2)
                window = input_matrix(i:i+filter_size(pattern)-1, j:j+filter_size(pattern)-1);
                max_output(i, j) = max(window(:));
            end
        end

        % Average Pooling
        avg_output = zeros(size(input_matrix) - filter_size(pattern) + 1);
        for i = 1:size(avg_output, 1)
            for j = 1:size(avg_output, 2)
                window = input_matrix(i:i+filter_size(pattern)-1, j:j+filter_size(pattern)-1);
                avg_output(i, j) = mean(window(:));
            end
        end

        % Visualization
        figure('Position', [300 300 600 250]);

        % Input Matrix
        subplot(1, 3, 1);
        imagesc(input_matrix);
        colormap(gray)
        axis square
        axis off
        clim = ([0 maxl])
        title('Input Matrix');

        % Max Pooling Result
        subplot(1, 3, 2);
        imagesc(max_output);
        colormap(gray)
        axis square
        axis off
        clim = ([0 maxl])
        title('Max Pooling Result');

        % Average Pooling Result
        subplot(1, 3, 3);
        imagesc(avg_output);        
        colormap(gray)
        axis square
        axis off
        clim = ([0 maxl])
        title('Average Pooling Result');

        cd(resdir)

        set(gcf,'renderer','painters')
        print(gcf,'-dpng',strcat(ModeNames{mode},'_filtersize',num2str(filter_size(pattern)),'_dimension',num2str(dimension(pattern)),'_line_intensity',num2str(line_intensity(pattern)),'_background_intensity',num2str(background_intensity(pattern)),'.png'));
    end
end

function square_pattern = generate_square_pattern(dim, line_intensity, background_intensity)
    square_pattern = background_intensity * ones(dim);
    for i = 1:dim
        square_pattern(i, i) = line_intensity;
    end
end

function square_pattern = generate_shifted_diagonal_pattern(dim, line_intensity, background_intensity, shift_direction)
    if strcmp(shift_direction, 'left')
        shift = -4;
        square_pattern = repmat((1:dim).',1,dim,1) == repmat(1-shift:dim-shift,dim,1,1);
    elseif strcmp(shift_direction, 'right')
        shift = 4;
        square_pattern = repmat((1:dim).',1,dim,1) == repmat(1-shift:dim-shift,dim,1,1) 
    end
    square_pattern2 = square_pattern;
    square_pattern2(square_pattern == 1) = line_intensity;
    square_pattern2(square_pattern == 0) = background_intensity;
    square_pattern = square_pattern2;
    clear square_pattern2
end




