import Data.Functor ( (<&>) )

-- readInput :: IO 
readInput = readFile "./inputs/1" <&> lines

solve1 :: [String] -> String
solve1 = undefined


main :: IO ()
main = do 
        readInput >>= print . solve1
        -- equivaelnt to 
        -- input <- readInput
        -- (print . solve1) input 