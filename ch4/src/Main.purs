module Main where

import Prelude
import Math

even :: Int -> Boolean
even i =
   if i == 0     then true
   else if i < 2 then false
   else even (i - 2)


