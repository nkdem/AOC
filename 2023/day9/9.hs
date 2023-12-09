transform :: [Int] -> [Int]
transform [] = []
transform (x : y : xs) = (y - x) : transform (y : xs)
transform (x : xs) = [x]

transform' :: [Int] -> [[Int]]
transform' [] = []
transform' xs
    | all (\x -> x == head new) new = new : [replicate (length new) 0]
    | otherwise = new : transform' new
  where
    new = init $ transform xs

extrapolate :: [[[Int]]] -> Int
extrapolate xs = sum [sum $ map last history | (history, i) <- zip xs [0 ..]]

extrapolate2 xs = sum [foldl (\x y -> y - x) 0 $ reverse $ map head history | (history, i) <- zip xs [0 ..]]

main :: IO ()
main = do
    xs <- map (map (\x -> read (x) :: Int) . words) . lines <$> readFile "inputs/input"
    let transformedUnclean = map transform' xs
    let transformed = map (\i -> xs !! i : transformedUnclean !! i) [0 .. length xs - 1]
    print $ extrapolate transformed -- part a
    print $ extrapolate2 $ transformed

-- print xs
