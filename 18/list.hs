-- ∨ -------------------------------- ∨ ---------------------------------- ∨ --
-- (>>=) :: Monad m => m a -> (a -> m b) -> m b
-- (>>=) ::            [a] -> (a -> [b]) -> [b]
-- ∧ -------------------------------- ∧ ---------------------------------- ∧ --

twiceWhenEven :: [Integer] -> [Integer]
twiceWhenEven xs = do
  x <- xs
  if even x
    then [x * x, x * x]
    else []
