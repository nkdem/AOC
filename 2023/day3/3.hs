import Data.Char (isDigit)
import Data.List (nub, nubBy)

getValAt :: (Int, Int) -> [String] -> Char
getValAt (x, y) grid = (grid !! x) !! y

-- assumes that the starting position is a digit
getLeftMostPos :: (Int, Int) -> [String] -> Int
getLeftMostPos pos@(x, y) xs
        | y == -1 = 0
        | not $ isDigit val = y + 1
        | otherwise = getLeftMostPos (x, y - 1) xs
    where
        val = getValAt pos xs

getRightMostPos :: (Int, Int) -> [String] -> Int
getRightMostPos pos@(x, y) xs
        | y == length (head xs) = y
        | not $ isDigit val = y - 1
        | otherwise = getRightMostPos (x, y + 1) xs
    where
        val = getValAt pos xs

getDigitsFrom :: (Int, Int) -> [String] -> Int
getDigitsFrom _ [] = error "grid shouldn't be empty"
getDigitsFrom pos@(x, y) xs = read (str) :: Int
    where
        startIndex = getLeftMostPos pos xs
        endIndex = getRightMostPos pos xs
        offset = endIndex - startIndex + 1
        str = take offset $ drop startIndex (xs !! x)

type Size = (Int, Int)
neighbours :: (Int, Int) -> Size -> [(Int, Int)]
neighbours (x, y) (rows, cols) =
        [ (x', y')
        | x' <- [x, x + 1, x - 1]
        , x' /= -1
        , y' <- [y, y - 1, y + 1]
        , y' /= -1
        , x' /= rows
        , y' /= cols
        , (x', y') /= (x, y)
        ]

getPairs targetPair list = [(targetPair, x) | x <- list]

isDigitSame :: (Int, Int) -> (Int, Int) -> [String] -> Bool
isDigitSame p1@(x, y) p2@(x', y') xs
        | x == x' = getDigitsFrom p1 xs == getDigitsFrom p2 xs
        | otherwise = False

main :: IO ()
main = do
        contents <- readFile "inputs/input"
        let xs = lines contents
            size = (length xs, length $ head xs)
            grid = concat [[(x, y) | (val, y) <- zip row [0 ..]] | (row, x) <- zip xs [0 ..]]
            symbols = [pos | pos <- grid, getValAt pos xs /= '.', not $ isDigit $ getValAt pos xs]
            part1 = concatMap (\symbol -> map (`getDigitsFrom` xs) $ nubBy (\x y -> isDigitSame x y xs) $ filter (\candidate -> isDigit $ getValAt candidate xs) $ neighbours symbol size) symbols
            gears = [pos | pos <- grid, getValAt pos xs == '*']
            part2 = map product $ filter (\x -> length x == 2) $ map (\symbol -> map (`getDigitsFrom` xs) $ nubBy (\x y -> isDigitSame x y xs) $ filter (\candidate -> isDigit $ getValAt candidate xs) $ neighbours symbol size) gears
        print $ sum $ part1
        print $ sum $ part2