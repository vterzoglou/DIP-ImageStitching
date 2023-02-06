
function d = myLocalDescriptor(I,p,rhom,rhoM,rhostep,N)
    p1 = p(1);
    p2 = p(2);
  
    rhovals = [rhom:rhostep:rhoM];
    thetavals = 2*pi/N.*[0:N-1];
    
    %output vector
    xrho = zeros(length(rhovals),length(thetavals));
    
    I = double(I);
    
    for k = 1:length(rhovals)
        rho = rhovals(k);
        for j = 1:length(thetavals)
            theta = thetavals(j);
            [x,y] = pol2cart(theta,rho);
            pp1 = p1+x;
            pp2 = p2+y;
            
            %if out of borders
            if(pp1>size(I,1)-1 || pp1<2 ||pp2<2|| pp2 >size(I,2)-1)
                continue
            end
            
        
            %if the new point coordinates are integers
            %assign value of image at that point
            if(mod(pp1,1)==0 && mod(pp2,1)==0)
                xrho(k,j) = I(pp1,pp2);                
                continue
             
            end

            %interpolate for the value of I at the new point
            I1 = (ceil(pp2)-pp2)/(ceil(pp2)-floor(pp2))*I(floor(pp1),floor(pp2))...
                +(pp2-floor(pp2))/(ceil(pp2)-floor(pp2))*I(floor(pp1),ceil(pp2));
            
            I2 = (ceil(pp2)-pp2)/(ceil(pp2)-floor(pp2))*I(ceil(pp1),floor(pp2))...
                +(pp2-floor(pp2))/(ceil(pp2)-floor(pp2))*I(ceil(pp1),ceil(pp2));
            
            xrho(k,j) = (ceil(pp1)-pp1)/(ceil(pp1)-floor(pp1))*I1...
                        +(pp1-floor(pp1))/(ceil(pp1)-floor(pp1))*I2;
        end
    end
    d = mean(xrho,2);
end