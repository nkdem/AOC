{-# OPTIONS_GHC -Wno-simplifiable-class-constraints #-}
import Data.Char (isDigit)
import Data.List (sort, group, sortBy, nub, groupBy)
import Data.Data
import Data.Function (on)

data HandType a = HighCard {value :: a}
                | OnePair {value :: a}
                | TwoPair {value :: a}
                | ThreeKind {value :: a}
                | FullHouse {value :: a}
                | FourKind {value :: a}
                | FiveKind {value :: a}
    deriving (Eq,Ord,Show, Typeable, Data)


charToInt :: Char -> Int
charToInt 'A' = 1000
charToInt 'K' = 500
charToInt 'Q' = 400
charToInt 'J' = 300
charToInt 'T' = 200
charToInt x = read [x] :: Int

type Bid = Int
type Pair a = (HandType a, Bid)


-- getHandType :: String -> HandType String
getHandType xs
    | getNumberOf 5 == 1 = FiveKind $ map charToInt xs
    | getNumberOf 4 == 1 && getNumberOf 1 == 1 = FourKind $ map charToInt xs
    | getNumberOf 2 == 1 && getNumberOf 3 == 1 = FullHouse $ map charToInt xs
    | getNumberOf 3 == 1 && getNumberOf 1 == 2 = ThreeKind $ map charToInt xs
    | getNumberOf 2 == 1 = OnePair $ map charToInt xs
    | getNumberOf 2 == 2 = TwoPair $ map charToInt xs
    | length (nub sortedInt) == 1 = HighCard $ map charToInt xs
    where sorted = sortBy (\(_, val1 ) (_, val2) -> compare val2 val1) $ map (\x -> (x, length x)) $ group $ sort xs
          sortedInt = map snd sorted
          getNumberOf x = length $ filter (== x) sortedInt

-- parse :: [[String]] -> [Pair]
parse [[]] = []
parse [] = []
parse (x:xs) = (getHandType $ head x, read (head $ tail x) :: Int) : parse xs


main :: IO ()
main = do
    contents <- readFile "inputs/input"
    let clean = zipWith (\x y -> snd y * x) [1..] $ concat . groupBy (\x y -> toConstr (fst x) == toConstr (fst y) ) . sort . parse . map words $ lines contents
    print . sum $ clean