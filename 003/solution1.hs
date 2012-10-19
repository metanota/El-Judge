import Control.Monad (liftM, replicateM)
import Numeric (readDec)
import Data.List (intercalate)

type Vertex = Int
type Edge = (Vertex, Vertex)

data DlsResult =   Success [Vertex]
                 | Cutoff

instance Show DlsResult where
    show (Success a) = intercalate " " $ map show a
    show _ = "Failure"

inc   :: (Num a) => a -> a
inc x =  x + 1

parseInt'   :: String -> Int
parseInt' = fst . head . readDec
--parseInt' c =  read c :: Int

parseScoreTable          :: [String] -> [Edge]
parseScoreTable numLines =  analyzeLines 1 numLines

analyzeLines                 :: Int -> [String] -> [Edge]
analyzeLines _    []         =  []
analyzeLines line (chars:xs) =  analyzeChars line 1 chars ++
                                    analyzeLines (inc line) xs

analyzeChars                     :: Int -> Int -> String -> [Edge]
analyzeChars _    _    []        =  []
analyzeChars line char (sign:xs) |  sign == '#' && char == line = []
                                 |  sign == '-' = (char, line) : further
                                 |  sign == '+' = (line, char) : further
                                 where
                                     further = analyzeChars line (inc char) xs

getSndWhereFstLike   :: (Eq a) => a -> [(a, b)] -> [b]
getSndWhereFstLike y =  map snd . filter (\x -> fst x == y)

dropSndNot   :: (Eq b) => b -> [(a, b)] -> [(a, b)]
dropSndNot y =  filter (\x -> snd x /= y)

dls                           :: [Vertex] -> [Vertex] -> [Edge] -> Int -> DlsResult
dls result []     _     depth =  if length result == depth then Success result
                                     else Cutoff
dls result (x:xs) edges depth =  case (output) of
                                     Success _ -> output
                                     Cutoff    -> dls result xs edges depth
                                 where
                                     output = dls (result ++ [x])
                                                  (getSndWhereFstLike x edges)
                                                  (dropSndNot x edges)
                                                  depth

main :: IO ()
main = do
       numLines <- liftM parseInt' getLine
       input <- replicateM numLines getLine
       let edges = parseScoreTable input
       print $ dls [] [1..numLines] edges numLines
