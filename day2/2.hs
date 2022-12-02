{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Main where
import Data.Functor

data Move  = Rock
            | Paper
            | Scissors
    deriving (Show,Eq)

data Status = Win
            | Lose
            | Draw

scoreMove :: Move -> Int
scoreMove Rock = 1
scoreMove Paper = 2
scoreMove Scissors = 3

scoreStatus :: Status -> Int
scoreStatus Win = 6
scoreStatus Draw = 3
scoreStatus Lose = 0

winsAgainst :: Move -> Move
winsAgainst Rock = Paper
winsAgainst Paper = Scissors
winsAgainst Scissors = Rock

parseMove :: Char -> Move
parseMove 'A' = Rock
parseMove 'X' = Rock
parseMove 'B' = Paper
parseMove 'Y' = Paper
parseMove 'C' = Scissors
parseMove 'Z' = Scissors

parseMoves :: String -> [Move]
parseMoves (x:_:y:_) = map parseMove [x,y]

decideStatus :: [Move] -> Status
decideStatus (x : y : _)
  | x == y = Draw
  | winsAgainst x == y = Win
  | otherwise = Lose


readInput :: IO [[Move]]
readInput = readFile "./inputs/2" <&> lines <&> map parseMoves

solve1 :: [[Move]] -> Int
solve1 [] = 0
solve1 (x:xs) = sum $ scoreStatus status + scoreMove (x !! 1) : [solve1 xs]
    where status = decideStatus x

main :: IO ()
main = readInput >>= print . solve1