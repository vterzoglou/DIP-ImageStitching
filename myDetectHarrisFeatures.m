function corners = myDetectHarrisFeatures(varargin)

    %parse input variables
    if(nargin == 1)
        I = varargin{1};
        k = 0.05;
        sigma = 5/3;
        Rthres = 100;
        windowsize = 5;
    elseif(nargin == 4)
        [I,k,sigma,Rthres] = varargin{1:4};
        windowsize = 5;
    elseif(nargin == 5)
        [I,k,sigma,Rthres,windowsize] = varargin{1:5};
    end
    
    N1 = size(I,1);
    N2 = size(I,2);
 
    %Construct Gaussian window
    u1vals = [0:windowsize-1]-floor(windowsize/2);
    u2vals = [0:windowsize-1]-floor(windowsize/2);
    [U1,U2] = meshgrid(u1vals(1:end),u2vals(1:end));    
    W = exp(-(U1.^2+U2.^2)/(2.*sigma.^2));
    
    %Derivative kernel towards N2 direction ie. horizontal
    G2 = [1,0,-1;
          2,0,-2;
          1,0,-1];
    %Derivative kernel towards N2 direction ie. vertical
    G1 = transpose(G2);
    
    %Compute derivatives on the full image, pass only the parts needed for
    %each pixel to iscorner.
    I1 = conv2(I,G1,'valid');
    I2 = conv2(I,G2,'valid');
    
    %Starting point to detect harris features is [sp,sp], some points on
    %the borders are excluded
    sp = (windowsize+3)/2;

    %We dont know how many corners there will be in the end, so its always
    %best to allocate more space and trim afterwards
    c = 0;
    b = zeros(N1-2*sp+2,N2-2*sp+2);
    corners = zeros((N1-2*sp+2)*(N2-2*sp+2),2);

    for p1 = sp:N1-sp+1
        for p2 = sp:N2-sp+1
            b(p1-2,p2-2) = isCorner(k,Rthres,W,I1(p1+u1vals-1,p2+u2vals-1),I2(p1+u1vals-1,p2+u2vals-1));
            if(b(p1-2,p2-2)==1)
               c = c+1;
               corners(c,1) = p1;
               corners(c,2) = p2;
            end
        end
    end
    corners = corners(1:c,:);
    
end