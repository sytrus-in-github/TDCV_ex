function [] = infnanguard(a)
  if any(isnan(a(:)))
      disp(a)
      error('NaN value detected.') 
  elseif any(isinf(a(:)))
      disp(a)
      error('Infinity value detected.')
  end
end