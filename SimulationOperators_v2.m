clear all
close all

resdir = 'D:\studies\computationalVision\MAX_averageOperatorDemo\res';

dimension =             [4, 4, 5, 5, 6, 6, 4, 4, 5, 5, 6, 6, 4, 4, 5, 5, 6, 6, 4, 4, 5, 5, 6, 6];
line_intensity =        [255 0 255 0 255 0, 255 0 255 0 255 0, 255 0 255 0 255 0, 255 0 255 0 255 0];  % You can adjust this value
background_intensity =  [0 255 0 255 0 255, 0 255 0 255 0 255, 0 255 0 255 0 255, 0 255 0 255 0 255];  % You can adjust this value

num_inputpatterns = length(background_intensity);
filter_size = [2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3];
stride = [repmat(1,1,12), repmat(2,1,12)];
maxl = 255; % Adjusted to match the line_intensity values

for pattern = 1:num_inputpatterns
    input_matrix = generate_square_pattern(dimension(pattern), line_intensity(pattern), background_intensity(pattern));

    % Max Pooling
    max_output = max_pooling(input_matrix, filter_size(pattern), stride(pattern));

    % Average Pooling
    avg_output = average_pooling(input_matrix, filter_size(pattern), stride(pattern));

    % Visualization
    figure('Position', [300 300 600 250]);

    % Input Matrix
    subplot(1, 3, 1);
    imagesc(input_matrix);
    axis square
    caxis([0 maxl])
    title('Input Matrix');

    % Max Pooling Result
    subplot(1, 3, 2);
    imagesc(max_output);
    axis square
    caxis([0 maxl])
    title('Max Pooling Result');

    % Average Pooling Result
    subplot(1, 3, 3);
    imagesc(avg_output);
    axis square
    caxis([0 maxl])
    title('Average Pooling Result');

    cd(resdir);
    figure(pattern);
    set(gcf, 'renderer', 'painters');
    print(gcf, strcat('figure_dimension', num2str(dimension(pattern)), '_line_intensity', num2str(line_intensity(pattern)), '_background_intensity', num2str(background_intensity(pattern)), '.tiff'), '-dtiff', '-r300');

    set(gcf, 'renderer', 'painters');
    print(gcf, '-dpng', strcat('figure_dimension', num2str(dimension(pattern)), '_line_intensity', num2str(line_intensity(pattern)), '_background_intensity', num2str(background_intensity(pattern)), '.png'));
end

function square_pattern = generate_square_pattern(dim, line_intensity, background_intensity)
    square_pattern = background_intensity * ones(dim);

    % Set diagonal line
    for i = 1:dim
        square_pattern(i, i) = line_intensity;
    end
end

function output_matrix = max_pooling(input_matrix, size, stride)
    [rows, cols] = size(input_matrix);
    output_rows = floor((rows - size) / stride) + 1;
    output_cols = floor((cols - size) / stride) + 1;

    output_matrix = zeros(output_rows, output_cols);

    for i = 1:output_rows
        for j = 1:output_cols
            window = input_matrix((i-1)*stride + 1 : (i-1)*stride + size, ...
                                  (j-1)*stride + 1 : (j-1)*stride + size);
            output_matrix(i, j) = max(window(:));
        end
    end
end

function output_matrix = average_pooling(input_matrix, size, stride)
    [rows, cols] = size(input_matrix);
    output_rows = floor((rows - size) / stride) + 1;
    output_cols = floor((cols - size) / stride) + 1;

    output_matrix = zeros(output_rows, output_cols);

    for i = 1:output_rows
        for j = 1:output_cols
            window = input_matrix((i-1)*stride + 1 : (i-1)*stride + size, ...
                                  (j-1)*stride + 1 : (j-1)*stride + size);
            output_matrix(i, j) = mean(window(:));
        end
    end
end
