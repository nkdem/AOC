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

-- sovle1 :: [(Winning, Losing)] -> Winning
sovle1 = sum . map (\x -> 2 ^ (x-1)) . filter (>0) . map (length . (\(winning,hand) -> filter (`elem` hand) winning))

main :: IO ()
main = do
    input <- readInput "inputs/input"
    print $ sovle1 $ parse <$> input