module Main where
import Data.Functor

split :: Read b => [String] -> [[b]]
split s = case break (== "") s of 
        (a,_:b) -> fmap read a : split b 
        (a, _)  -> [fmap read a] 


readInput :: IO [[Int]]
readInput = readFile "./inputs/1a" <&> lines <&> split

solve1 :: [[Int]] -> Int
solve1 = maximum . map sum 


main :: IO ()
main = do
    readInput >>= print . solve1

