module FileOperations where

import Prelude

import Data.Path
import Data.Array

allFiles :: Path -> Array Path
allFiles root = root : concatMap allFiles (ls root)

allFiles' :: Path -> Array Path
allFiles' file =
  file : do
    child <- ls file
    allFiles' child

-- 4.17:1

onlyFiles :: Path -> Array Path
onlyFiles path =
  do
    child <- ls path
    if (isDirectory child) then
      onlyFiles child
      else [child]

-- 4.17:2

import Data.Maybe
import Data.Foldable

sizeFiles :: Int
sizeFiles =
  foldl (sizeof) 0 (onlyFiles root)

sizeof :: Int -> Path -> Int
sizeof acc child =
  let
    szchild = (fromMaybe 0 (size child))
  in
   if (szchild < acc) then
     acc
   else
     szchild

-- 4.17:3

import Control.MonadPlus (guard)

whereIs :: String -> Maybe Path
whereIs filenam =
  (head (findfile filenam))

findfile :: String -> Array Path
findfile filename =
  do
    dir <- onlyDirs root
    guard (member filename dir)
    return dir

onlyDirs :: Path -> Array Path
onlyDirs path =
  do
    child <- ls path
    if (isDirectory child) then
      [child]
      else onlyFiles child

member :: String -> Path -> Boolean
member filenam dir =
  foldr (\file a -> a || ((filename file) == filenam)) false (ls dir)
