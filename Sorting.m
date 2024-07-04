% Generate random 2D points
numPoints = 100;
points = rand(numPoints, 2);

% Plot the original points
figure;
scatter(points(:,1), points(:,2), 'filled');
title('Original Points');
xlabel('X');
ylabel('Y');

% Define the number of clusters
numClusters = 4;

% Perform k-means clustering
[idx, centroids] = kmeans(points, numClusters);

% Plot the clustered points
figure;
hold on;
colors = lines(numClusters);
for i = 1:numClusters
    clusterPoints = points(idx == i, :);
    scatter(clusterPoints(:,1), clusterPoints(:,2), 36, colors(i, :), 'filled');
end
scatter(centroids(:,1), centroids(:,2), 100, 'k', 'x');
title('Clustered Points');
xlabel('X');
ylabel('Y');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centroids');
hold off;

% Sort points within each cluster by their distance to the cluster centroid
sortedPoints = cell(numClusters, 1);
for i = 1:numClusters
    clusterPoints = points(idx == i, :);
    centroid = centroids(i, :);
    distances = sqrt(sum((clusterPoints - centroid).^2, 2));
    [~, sortedIdx] = sort(distances);
    sortedPoints{i} = clusterPoints(sortedIdx, :);
end

% Display sorted points for each cluster
for i = 1:numClusters
    fprintf('Cluster %d sorted points:\n', i);
    disp(sortedPoints{i});
end

% Plot the sorted points for one of the clusters
figure;
scatter(sortedPoints{1}(:,1), sortedPoints{1}(:,2), 'filled');
title('Sorted Points in Cluster 1');
xlabel('X');
ylabel('Y');
