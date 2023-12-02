import Data.Functor ((<&>))
import Data.Char (digitToInt)
import Data.List (elemIndex, delete)
import Data.Maybe (isNothing, fromJust)
readInput input = readFile input <&> lines

data Game a = Game Int [a]
        deriving (Show)

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn _ [] = []
splitOn c xs = takeWhile (/= c) xs : splitOn c (dropWhile (== c) (dropWhile (/= c) xs))

countCubes :: [String] -> (Int, Int, Int) -> [(Int, Int, Int)]
countCubes [] t = []
countCubes (x:xs) (b,r,g) = (rCount, gCount, bCount) : countCubes xs (0, 0,0)
    where x' = map (delete ',' ) $ splitOn ' ' x
          r' = elemIndex "red" x'
          g' = elemIndex "green" x'
          b' = elemIndex "blue" x'
          bCount
            | isNothing b' = b
            | otherwise = b + (read (x' !! (fromJust b' - 1)) :: Int)
          rCount
            | isNothing r' = r
            | otherwise = r + (read (x' !! (fromJust r' - 1)) :: Int)
          gCount
            | isNothing g' = g
            | otherwise = g + (read (x' !! (fromJust g' - 1)) :: Int)

parse :: [[Char]] -> [Game (Int, Int, Int)]
parse [] = []
parse (x:xs) = Game (d) (count) : parse xs
    where xs' = splitOn ':' (drop 5 x)
          d = read (head xs') :: Int
          xs'' = splitOn ';' (head $ tail xs')
          count = countCubes xs'' (0,0,0)


fst3 (x, _, _) = x
snd3 (_, x, _) = x
thrd3 (_, _, x) = x
solve1 :: [Game (Int, Int, Int)] -> Int -> Int -> Int -> [Int]
solve1 xs r' g' b' = [x | (Game x r) <- xs, all (<= r') (reds r), all (<= g') (greens r), all (<= b') (blues r)]
    where blues = map thrd3
          reds = map fst3
          greens = map snd3

-- solve2 :: [Game (Int, Int, Int)] -> [[Int]]
solve2 xs = sum [(maximum $ blues r) * (maximum $ reds r) * (maximum $ greens r) | (Game x r) <- xs] 
    where blues = map thrd3
          reds = map fst3
          greens = map snd3


main :: IO ()
main = do
        input <- readInput "./inputs/input"
        print $ sum $ solve1 (parse input) 12 13 14
        print $ solve2 (parse input)
