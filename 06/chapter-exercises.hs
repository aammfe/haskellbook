-- 1.
-- The Eq class
-- c) makes equality tests possible

-- 2.
-- The typeclass Ord
-- b) is a subclass of Eq

-- 3.
-- What is the type of >?
-- a) Ord a => a -> a -> Bool

-- 4.
-- In x = divMod 16 12
-- d) the type of x is a tuple

-- 5.
-- The typeclass Integral includes
-- a) Int and Integer numbers

-- Does it typecheck?
-- 1.
-- No, needed to derive Show.
data Person = 
  Person Bool
  deriving (Show)

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)

-- 2.
-- No, needed to derive Eq.
data Mood =
    Blah
  | Woot
  deriving (Eq, Show)

settleDown x = if x == Woot
                  then Blah
                  else x
