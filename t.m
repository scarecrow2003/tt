funtion [input_prediction, recommendation, recommendtion_prediction] = get_prediction(input)
    data = [];
    for i=1:100
        r = randperm(49);
        data = [data; sort(r(1:7))];
    end
    % best_cluster = 0;
    % best_err = 1e20;
    % for i=3:100
    %     display(strcat(num2str(i), ' clusters.'));
    %     T = clusterdata(data, i);
    %     err = 0;
    %     for j=1:i
    %         cluster = data(find(T==j), :);
    %         centroid = mean(cluster, 1);
    %         err = err + sum(vecnorm((cluster - centroid)').^2);
    %     end
    %     display(strcat('error :', num2str(err)));
    %     if err < best_err
    %         best_err = err;
    %         best_cluster = i;
    %     end
    % end
    
    display(strcat('use cluster: ', num2str(best_cluster)));
    tree = linkage(data, 'average');
    dendrogram(tree);
end
