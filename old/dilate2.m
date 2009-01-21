function out = dilate2(in,b)
  sz_in = size(in);
  h = sz_in(1);
  k =1;
  out = zeros(prod(sz_in),(2*b+1)^2);
  for ci=-b:b
    for ri = -b:b
      i = h*ci+ri;
      if i==0
	out(:,k) = in(1:end)';
      end
      if i<0
	out((1-i):end,k) = in(1:(end+i))';
      end

      if i>0
	out(1:(end-i),k) = in((1+i):end)';
      end
      k = k+1;
    end


  end
    out = reshape(max(out,[],2),sz_in)+(in==0);
  %  out = out';
  %  out = reshape(max(out),sz_in)+(in==0);
end