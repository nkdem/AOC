import Data.Functor ( (<&>) )
import Data.Char (isDigit, digitToInt)
import Data.Bifunctor (Bifunctor(bimap))

-- readInput :: IO 
readInput = readFile "./inputs/1" <&> lines

solve1 :: [String] -> Integer
-- bimap head head <=>  (\ (x, y) -> (head x, head y))
solve1 = sum . map ((\x -> read (fst x : [snd x]) :: Integer) . (\x -> bimap head last (x,x))) . uncurry ( zipWith (++)) . bimap head head . splitAt 1 . replicate 2 . map (filter isDigit)


main :: IO ()
main = do
        readInput >>= print . solve1
        -- equivaelnt to 
        -- input <- readInput
        -- (print . solve1) input 