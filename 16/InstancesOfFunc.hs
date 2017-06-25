{-# LANGUAGE ViewPatterns #-}

import Test.QuickCheck
import Test.QuickCheck.Function

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose' :: (Eq (f c), Functor f) => f a -> Fun a b -> Fun b c -> Bool
functorCompose' x (Fun _ f) (Fun _ g) = (fmap (g . f) x) == (fmap g . fmap f $ x)

type IntToInt = Fun Int Int
type IntFC = [Int] -> IntToInt -> IntToInt -> Bool

-----------------------------
-- 1.
-----------------------------
newtype Identity a = Identity a deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

type IdentityIdentity = Identity Int -> Bool
type IdentityCompose = IntFC

-----------------------------
-- 2.
-----------------------------
data Pair a = Pair a a deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair x y) = Pair (f x) (f y)

instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    return (Pair a a)

type PairIdentity a = Pair a -> Bool
type PairCompose = IntFC

-----------------------------
-- 3.
-----------------------------


-----------------------------
-- 4.
-----------------------------
data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three x y z) = Three x y (f z)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

type ThreeIdentity a b c = Three a b c -> Bool
type ThreeCompose = IntFC

main :: IO ()
main = do
  putStrLn "\n1."
  quickCheck (functorIdentity :: IdentityIdentity)
  quickCheck (functorCompose' :: IdentityCompose)

  putStrLn "\n2."
  quickCheck (functorIdentity :: PairIdentity Int)
  quickCheck (functorCompose' :: PairCompose)

  putStrLn "\n4."
  quickCheck (functorIdentity :: ThreeIdentity Int Int Int)
  quickCheck (functorCompose' :: ThreeCompose)



