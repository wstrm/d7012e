data RedBlack = Red | Black
data RbTree a = Leaf | Node a RedBlack (RbTree a) (RbTree a)

rbCheckRb Leaf = True
rbCheckRb (Node _ Red (Node v1 Black t1 t2) (Node v2 Black t3 t4)) = rbCheckRb (Node v1 Black t1 t2) && rbCheckRb (Node v2 Black t3 t4)
rbCheckRb (Node _ Black left right) = rbCheckRb left && rbCheckRb right
rbCheckRb _ = False