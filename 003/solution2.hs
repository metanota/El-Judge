import Numeric (readDec)

type Vertex = Int
type Edge = (Vertex, Vertex)

data DlsResult = Success [Vertex]
               | Cutoff

instance Show DlsResult where
    show (Success a) = unwords $ map show a
    show Cutoff      = "Failure"

parseInt :: String -> Int
parseInt =  fst . head . readDec

buildGraph      :: [String] -> [Edge]
buildGraph strs = map f                                         $
                  filter (\(x,y,_) -> x /= y)                   $
                  concatMap (\(x,y) -> zip3 [1..] (repeat x) y) $
                  zip [1..] strs

f (a, b, c) | c == '+'  = (b, a)
            | otherwise = (a, b)


followers   :: Vertex -> [Edge] -> [Vertex]
followers y =  map snd . filter (\x -> fst x == y)

dropLooser   :: Vertex -> [Edge] -> [Edge]
dropLooser y =  filter (\x -> snd x /= y)

dls                              :: [Vertex] -> [Vertex] -> [Edge] -> Int -> DlsResult
dls result []     _     totDepth |  length result == totDepth = Success result
                                 |  otherwise                 = Cutoff
dls result (x:xs) edges totDepth =  case (output) of
                                        Success _ -> output
                                        Cutoff    -> dls result xs edges totDepth
                                    where
                                        output = dls (result ++ [x]) (followers x edges) (dropLooser x edges) totDepth

dlsExecuter                  :: Int -> [Edge] -> DlsResult
dlsExecuter numPlayers edges =  dls [] [1..numPlayers] edges numPlayers

executeExercise       :: String -> String
executeExercise input =  show $ dlsExecuter x $ buildGraph $ take x $ tail strs
                         where strs = lines input
                               x    = parseInt $ head strs

main :: IO ()
main =  interact executeExercise
