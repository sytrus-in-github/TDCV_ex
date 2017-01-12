function [] = infnanguard(a)
  if any(isnan(a(:)))
      error('NaN value detected.') 
  elseif any(isinf(a(:)))
      error('Infinity value detected.')
  end
end