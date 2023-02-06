
function corners = part_1_3(varargin)
    %parse input variables
    if(nargin == 1)
        I = varargin{1};
    elseif(nargin == 4)
        [I,k,sigma,Rthres] = varargin{1:4};
    elseif(nargin == 5)
        [I,k,sigma,Rthres,windowsize] = varargin{1:5};
    end

    %plot original img
    figure('windowstate','maximized');
    I = rescale(I);
    imshow(I);
    title("Original img","Interpreter","latex");


    %plot image with spotted harris features
    figure('windowstate','maximized');
    imshow(I);
    hold on

    if (nargin == 1)
        corners = myDetectHarrisFeatures(I);
    elseif (nargin == 4)
        corners = myDetectHarrisFeatures(I,k,sigma,Rthres);
    elseif (nargin == 5)
        corners = myDetectHarrisFeatures(I,k,sigma,Rthres,windowsize);
    end

    for i = 1:size(corners,1)
        rectangle('Position',[corners(i,2)-2,corners(i,1)-2,5,5],'EdgeColor','r');
    end
    title("My harris corner detector","Interpreter","latex");
    
%     plot(corners(:,2),corners(:,1),'+g');
%     title("My harris corner detector");


end