type Time = Int
type Distance = Int
type Speed = Int
type RaceDetails = (Time, Distance)

parse :: FilePath -> IO [RaceDetails]
parse input = do
    (x:xs) <- map (map (\y -> read y :: Int) . tail . words) . lines <$> readFile input
    return $ zip x (head xs)

calcDistance :: Speed -> Time -> Distance
calcDistance v t = v * t

solve1 :: [RaceDetails] -> Int
solve1 races = product $ map (length . \(t, d) -> filter (> d) [calcDistance x (t - x) | x <- [0..t]]) races

main :: IO ()
main = do
    races <- parse "inputs/input"
    print $ solve1 races