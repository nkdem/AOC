import Data.Functor ((<&>))
import Data.Map (Map)
import Data.List (isPrefixOf, isSuffixOf)
import Data.Char
readInput input = readFile input <&> lines

data Colour = Blue | Red | Green
        deriving (Show, Eq)
data Cube a = Cube Colour a | Error
         deriving (Show)
data Game a = Game a (Cube a) (Cube a) (Cube a)
        deriving (Show)



splitUntilSpace "" t@(digits,rest) = t
splitUntilSpace (x:xs) t@(digits, i)
        | x == ' ' = (digits, i)
        | otherwise = splitUntilSpace xs (digits ++ [x], i + 1)
splitUntilSemiColon "" t@(digits,rest) = t
splitUntilSemiColon (x:xs) t@(digits, i)
        | x == ';' = (digits, i)
        | otherwise = splitUntilSemiColon xs (digits ++ [x], i + 1)
parse xs = map (map h . (\x -> g . f $ drop (6 + snd (splitUntilSpace (drop 5 x) ("", 0))) x)) xs
        where   f "" = ""
                f (x:xs)
                        | x == ',' = ' ' : f (tail xs)
                        | otherwise = x : f xs

                -- convert 3 blue 4 red; 1 red 2 green 6 blue; 2 green
                -- to
                -- [[3 blue, 4 red], [1 red, 2 green, 6 blue], [2 green]]
                g "" = []
                g xss = [x] ++ g xs
                        where
                                (x, i) = splitUntilSemiColon xss ("", 0)
                                xs = drop (i + 2) xss
                h "" = []
                h xss
                        | " blue" `isPrefixOf` xs = Cube Blue (read d :: Int) : h (drop 6 xs)
                        | " red" `isPrefixOf` xs = Cube Red (read d :: Int) : h (drop 5 xs)
                        | " green" `isPrefixOf` xs = Cube Green (read d :: Int) : h (drop 7 xs)
                        where
                                (d,i) = splitUntilSpace xss ("", 0)
                                xs = drop i xss

-- sumCubes :: [Cube Int] -> Cube Int
sumCubes _ [] = 0
sumCubes c1 ((Cube c2 x):xs)
        | c1 /= c2 = error "Not the same colour"
        | otherwise = x + sumCubes c1 xs



thrd :: (a, b, c) -> c
thrd (_, _, x) = x
-- cubesToGames :: [(Int, Int,Int)] -> Int -> [Game Int]
-- cubesToGames :: [([Int], [Int], [Int])] -> Int -> [Game Int]
cubesToGames :: [([Int], [Int], [Int])] -> Int -> [Game Int]
cubesToGames [] _ = []
cubesToGames (x:xs) i = Game i (Cube Red (fst x)) (Cube Green (snd x)) (Cube Blue (thrd x)) : cubesToGames xs (i + 1)
-- cubesToGames [] _ = []
-- cubesToGames ((r,g,b):xs) i = Game i (Cube Red r) (Cube Green g) (Cube Blue b) : cubesToGames xs (i + 1)

-- solve1 rl gl bl xs = sum . map (\(Game x _ _ _) -> x) $ filter (\(Game _ (Cube _ r) (Cube _ g) (Cube _ b)) -> r <= rl && g <= gl && b <= bl) $ cubesToGames (zip3 reds greens blues) 1
--         where f p = filter (\(Cube cube _) -> cube == p)
--               blues = map (sumCubes Blue . f Blue) xs
--               reds = map (sumCubes Red . f Red) xs
--               greens = map (sumCubes Green . f Green) xs

q :: [[Int]] -> [Int]
q [] = []
q (x:xs) = h x : q xs
        where h [] = 0
              h xs = head xs

-- solve2 :: p1 -> p2 -> p3 -> [[[Cube b]]] -> [[(Int, Int, Int)]]
solve2 :: p1 -> p2 -> p3 -> [[[Cube Int]]] -> [Game Int]
solve2 rl gl bl xs = cubesToGames (zip blues reds) 1
        where   f p = filter (\(Cube cube _) -> cube == p)
                blues = map (q . map (map (\(Cube _ y) -> y) . f Blue)) xs
                reds = map (q . map (map (\(Cube _ y) -> y) . f Red)) xs
                greens = map (q . map (map (\(Cube _ y) -> y) . f Green)) xs




main :: IO ()
main = do
        input <- readInput "./inputs/sample"
        print $ solve2 1 1 1 (parse input)
        -- print $ solve1 12 13 14 (parse input)
        -- print $ cubesToGames (zip3 blues reds greens) 1
        -- readFile "./inputs/sample" >>= print . solve1 12 13 14 . parse . lines