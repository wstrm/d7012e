cashreg = cashreg' 0

cashreg' sum =
	do
		s <- getLine
		case s of
			"" ->
				do
					print sum
					putStrLn "-------"
					cashreg' 0
			"e" -> return ""
			_ -> cashreg' ((read s)+sum)
