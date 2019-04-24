foldl2 _ acc [] = acc
foldl2 f acc (h:tl) = foldl2 f (f acc h) tl

len2 = foldl2 (\acc _ -> acc+1) 0