function imgnew = fillImg(I1c,II2c,deltau1,deltau2)

    NC = size(I1c,3);
    N1 = size(I1c,1);
    N2 = size(I1c,2);
    M1 = size(II2c,1);
    M2 = size(II2c,2);
    
    
    %fill in the new img
    l1new = max([M1, N1, min([N1+abs(deltau1), M1+abs(deltau1)])] );
    l2new = max([M2, N2, min([N2+abs(deltau2), M2+abs(deltau2)])] );
    
    imgnew = zeros(l1new,l2new,NC,'like',I1c);
    for chan = 1:NC
        
        %case1
        if(deltau1 >= 0 && deltau2 > 0)
            imgnew(1:N1,1:N2,chan) = I1c(1:N1,1:N2,chan);
            for i = N1+1:abs(deltau1)+M1-1
                for j = abs(deltau2):abs(deltau2)+M2-1
                    imgnew(i,j,chan) = II2c(i-abs(deltau1)+1,j-abs(deltau2)+1,chan);
                end
            end

            for i = abs(deltau1):N1
                for j = N2+1:abs(deltau2)+M2-1
                    imgnew(i,j,chan) = II2c(i-abs(deltau1)+1,j-abs(deltau2)+1,chan);
                end
            end
        
        %case2
        elseif (deltau1 <= 0 && deltau2 >= 0)
            imgnew(1+abs(deltau1):N1+abs(deltau1),1:N2,chan) = I1c(1:N1,1:N2,chan);
            for i = [1:abs(deltau1),abs(deltau1)+N1+1:M1]
                for j = abs(deltau2):abs(deltau2)+M2-1
                    imgnew(i,j,chan) = II2c(i,j-abs(deltau2)+1,chan);
                end
            end

            for i = abs(deltau1):M1
                for j = N2+1:abs(deltau2)+M2-1
                    imgnew(i,j,chan) = II2c(i,j-abs(deltau2)+1,chan);
                end
            end
        
        %case3
        elseif(deltau1 > 0 && deltau2 <= 0)
            imgnew(1:N1,abs(deltau2)+1:abs(deltau2)+N2,chan) = I1c(1:N1,1:N2,chan);
            for i = N1+1:abs(deltau1)+M1-1
                for j = 1:M2
                    imgnew(i,j,chan) = II2c(i-abs(deltau1)+1,j,chan);
                end
            end

            for i = abs(deltau1):abs(deltau1)+M1-1
                for j = [1:abs(deltau2),abs(deltau2)+N2+1:M2]
                    imgnew(i,j,chan) = II2c(i-abs(deltau1)+1,j,chan);
                end
            end
        
        %case4
        elseif(deltau1 < 0 && deltau2 <= 0)
            imgnew(abs(deltau1)+1:abs(deltau1)+N1,abs(deltau2)+1:abs(deltau2)+N2,chan) = I1c(1:N1,1:N2,chan);
            for i = [1:abs(deltau1),abs(deltau1)+N1+1:M1]
                for j = 1:M2
                    imgnew(i,j,chan) = II2c(i,j,chan);
                end
            end

            for i = abs(deltau1)+1:M1
                for j = [1:abs(deltau2),abs(deltau2)+N2+1:M2]
                    imgnew(i,j,chan) = II2c(i,j,chan);
                end
            end
            
        end
    end
end