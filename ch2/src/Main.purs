module Main where

import Prelude
import Math (sqrt)
import Math (pi)
import Control.Monad.Eff.Console

diagonal w h = sqrt (w*w + h*h)

circle_area r = pi*r*r

main = print (diagonal 3.0 4.0)
