
function d = myLocalDescriptorUpgrade(I,p,rhom,rhoM,rhostep,N)
    p1 = p(1);
    p2 = p(2);
    N1 = size(I,1);
    N2 = size(I,2);
    
    %mask used to compute Laplacian at a point
    mask = [0,1,0;
            1,-4,1;
            0,1,0];
    
    rhovals = [rhom:rhostep:rhoM];
    thetavals = 2*pi/N.*[0:N-1];
    
    %output matrix
    xhro = zeros(length(rhovals),length(thetavals));


    I = double(I);
    
    for k = 1:length(rhovals)
        rho = rhovals(k);
        for j = 1:length(thetavals)
            theta = thetavals(j); 
            
            [q1,q2] = pol2cart(theta,rho);
            pp1 = p1 + q1;
            pp2 = p2 + q2;
            
            
            %If Laplacian does not exist
            if(pp1<2 || pp2<2 || pp1>N1-1 || pp2>N2-1)
                continue;
            end
                
            %If new point coordinates correspond to
            %cartesian coordinates of a pixel of the original img
            if(mod(pp1,1)==0 && mod(pp2,1)==0)
                patch = I(pp1-1:pp1+1,pp2-1:pp2+1);
                xhro(k,j) = conv2(patch,mask,'valid');
            else
                
                %Interpolate
                I1 = (ceil(pp2)-pp2)/(ceil(pp2)-floor(pp2))*conv2(I(floor(pp1)-1:floor(pp1)+1,floor(pp2)-1:floor(pp2)+1),mask,'valid')...
                +(pp2-floor(pp2))/(ceil(pp2)-floor(pp2))*conv2(I(floor(pp1)-1:floor(pp1)+1,ceil(pp2)-1:ceil(pp2)+1),mask,'valid');
            
                I2 = (ceil(pp2)-pp2)/(ceil(pp2)-floor(pp2))*conv2(I(ceil(pp1)-1:ceil(pp1)+1,floor(pp2)-1:floor(pp2)+1),mask,'valid')...
                +(pp2-floor(pp2))/(ceil(pp2)-floor(pp2))*conv2(I(ceil(pp1)-1:ceil(pp1)+1,ceil(pp2)-1:ceil(pp2)+1),mask,'valid');
            
                xhro(k,j) = (ceil(pp1)-pp1)/(ceil(pp1)-floor(pp1))*I1...
                        +(pp1-floor(pp1))/(ceil(pp1)-floor(pp1))*I2;
                
            end            
        end
    end
    d = mean(xhro,2);
end