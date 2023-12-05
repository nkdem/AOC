import Data.Char (isDigit)
import Data.List (elemIndex)
import Data.Maybe (isJust, fromJust)
import Debug.Trace (trace)
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

getDestinationReversed val almanac = if (val >= destination almanac ) && (val <= destination almanac + rangeLength almanac - 1) then Just (source almanac + (val - destination almanac)) else Nothing

getNext :: Int -> [Almanac] -> Int
getNext val xs = case candidates of
    [] -> val
    (x:_) -> fromJust $ getDestination val x
    where candidates = filter (isJust . getDestination val) xs

getLast :: Int -> [Almanac] -> Int
getLast val xs = case candidates of
    [] -> val
    (x:_) -> fromJust $ getDestinationReversed val x
    where candidates = filter (isJust . getDestinationReversed val) xs

type Index = Int
getLocation :: Int -> Index -> [[Almanac]] -> Int
getLocation _ _ [] = 0
getLocation val i xs
    | i < length xs = getLocation next (i + 1) xs
    | otherwise = val
    where next = getNext val $ xs !! i

getSeed :: Int -> Index -> [[Almanac]] -> Int
getSeed _ _ [] = 0
getSeed val i xs
    | i < length xs = getSeed next (i + 1) xs
    | otherwise = val
    where next = getLast val $ xs !! i


readInput input = lines <$> readFile input

parseAlmanac :: [Almanac] -> [String] -> [[Almanac]]
parseAlmanac acc [] = [acc]
parseAlmanac acc (x:xs)
    | isDigit $ head x = parseAlmanac (acc ++ [Almanac (head list) (list !! 1) (list !! 2)]) xs
    | not $ null acc = acc : parseAlmanac [] xs
    |  otherwise = parseAlmanac [] xs
    where
          list = map (\x -> read x :: Int) $ words x

type SeedsRange = [(Int, Int)]

seedsPart2 :: [Int] -> SeedsRange
seedsPart2 [] = []
-- seedsPart2 (x:y:xs) = [x + i | i <- [0..y-1]] : seedsPart2 xs
seedsPart2 (x:y:xs) = (x, x + y - 1) : seedsPart2 xs

solve2 :: Int -> SeedsRange -> [[Almanac]] -> Int
solve2 _ _ [] = -1
solve2 location seeds almanacs
    | any (\x -> fst x <= seed && seed <= snd x ) seeds = do 
        trace ("Found at location: " ++ show location ++ " ") location
    | otherwise = do
        trace ("Not found at location: " ++ show location) solve2 (location + 1) seeds almanacs
    where seed = getSeed location 0 almanacs


main :: IO ()
main = do
    inputUnclean <- readInput "inputs/input"
    let (seedsUnclean:almanacUnclean) = filter (not . null) inputUnclean
    let seeds = map (\x -> read x :: Int) $ words $ drop 7 seedsUnclean
    let almanacs = parseAlmanac [] almanacUnclean
    let solve1 = minimum $ map (\x -> getLocation x 0 almanacs) seeds
    let seeds2 = seedsPart2 seeds
    print solve1
    print $ solve2 0 seeds2 $ reverse almanacs
    -- print $ minimum $ map (minimum . map (\x -> getLocation x 0 almanacs)) seeds2
    -- print $ reverse almanacs