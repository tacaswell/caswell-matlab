function ec = e_test
    test = ones
    
    
    
end
    


function thetarr,w

theta = fltarr(w,w,/nozero)
xc = float(w-1) / 2.
yc = float(w-1) / 2.

x = (findgen(w) - xc)
x(xc) = 1e-5
y = (findgen(w) - yc)

for j = 0, w-1 do begin
	theta(*,j) = atan( y(j),x )
endfor

return,theta
end

rsq = rsqd( extent )
t = thetarr( extent )
mask = rsq le (float(extent)/2.)^2
mask2 = make_array( extent , extent , /float, /index ) mod (extent ) + 1.
mask2 = mask2 * mask
mask3= (rsq * mask) + (1./6.)
cen = float(extent-1)/2.
cmask = cos(2*t) * mask
smask = sin(2*t) * mask
cmask(cen,cen) = 0.
smask(cen,cen) = 0.



    

for i=0,nmax-1 do e(i) = sqrt(( total( suba(*,*,i) * cmask )^2 ) +$
	( total( suba(*,*,i) * smask )^2 )) / (m(i)-suba(cen,ycen,i)+1e-6)
