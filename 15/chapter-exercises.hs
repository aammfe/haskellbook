import Data.Semigroup
import Test.QuickCheck

type Associativity x = x -> x -> x -> Bool

semigroupAssoc :: (Eq m, Semigroup m) => Associativity m
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

-- 1.
data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  _ <> _ = Trivial

instance Arbitrary Trivial where
  arbitrary = return Trivial

type TrivialAssoc = Trivial -> Trivial -> Trivial -> Bool

-- 2.
newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
  Identity x <> Identity y = Identity $ x <> y

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

type IdentityAssoc x = Associativity (Identity x)

-- 3.
data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  Two x y <> Two p q = Two (x <> p) (y <> q)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

type TwoAssoc a b = Associativity (Two a b)


-- 4.
data Three a b c = Three a b c deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
  Three x y z <> Three p q r = Three (x <> p) (y <> q) (z <> r)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

type ThreeAssoc a b c = Associativity (Three a b c)

main :: IO ()
main = do
  putStrLn "\n1. Trivial"
  quickCheck (semigroupAssoc :: TrivialAssoc)
  putStrLn "\n2. Identity"
  quickCheck (semigroupAssoc :: IdentityAssoc String)
  putStrLn "\n3. Two"
  quickCheck (semigroupAssoc :: TwoAssoc String String)
  putStrLn "\n4. Three"
  quickCheck (semigroupAssoc :: ThreeAssoc String String String)