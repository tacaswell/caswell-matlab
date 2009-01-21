function stpp=em(N,Z,b)
    g = sqrt(1/(1-b^2));
stpp=    4*pi()*N*Z*(1.6e-19/3.3e-10)^4*(6.2e5)^2/(.5* b^2)*...
         (log(2*(b*g)^2*5e5/(Z * 12)) - b^2);