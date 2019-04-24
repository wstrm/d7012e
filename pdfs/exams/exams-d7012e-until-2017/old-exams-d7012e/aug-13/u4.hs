class MyClass a where
	compute :: a -> a -> Int
	unit :: a

instance MyClass Int where
	compute = (+)
	unit = 0

instance MyClass Char where
	compute x 'y' = 0
	compute _ _ = 1
	unit = 'y'

fun x = compute (length "x") (length "unit") + compute x unit