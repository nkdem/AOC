import Data.Functor ((<&>))
readInput input = readFile input <&> lines

type Winning = [Int]
type Hand = [Int]

splitOn :: Eq a => a -> [a] -> [a] -> [[a]]
splitOn _ acc []= [acc]
splitOn c acc (x:xs)
    | x == c = acc : splitOn c [] xs
    | otherwise = splitOn c (acc ++ [x]) xs


strToDigits :: [String] -> [Int]
strToDigits [] = []
strToDigits (x:xs)
    | x == "|" = (-1) : strToDigits xs
    | otherwise = read x : strToDigits xs

intsToTuple :: [Int] -> (Winning, Hand)
-- seperate at -1 
intsToTuple xs = (takeWhile (/= -1) xs, tail $ dropWhile (/= -1) xs)

parse :: String -> (Winning, Hand)
parse str = intsToTuple $ strToDigits $ concatMap words xs
    where xs = tail $ splitOn ':' [] str

solve1 :: [(Winning, Hand)] -> [Int]
solve1 =  map (length . (\(winning,hand) -> filter (`elem` hand) winning))


-- solve2 xs = [f i xs | i <- [1..(length xs )]]


-- solve2 xs= length xs + (length (concat (apply [] initial)) ++
--     where
--         initial = [1 .. length xs]
--         guide = solve1 xs
--         apply acc [] = []
--         apply acc (x:xs) = acc' : apply [] xs
--             where cards = [x+1..(x+(guide !! (x-1)))]
--                   acc' = acc ++ cards

solve2 xs = f 1 initial guide
    where initial = replicate (length xs) 1
          guide = solve1 xs
          f i countList guide
            | i >= length guide = countList
            | otherwise = nexttCards' ++ f (i+1) nexttCards' guide
                where nexttCards' = [i+1 ..  i + guide !! (i - 1)]

main :: IO ()
main = do
    input <- readInput "inputs/sample"
    print $ sum $ map (\x -> 2 ^ (x-1)) $ filter (>0) $ solve1 $ parse <$> input
    print $ solve2 $ parse <$> input