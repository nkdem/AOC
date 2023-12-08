import Data.Map as M
import Data.Maybe (fromJust)
import Debug.Trace (trace)

type Start = String
type LeftDestination = String
type RightDestination = String
type Hashmap = Map Start (LeftDestination, RightDestination)

type Instructions = String
type Counter = Int

removeChar :: Char -> String  -> String
removeChar _ "" = ""
removeChar x (y:ys)
    | x == y = removeChar x ys
    | otherwise = y : removeChar x ys

removeChars :: [Char] -> String -> String
removeChars _ "" = ""
removeChars xs (y:ys)
    | y `elem` xs = removeChars xs ys
    | otherwise = y : removeChars xs ys


constructMap :: [String] -> Hashmap -> Hashmap
constructMap [] map = map
constructMap (x:xs) map = constructMap xs (M.insert start (left,right) map)
    where (start:left:right:_) = words $ removeChars ",(=)" x


solve1 :: Instructions -> String -> Hashmap -> Counter -> Counter
solve1 "" _ _ i = i
solve1 xs key map i
    | value == "ZZZ" = i + 1
    | otherwise = solve1 xs value map (i+1)
        -- trace ("Got " ++ show value ++ " so let's try that!") solve1 xs value map (i+1)
    where instruction = case xs !! (i `mod` length xs) of
            'L' -> fst
            'R' -> snd
            _ -> error "Wrong index dummy"
          value = instruction (fromJust $ M.lookup key map)


main :: IO ()
main = do
    contents <- readFile "inputs/input"
    let (instructions:_:mapUnclean) =  lines contents
    let map = constructMap mapUnclean M.empty
    print $ map
    print $ solve1 instructions "AAA" map 0