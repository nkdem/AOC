import Data.Functor ((<&>))
import Data.Char (isDigit)
import Data.Maybe
import qualified Data.Bifunctor

type Grid = (Int, Int)
type Range = (Maybe Int,Int)
row = fst
col = snd
readInput input = readFile input <&> lines

neighbours :: Int -> Int -> Grid -> [(Int,Int)]
neighbours x y size = [(x', y') |
                         x' <- [x, x + 1, x - 1],
                         x' /= 0,
                         y' <- [y, y - 1, y + 1],
                         y' /= 0,
                         x' /= row size + 1,
                         y' /= col size + 1,
                         (x', y') /= (x, y)]

filterDigits :: String -> Range -> [Range]
filterDigits "" (Nothing, _) = []
filterDigits "" r = [r]
filterDigits (x:xs) r@(beginning,end)
    | isDigit x && isNothing beginning = filterDigits xs (Just end, end + 1)
    | isDigit x && isJust beginning = filterDigits xs (beginning, end+1)
    | otherwise = (beginning, end - 1) : filterDigits xs (Nothing,end+1 )


filterSymbols :: Grid -> [String] -> [Grid]
filterSymbols size xs = concat $ filter (not . null) [[(x,y)| (c,y) <- zip s [1..], c /= '.', not $ isDigit c ] | (s,x) <- zip xs [1..]]

containsAny :: (Eq a) => [a] -> [a] -> Bool
containsAny xs ys = any (`elem` xs) ys

-- solve1 :: (Int, Int) -> [String] -> [[Range]]
-- solve1 :: (Int, Int) -> [String] -> [[(Int, Int)]]
solve1 size input = filter (\x -> not $ null $ take 1 (map (\y -> x `elem` y) digitsGrid)) matched 
    where symbols = filterSymbols size input
          digits = map (\x -> map (Data.Bifunctor.first fromJust) $ filter (\(x,y) -> isJust x) $ filterDigits x (Nothing, 1)) input
          digitsGrid = concat [[[(x,y) | y <- [beg..end]] | (beg,end) <- ds] | (x,ds)  <- zip [1..] digits]
          matched = concat [filter (\(x,y) -> containsAny (neighbours x y size) symbols) xs | xs <- digitsGrid]
main :: IO ()
main = do
        input <- readInput "./inputs/sample"
        let gridSize = (length input,length $ head input)
        print $ solve1 gridSize input