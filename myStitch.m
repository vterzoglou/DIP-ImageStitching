
%colored images are passed, but the reorientation is done
%based on the greyscale ones.
function imgnew = myStitch(varargin)

    %parse inputs
    if(nargin == 4)
        [I1c,I2c,corners1,corners2] = varargin{1:4};
    elseif(nargin == 5)
        [I1c,I2c,corners1,corners2,npoints] = varargin{1:5};
    end

    I1 = I1c(:,:,1);
    I2 = I2c(:,:,1);
    
    %II2 is the restored/rotated form of I2
    if(nargin == 4)
        T = myTransformEstimation(I1,I2,corners1,corners2);
    elseif(nargin == 5)
        T = myTransformEstimation(I1,I2,corners1,corners2,npoints);
    end
    
    %reorient the colored img
    if(T(1,1)>0)
        thetahat = asind(T(2,1));
    else
        thetahat = 180-asind(T(2,1));
    end
    II2c = myImgRotation(I2c,thetahat);

    %find the vertical (deltau1) and horizontal (deltau2) displacement between the
    %rotated/reoriented img2 and img1
    [u1,u2] = fwd([1,1],round(thetahat,5),size(I2,1),size(I2,2));
    deltau1 = ceil(T(3,2)-u1+1);
    deltau2 = ceil(T(3,1)-u2+1);
    
    %Fill a new image containing both the original colored image I1 and the
    %rotated form of colored image I2.
    imgnew = fillImg(I1c,II2c,deltau1,deltau2);

end