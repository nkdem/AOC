import Data.Functor ((<&>))
import Data.Char hiding (isSymbol)
import Data.List (sort, group, isInfixOf, subsequences)

type Grid = (Int, Int)

neighbours :: Grid -> Grid -> [(Int,Int)]
neighbours pos size = [(x', y') |
                         x' <- [x, x + 1, x - 1],
                         x' /= -1,
                         y' <- [y, y - 1, y + 1],
                         y' /= -1,
                         x' /= rows,
                         y' /= cols,
                         (x', y') /= (x, y)]
    where x = fst pos
          y = snd pos
          rows = fst size
          cols = snd size

readInput input = readFile input <&> lines

transformDigits :: String -> String -> [Int]
transformDigits [] acc = concat (replicate (length acc ) [read acc :: Int])
transformDigits (x:xs) acc
        | isDigit x = transformDigits xs (acc ++ [x])
        | isDigit x && not (null acc) = concat (replicate (length acc ) [read acc :: Int]) ++ transformDigits xs []
        | x == '.' = concat (replicate (length acc ) [read acc :: Int]) ++ -1 : transformDigits xs []
        | x == '*' = concat (replicate (length acc ) [read acc :: Int]) ++ -2 : transformDigits xs []
        | otherwise = concat (replicate (length acc ) [read acc :: Int]) ++ -3 : transformDigits xs []

isSymbol (-2) = True
isSymbol (-3) = True
isSymbol _ = False

solve1 :: [[Int]] -> Grid -> [Int]
solve1 xs grid = concat [ map head . group  $ [val | (val,y) <- zip row [0..], val /= (-1), any (\(a,b) -> isSymbol $ get a b) (neighbours (x,y) grid)] | (row,x)  <- zip xs [0..] ]
  where rows = fst grid
        cols = snd grid
        get x y = (xs !! x) !! y

elementsExist list1 list2 = all (`elem` list2) list1

solve2 xs grid@(rows,cols) = sum . map (product) . concat . map (map (map head .group . sort) ) $ group $ sort $ filter (\x -> length x >= 2) $ map (\x -> filter (>= 0) $ map (uncurry get ) $ neighbours x grid) filterGears
  where get x y = (xs !! x) !! y
        getCordsOf target = filter (\(x,y) -> get x y == target ) [(x,y) | x <- [0..rows - 1], y <- [0..cols -1]]
        filterGears = filter (\(x,y) -> get x y == -2 ) [(x,y) | x <- [0..rows - 1], y <- [0..cols -1]]


main :: IO ()
main = do
        input <- readInput "./inputs/input"
        let gridSize = (length input,length $ head input)
        print $ sum $ solve1 (map (`transformDigits` []) input) gridSize
        print $ solve2 (map (`transformDigits` []) input) gridSize