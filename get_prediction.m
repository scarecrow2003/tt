function [input_prediction, recommendation, recommendtion_prediction] = get_prediction(input_data)
    data = csvimport('result.csv', 'columns', [1, 2, 3, 4, 5, 6], 'noHeader', true);
    data_length = size(data, 1);
    num_pro = zeros(49, 1);
    data_temp = reshape(data, [6 * data_length, 1]);
    for i=1:49
        num_pro(i) = sum(data_temp == i) / 6 * data_length;
    end
    T = clusterdata(data, 20);
    centroid = zeros(20, 6);
    cluster_pro = zeros(20, 1);
    for i=1:20
        cluster = data(find(T==i), :);
        centroid(i, :) = mean(cluster, 1);
        cluster_pro(i, 1) = size(cluster, 1) / data_length;
    end
    all = combnk(1:49, 6);
    all_length = size(all, 1);
    all_pro = zeros(all_length, 1);
    for i=1:all_length
        display(strcat('calculate: ', num2str(i)));
        one_line = all(i, :);
        one_pro = 0;
        for j=1:20
            distance = norm(one_line - centroid(j, :));
            one_pro = one_pro + cluster_pro(j) * exp(-distance);
        end
        for j=1:6
            one_pro = one_pro * num_pro(one_line(j));
        end
        all_pro(i, 1) = one_pro;
    end
    [~, I] = sort(all_pro, 'descend');
    recommendation = all(I(1:10), :);
    recommendtion_prediction = all_pro(I(1:10));
    if size(input_exist, 2) == 6
        for i=1:all_length
            if all(i, :) == input_data
                input_prediction = all_pro(i);
                break;
            end
        end
    end
end

%     best_cluster = 0;
%     best_err = 1e20;
%     for i=3:100
%         display(strcat(num2str(i), ' clusters.'));
%         T = clusterdata(data, i);
%         err = 0;
%         for j=1:i
%             cluster = data(find(T==j), :);
%             centroid = mean(cluster, 1);
%             err = err + sum(vecnorm((cluster - centroid)').^2);
%         end
%         display(strcat('error :', num2str(err)));
%         if err < best_err
%             best_err = err;
%             best_cluster = i;
%         end
%     end
