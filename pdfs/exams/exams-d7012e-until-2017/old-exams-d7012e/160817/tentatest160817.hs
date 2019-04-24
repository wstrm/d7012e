data MTree a = Node a [MTree a]

checkBin (Node v mt) = if (length mt>2) then False else foldr (&&) True (map checkBin mt)
flatten (Node v mt) = v:(foldr (++) [] (map flatten mt))


data Op = Add | Mul

calc = calc' 0 Add
calc' acc op =
	do
		print acc
		s <- getLine
		case s of
			"+" ->
				do
					calc' acc Add
			"*" ->
				do
					calc' acc Mul
			"e" -> return ""
			_ ->
				case op of
					Add -> calc' (acc+(read s)) Add
					Mul -> calc' (acc*(read s)) Add

