function c = isCorner(k,Rthres,W,I1,I2)
    
    Z1 = (I1.^2).*W;
    Z2 = (I2.^2).*W;
    Z3 = (I1.*I2).*W;
        
    M11 = sum(sum(Z1));
    M12 = sum(sum(Z3));
    M22 = sum(sum(Z2));
   
    R = M11*M22-M12.^2-k*(M11+M22).^2;
    if(R >= Rthres)
        c = 1;
    else
        c = 0;
    end
end