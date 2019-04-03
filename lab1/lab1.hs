type Size = Int

type Index = Int

type KSet = [Int]

type KSets = [KSet]

type List = [Int]

type PrintSets = [(Size, Index, Index, KSet)]

makePrintSets :: KSets -> PrintSets
formatPrintSets :: PrintSets -> String
producePrintSets :: KSets -> String
producePrintSets = formatPrintSets . makePrintSets

kSmallestSet :: List -> KSets
kSmallestSet [] = error "empty list has no smallest k-sets"
kSmallestSet l = [l]

main = do
  print $ kSmallestSet [-1, 2, -3, 4, -5]
  print $ kSmallestSet [x * (-1) ^ x | x <- [1 .. 100]] -- Test case 1
  print $ kSmallestSet [24, -11, -34, 42, -24, 7, -19, 21] -- Test case 2
  print $ kSmallestSet [3, 2, -4, 3, 2, -5, -2, 2, 3, -3, 2, -5, 6, -2, 2, 3] -- Test case 3
