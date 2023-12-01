import Data.Functor ( (<&>) )
import Data.Char (isDigit, digitToInt, isAlpha)
import Data.Bifunctor (Bifunctor(bimap))
import Data.List
import Data.Maybe (isNothing, isJust, fromJust, mapMaybe, catMaybes)

-- readInput :: IO 
readInput input = readFile input <&> lines

solve :: [[Int]] -> Int
solve = sum . map (\x -> read (show (head x) ++ show (last x )) :: Int )

convert "" = 0
convert s
        | isDigit (head s) = digitToInt (head s)
        | otherwise = letterToDigit s

parse1 = map (map digitToInt . filter isDigit)
parse2 xs = [[convert (drop i x) | (y, i) <- zip x [0..], isDigit y || letterToDigit (drop i x) /= 0] | x <- xs]

letterToDigit :: String -> Int
letterToDigit s
        | null result = 0
        | otherwise = head result
        where ys = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
              pairs = zip ys [1..]
              result = mapMaybe ((`lookup` pairs) . snd) . filter (\(x,y) -> y `isPrefixOf` x) $ map (s,) ys

-- data Which = Beginning | Ending
--         deriving (Eq)
-- solve2 a = let rev = map reverse mirror
--         in
--                 map (`getDigit` Beginning) a
--         where mirror = map (\x -> x ++ x) a
-- getDigit :: String -> Which -> Integer
-- getDigit s w
--         | null letters && isJust digit = read [fromJust digit] :: Integer
--         | not . null $ possibleDigits letters w = (head $ possibleDigits letters w)
--         -- | isJust digit = read [fromJust digit] :: Integer
--         where   (letters, rest) = span (isAlpha) s
--                 digit = case () of _
--                                         | null rest -> Nothing
--                                         | otherwise -> Just $ head rest
-- possibleDigits xs w = mapMaybe ((`lookup` pairs) . snd) . filter (\(x,y) -> y `isPrefixOf` x) $ map (xs,) ys
--         where   ys
--                         | w == Beginning = t
--                         | otherwise = map reverse t
--                         where t = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
--                 pairs = zip ys [1..]

main :: IO ()
main = do
        -- input <- readInput "./inputs/1"
        -- (print . solve1) (map (map digitToInt . filter isDigit) input)
        readInput "./inputs/1" >>= print . solve . parse1
        readInput "./inputs/1" >>= print . solve . parse2