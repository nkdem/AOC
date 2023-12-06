type Time = Int
type Distance = Int
type Speed = Int
type RaceDetails = (Time, Distance)

parse1 :: FilePath -> IO [RaceDetails]
parse1 input = do
    (x:xs) <- map (map (\y -> read y :: Int) . tail . words) . lines <$> readFile input
    return $ zip x (head xs)

parse2 :: FilePath -> IO RaceDetails 
parse2 input = do 
    (x:xs) <- map ((\x -> read x:: Int) . concat . tail . words) . lines <$> readFile input
    return (x, head xs)
    

calcDistance :: Speed -> Time -> Distance
calcDistance v t = v * t

solve :: [RaceDetails] -> Int
solve races = product $ map (length . \(t, d) -> filter (> d) [calcDistance x (t - x) | x <- [0..t]]) races

main :: IO ()
main = do
    races1 <- parse1 "inputs/input"
    races2 <- parse2 "inputs/input"
    print $ solve races1
    print $ solve [races2]