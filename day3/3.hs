{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Main where
import Data.Char (ord, isLower)
import Data.Functor ( (<&>) )
import Data.Set as S hiding (drop, take, map)

priority :: Char -> Int
priority x
    | isLower x = ord x - 96
    | otherwise = ord x - 38

readInput :: IO [[Int]]
readInput = readFile "./inputs/3" <&> lines <&> map (map priority)

solve1 :: [[Int]] -> Int
solve1 = sum . concatMap (\x -> S.toList (S.fromList (take (mid x) x) `S.intersection` S.fromList (drop (mid x) x)))
    where mid :: [Int] -> Int
          mid x = length x `div` 2

solve2 :: [[Int]] -> Int
solve2 [] = 0
solve2 (x:y:z:xs) = sum (S.toList  (S.fromList x `S.intersection` S.fromList y `S.intersection` S.fromList z)) + solve2 xs

main :: IO ()
main = do
    readInput >>= print . solve1
    readInput >>= print . solve2