pow2 = powersof 1 2
  where powersof n m = n : powersof (n*m) m
