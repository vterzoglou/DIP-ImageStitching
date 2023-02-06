
%{
Function that calculates the position[u1,u2] of a pixel P:(p1,p2) of an image with
dimensions [N1,N2] after rotation by an angle of theta
%}

function [u1,u2]  = fwd(P,theta,N1,N2)
    p1 = P(1);
    p2 = P(2);
    
    p1u = floor(1*cosd(theta)-1*sind(theta));
    p1v = floor(1*sind(theta)+1*cosd(theta));
    
    p2u = floor(N1*cosd(theta)-1*sind(theta));
    p2v = floor(N1*sind(theta)+1*cosd(theta));
    
    p3u = floor(1*cosd(theta)-N2*sind(theta));
    p3v = floor(1*sind(theta)+N2*cosd(theta));
    
    p4u = floor(N1*cosd(theta)-N2*sind(theta));
    p4v = floor(N1*sind(theta)+N2*cosd(theta));
    
    mu = min([p1u,p2u,p3u,p4u]);
    Mu = max([p1u,p2u,p3u,p4u]);
    mv = min([p1v,p2v,p3v,p4v]);
    Mv = max([p1v,p2v,p3v,p4v]);  
    
    u1 = ceil([cosd(theta),-sind(theta)]*[p1;p2])-mu+1;
    u2 = ceil([sind(theta),cosd(theta)]*[p1;p2])-mv+1;
end