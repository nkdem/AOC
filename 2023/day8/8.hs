import Data.Map as M
import Data.Maybe (fromJust)
import Debug.Trace (trace)

type Start = String
type LeftDestination = String
type RightDestination = String
type Hashmap = Map Start (LeftDestination, RightDestination)

type Instructions = String
type Counter = Int

removeChars :: [Char] -> String -> String
removeChars _ "" = ""
removeChars xs (y:ys)
    | y `elem` xs = removeChars xs ys
    | otherwise = y : removeChars xs ys


constructMap :: [String] -> Hashmap -> Hashmap
constructMap [] map = map
constructMap (x:xs) map = constructMap xs (M.insert start (left,right) map)
    where (start:left:right:_) = words $ removeChars ",(=)" x


solve :: Instructions -> String -> Hashmap -> Counter -> Counter
solve "" _ _ i = i
solve xs key map i
    | value !! 2 == 'Z' = i + 1
    | otherwise = solve xs value map (i+1)
    where instruction = case xs !! (i `mod` length xs) of
            'L' -> fst
            'R' -> snd
            _ -> error "Wrong index dummy"
          value = instruction (fromJust $ M.lookup key map)

main :: IO ()
main = do
    contents <- readFile "inputs/input"
    let (instructions:_:mapUnclean) =  lines contents
    let hashmap = constructMap mapUnclean M.empty
    let startingNodes = M.keys $ M.filterWithKey (\k _ -> k !! 2 == 'A' ) hashmap
    print $ solve instructions "AAA" hashmap 0 -- Part a
    print $ Prelude.foldl lcm 1 $ Prelude.map (\x -> solve instructions x hashmap 0) startingNodes -- Part b