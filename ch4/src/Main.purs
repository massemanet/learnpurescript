module Main where

import Prelude
import Data.Array (null,filter,length)
import Data.Array ((..))
import Data.Array.Unsafe (head, tail)
import Control.MonadPlus (guard)

-- 4.4:1

even :: Int -> Boolean
even i =
   if i == 0     then true
   else
     if i < 2 then false
     else even (i - 2)

-- 4.4:1

evens :: Array Int -> Int
evens is =
  if null is then 0
  else if even $ head is then (evens $ tail is) + 1
  else evens $ tail is

-- 4.7:1

squares :: Array Int -> Array Int
squares is =
  (\n -> n*n) <$> is

-- 4.7:2

nonegs :: Array Int -> Array Int
nonegs is =
  filter (\n -> 0 <= n) is

-- 4.7:3

(<$?>) :: forall a. (a -> Boolean) -> Array a -> Array a
(<$?>) = filter

-- 4.11:1

isPrime :: Int -> Boolean
isPrime n =
  (length $ fctors n) == 0

fctors :: Int -> Array (Array Int)
fctors n = do
  i <- 2 .. n
  j <- i .. n
  guard $ i * j == n
  return [i, j]

-- 4.11:2

cartesianprod :: Array Int -> Array Int -> Array (Array Int)
cartesianprod is js = do
  i <- is
  j <- js
  return [i, j]

-- 4.11:3

triples :: Int -> Array (Array Int)
triples n = do
  i <- 1 .. n
  j <- i .. n
  k <- j .. n
  guard $ i * i + j * j == k * k
  return [i, j, k]

-- 4.11:4

factorize :: Int -> Array (Array Int)
factorize i =
  recurs i i [] (facs i)

recurs :: Int -> Int -> Array Int -> Array Int -> Array (Array Int)
recurs m n stem factors =
  if (null factors) then
    if (prod stem 1) == m then [stem]
    else []
  else
    dorecurs (head factors) (tail factors) m n stem

dorecurs :: Int -> Array Int -> Int -> Int -> Array Int -> Array (Array Int)
dorecurs f fs m n stem =
  (recurs m (div n f) ([f] ++ stem) (facs (div n f))) ++ (recurs m n stem fs)

facs :: Int -> Array Int
facs n =
  if (n < 2) then []
  else
    if (n < 4) then [n]
    else [n] ++
         do f <- 2 .. (div n 2)
            guard $ (mod n f) == 0
            return f

prod :: (Array Int) -> Int -> Int
prod is p =
  if (null is) then p
  else prod (tail is) ((head is) * p)
