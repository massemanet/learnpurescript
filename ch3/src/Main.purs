module Main where

import Prelude
import Data.List
import Data.Maybe
import Control.Plus (empty)

type Address =
  {street :: String
  ,city   :: String
  ,zip    :: String}

type Entry =
  {firstName :: String
  ,lastName  :: String
  ,address   :: Address}

type AddressBook = List Entry

emptyBook :: AddressBook
emptyBook = empty

insertEntry :: Entry -> AddressBook -> AddressBook
insertEntry = Cons

findEntryByName :: String -> String -> AddressBook -> Maybe Entry
findEntryByName fn ln = filter filterf >>> head
  where
  filterf e = e.firstName == fn && e.lastName == ln

findEntryByStreet :: String -> AddressBook -> Maybe Entry
findEntryByStreet sn = filter filtersf >>> head
  where
  filtersf e = e.address.street == sn

namep :: String -> AddressBook -> Boolean
namep n = filter filterf >>> Data.List.null >>> not
  where
  filterf e = e.firstName == n || e.lastName == n

removeDuplicates :: AddressBook -> AddressBook
removeDuplicates = Data.List.nubBy filterf
  where
  filterf e1 e2 = e1.firstName == e2.firstName || e1.lastName == e2.lastName

showEntry :: Entry -> String
showEntry e =
  e.lastName ++ ", " ++ e.firstName ++ ": " ++ showAddress e.address

showAddress :: Address -> String
showAddress a =
  a.street ++ ", " ++ a.zip ++ " " ++ a.city

