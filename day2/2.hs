{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Main where
import Data.Functor
import Data.List ((\\))

data Move  = Rock
            | Paper
            | Scissors
    deriving (Show,Eq,Enum)

data Status = Win
            | Lose
            | Draw
    deriving (Show,Eq)

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

decodeMove :: Move -> Status
decodeMove Rock = Lose
decodeMove Paper = Draw
decodeMove Scissors = Win

determineMove :: Move -> Status -> Move
determineMove opponentMove Draw = opponentMove
determineMove opponentMove Win = winsAgainst opponentMove
determineMove opponentMove Lose = head $ [Rock ..] \\ [opponentMove, winsAgainst opponentMove]

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
solve1 (x:xs) = sum $ scoreStatus status + scoreMove myMove : [solve1 xs]
    where status = decideStatus x
          myMove :: Move
          myMove = x !! 1

solve2 :: [[Move]] -> Int
solve2 = solve1 . map (\x -> [head x, determineMove (head x) (decoded $ myMove x) ])
    where myMove x = x !! 1
          decoded myMove = decodeMove myMove

main :: IO ()
main = do
    readInput >>= print . solve1
    readInput >>= print . solve2