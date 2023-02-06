
function G = myImgRotation(A, ang)
    
    if(ang < 0)
        ang = ang+360;
    end
    A = double(A);
    N1 = size(A,1);
    N2 = size(A,2);
    NC = size(A,3);
    
    %calculate the new positions of the corners of the image in order to 
    %find the size of new img (lu X lv) and translation-displacement(
    %[mu;mv] )
    p1u = floor(1*cosd(ang)-1*sind(ang));
    p1v = floor(1*sind(ang)+1*cosd(ang));
    
    p2u = floor(N1*cosd(ang)-1*sind(ang));
    p2v = floor(N1*sind(ang)+1*cosd(ang));
    
    p3u = floor(1*cosd(ang)-N2*sind(ang));
    p3v = floor(1*sind(ang)+N2*cosd(ang));
    
    p4u = floor(N1*cosd(ang)-N2*sind(ang));
    p4v = floor(N1*sind(ang)+N2*cosd(ang));
    
    mu = min([p1u,p2u,p3u,p4u]);
    Mu = max([p1u,p2u,p3u,p4u]);
    mv = min([p1v,p2v,p3v,p4v]);
    Mv = max([p1v,p2v,p3v,p4v]);  
    
    lu = Mu-mu+1;
    lv = Mv-mv+1;

    G = zeros(lu,lv,NC);
    G = uint8(G);
    
    for c= 1:NC
        for u = 1:lu
            for v = 1:lv  
                
                %cc counts how many pixels will contribute to the new
                %pixel value, sum is the sum of these pixels' values
                cc =0;
                sum = 0;
                
                
                %inverse transform for each pixel in new img
                x = floor([cosd(ang),sind(ang)]*[u+mu-1;v+mv-1]);
                y = floor([-sind(ang),cosd(ang)]*[u+mu-1;v+mv-1]);
                
                %if non applicable, ie pixel doesnt correspond to initial
                %img, then leave black
                if(x<0 || y<=0 || x>N1 || y>N2)
                    continue
                end
                
                %if on borders
                if(x==0 && y>=1 && y<=N2)
                    G(u,v,c) = uint8(A(x+1,y,c));
                    continue
                end
                if(x==N1+1 && y>=1 && y<=N2)
                    G(u,v,c) = uint8(A(x-1,y,c));
                    continue
                end
                if(y==0 && x>=1 && x<=N1)
                    G(u,v,c) = uint8(A(x,y+1,c));
                    continue
                end
                if(y==N2+1 && x>=1 && x<=N1)
                    G(u,v,c) = uint8(A(x,y-1,c));
                    continue
                end

                %add contribution of each neighbor
                if(x < N1)
                    cc = cc+1;
                    sum = sum +A(x+1,y,c);
                end
                if(x > 1)
                    cc = cc+1;
                    sum = sum+A(x-1,y,c);
                end
                if(y < N2)
                    cc = cc +1;
                    sum = sum+A(x,y+1,c);
                end
                if(y > 1)
                    cc = cc+1;
                    sum = sum +A(x,y-1,c);
                end
                
                %get the mean as new value
                G(u,v,c) = uint8(sum/cc);

            end
        end
    end
end