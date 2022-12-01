module Main where
import Data.Functor

split :: Read b => [String] -> [[b]]
split s = case break (== "") s of
        (a,_:b) -> (read <$> a) : split b 
        (a, _)  -> [read <$> a]


readInput :: IO [[Int]]
readInput = readFile "./inputs/1" <&> lines <&> split

solve1 :: [[Int]] -> Int
solve1 = maximum . map sum

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys) | x < y = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

mergeSort :: [Int] -> [Int]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort $ take mid xs ) (mergeSort $ drop mid xs)
        where mid = length xs `div` 2

solve2 :: [[Int]] -> Int
solve2 = sum . take 3 . reverse . mergeSort . map sum

main :: IO ()
main = do
    readInput >>= print . solve1
    readInput >>= print . solve2

