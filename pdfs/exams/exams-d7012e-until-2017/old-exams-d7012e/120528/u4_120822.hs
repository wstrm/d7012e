palstring =
	do
		s <- getLine
		putStr (s ++ reverse s ++ "\n")
		if s=="" then return s else palstring