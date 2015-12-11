module Main where

import Prelude
import Math

even :: Int -> Boolean
even i =
   if i == 0     then true
   else
     if i < 2 then false
     else even (i - 2)


import Data.Array (null,filter,length)
import Data.Array.Unsafe (head, tail)

evens :: Array Int -> Int
evens is =
  if null is then 0
  else if even $ head is then (evens $ tail is) + 1
  else evens $ tail is

squares :: Array Int -> Array Int
squares is =
  (\n -> n*n) <$> is

nonegs :: Array Int -> Array Int
nonegs is =
  filter (\n -> 0 <= n) is

(<$?>) :: forall a. (a -> Boolean) -> Array a -> Array a
(<$?>) = filter

import Data.Array ((..))
import Control.MonadPlus (guard)
fctors :: Int -> Array (Array Int)
fctors n = do
  i <- 2 .. n
  j <- i .. n
  guard $ i * j == n
  return [i, j]

isPrime :: Int -> Boolean
isPrime n =
  (length $ fctors n) == 0

cartesianprod :: Array Int -> Array Int -> Array (Array Int)
cartesianprod is js = do
  i <- is
  j <- js
  return [i, j]

triples :: Int -> Array (Array Int)
triples n = do
  i <- 1 .. n
  j <- i .. n
  k <- j .. n
  guard $ i * i + j * j == k * k
  return [i, j, k]

fector :: Int -> Int -> Int
fector m n =
  if n <= m then 1
  else
    if (mod n m) == 0 then m
    else fector (m + 1) n

fecs :: Int -> Array Int
fecs n =
  fectors n 2 []

fectors :: Int -> Int -> Array Int -> Array Int
fectors n m a =
  if (f == 1) then a
  else fectors n (f + 1) (a ++ [f] ++ (fecs ( div n f)))
  where
    f = fector m n
