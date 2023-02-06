
%varargin is used to set default value(20) to the parameter npoints
function T = myTransformEstimation(varargin)
    %parse inputs
    [I1,I2,corners1,corners2] = varargin{1:4};
    if(nargin == 5)
        npoints = varargin{5};
    else
        npoints = 20;
    end
    
    
    %Extract features
    features1 = zeros(size(corners1,1),15);
    features2 = zeros(size(corners2,1),15);
    for i = 1:size(corners1,1)
        features1(i,:) = myLocalDescriptor(I1,[corners1(i,1),corners1(i,2)],1,15,1,25);
    end
    for i = 1:size(corners2,1)
        features2(i,:) = myLocalDescriptor(I2,[corners2(i,1),corners2(i,2)],1,15,1,25);
    end
    
    %idx1,idx2 contain the sorted best matching features of the two sets
    [dist,idx1] = pdist2(features1,features2,'euclidean','smallest',1);
    [~,idx2] = sort(dist);
    idx1 = idx1(idx2);
    
    %npoints are used from each dataset(the best matching feature locations)
    %to find the optimal rotation and translation using the singular value  
    %decomposition of the covariance matrix
    
    %datasets
    A = corners1(idx1(1:npoints),:);
    B = corners2(idx2(1:npoints),:);
    
    %covariance matrix
    H = transpose(B-mean(B))*(A-mean(A));
    [U,~,V] = svd(H);
    
    %rotation matrix
    R = V*transpose(U);
    
    %translation matrix
    t = transpose(mean(A))-R*transpose(mean(B));
    
    %transformation matrix
    T =[R(1,1),R(1,2),0;R(2,1),R(2,2),0;t(2),t(1),1];


end