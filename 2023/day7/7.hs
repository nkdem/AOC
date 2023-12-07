{-# OPTIONS_GHC -Wno-simplifiable-class-constraints #-}
import Data.Char (isDigit)
import Data.List (sort, group, sortBy, nub, groupBy)
import Data.Data
import Data.Function (on)
import Debug.Trace
import System.Directory (doesFileExist, removeFile)
import Control.Monad (when)

data HandType a = HighCard {value :: a}
                | OnePair {value :: a}
                | TwoPair {value :: a}
                | ThreeKind {value :: a}
                | FullHouse {value :: a}
                | FourKind {value :: a}
                | FiveKind {value :: a}
    deriving (Eq,Ord,Show, Typeable, Data)

upgrade :: HandType [Int] -> Int -> HandType [Int]
upgrade x i
    | i > 0 = case x of
        HighCard a-> OnePair a
        OnePair a-> ThreeKind a
        TwoPair a -> case i of
            1 -> FullHouse a
            2 -> FourKind a
            _ -> error "Invalid number of jokers" -- Only possible Cases are XXJJY and XXYYJ (so i = 1 or i = 2)
        ThreeKind a -> case i of
            1 -> FourKind a
            3 -> FourKind a
            _ -> error "Invalid number of jokers" -- Only possible Cases are XXXJY and XJJJY (so i = 1 or i = 3)
        FullHouse a -> FiveKind a
        FourKind a -> FiveKind a
        FiveKind a -> FiveKind a
    | i == 0 = x
    | otherwise = error ("Invalid number of jokers - you tried upgrading " ++ show i ++ " times for " ++ show x)


charToInt :: Char -> Bool -> Int
charToInt 'A' _ = 1000
charToInt 'K' _ = 500
charToInt 'Q' _ = 400
charToInt 'J' partB
    | partB = 0
    | otherwise = 200
charToInt 'T' _ = 10
charToInt x _ = read [x] :: Int

type Bid = Int
type Pair a = (HandType a, Bid)

getHandType partB xs
    | getNumberOf 5 == 1 = FiveKind $ map (`charToInt` partB) xs
    | getNumberOf 4 == 1 && getNumberOf 1 == 1 = FourKind $ map (`charToInt` partB) xs
    | getNumberOf 2 == 1 && getNumberOf 3 == 1 = FullHouse $ map (`charToInt` partB) xs
    | getNumberOf 3 == 1 && getNumberOf 1 == 2 = ThreeKind $ map (`charToInt` partB) xs
    | getNumberOf 2 == 1 = OnePair $ map (`charToInt` partB) xs
    | getNumberOf 2 == 2 = TwoPair $ map (`charToInt` partB) xs
    | length (nub sortedInt) == 1 = HighCard $ map (`charToInt` partB) xs
    where sorted = sortBy (\(_, val1 ) (_, val2) -> compare val2 val1) $ map (\x -> (x, length x)) $ group $ sort xs
          sortedInt = map snd sorted
          getNumberOf x = length $ filter (== x) sortedInt

getHandTypeWithJokers xs
       | jokers == 0 = handTypeWithoutJokers
       | otherwise = upgrade handTypeWithoutJokers jokers
    where jokers = length $ filter (== 'J') xs
          handTypeWithoutJokers = getHandType True xs
parse _ [[]] = []
parse _ [] = []
parse f (x:xs) = (f $ head x, read (head $ tail x) :: Int) : parse f xs


toFile :: String -> [Pair [Int]] -> IO ()
toFile _ [] = return ()
toFile name ((x,y):xs) = do
    appendFile name (show x ++ " " ++ show y ++ "\n")
    toFile name xs

main :: IO ()
main = do
    contents <- readFile "inputs/input"
    let solve1 = sum $ zipWith (\x y -> snd y * x) [1..] $ concat . groupBy (\x y -> toConstr (fst x) == toConstr (fst y) ) . sort $ parse (getHandType False) (map words $ lines contents)
    let solve2 = sum $ zipWith (\x y -> snd y * x) [1..] $ concat . groupBy (\x y -> toConstr (fst x) == toConstr (fst y) ) . sort . parse getHandTypeWithJokers $ map words $ lines contents
    print solve1 >> print solve2