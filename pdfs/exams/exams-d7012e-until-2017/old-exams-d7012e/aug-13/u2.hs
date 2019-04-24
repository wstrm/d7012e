getDBValueForKey :: String -> IO (Maybe Float)
getDBValueForKey s =
	do
		return (Just 5.3)

diff =
	do
		aaa <- getDBValueForKey "AAA"
		bbb <- getDBValueForKey "BBB"
		let a = case (aaa, bbb) of
			(Just a, Just b) -> Just (a-b)
			_ -> Nothing
		return a
	where
		getA = getDBValueForKey "AAA"
		getB = getDBValueForKey "BBB"
