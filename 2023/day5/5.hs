import Data.Char (isDigit)
import Data.List (elemIndex)
import Data.Maybe (isJust, fromJust)
type Destination = Int
type Source = Int
type RangeLength = Int

type InitialSeeds = [Int]

data Almanac = Almanac {
    destination :: Destination,
    source :: Source,
    rangeLength :: RangeLength
} deriving (Show)

getDestination :: Int -> Almanac -> Maybe Int
getDestination val almanac = if (val >= source almanac ) && (val <= source almanac + rangeLength almanac - 1) then Just (destination almanac + (val - source almanac)) else Nothing
getNext :: Int -> [Almanac] -> Int
getNext val xs = case candidates of
    [] -> val
    (x:_) -> fromJust $ getDestination val x
    where candidates = filter (isJust . getDestination val) xs

type Index = Int
getLocation :: Int -> Index -> [[Almanac]] -> Int
getLocation _ _ [] = 0
getLocation val i xs
    | i < length xs = getLocation next (i + 1) xs
    | otherwise = val
    where next = getNext val $ xs !! i


readInput input = lines <$> readFile input

parseAlmanac :: [Almanac] -> [String] -> [[Almanac]]
parseAlmanac acc [] = [acc]
parseAlmanac acc (x:xs)
    | isDigit $ head x = parseAlmanac (acc ++ [Almanac (head list) (list !! 1) (list !! 2)]) xs
    | not $ null acc = acc : parseAlmanac [] xs
    |  otherwise = parseAlmanac [] xs
    where
          list = map (\x -> read x :: Int) $ words x

main :: IO ()
main = do
    inputUnclean <- readInput "inputs/input"
    let (seedsUnclean:almanacUnclean) = filter (not . null) inputUnclean
    let seeds = map (\x -> read x :: Int) $ words $ drop 7 seedsUnclean
    let almanacs = parseAlmanac [] almanacUnclean
    let solve1 = minimum $ map (\x -> getLocation x 0 almanacs) seeds
    print solve1