module Main
( main
) where

import Data.Array as Array
import Data.Map as Map
import Control.Monad.Eff (Eff)
import Data.Lens ((%~), (^.), iso, IsoP, lens, LensP)
import Data.Lens.At (at)
import Data.Map (Map)
import Data.Maybe (fromMaybe, Maybe(Just, Nothing))
import Onion (Component, run)
import Onion.HTML (checkboxInput, checked, div, em, onchange, text, textInput)
import Prelude hiding (div)

data Item = Item Boolean String
derive instance eqItem :: Eq Item

_done :: LensP Item Boolean
_done = lens (\(Item d _) -> d) (\(Item _ t) d -> Item d t)

type ItemState = Item
item :: forall eff s. LensP s ItemState -> Component eff s
item l s u = case s ^. l of Item done description -> div [] [checkbox done, descriptionH done description]
  where checkbox done = checkboxInput ([onchange (u (l <<< _done %~ not))] <> if done then [checked] else [])
        descriptionH done description = (if done then \x -> em [] [x] else id) (text description)

type AppState = Map Int Item
app :: forall eff s. LensP s AppState -> Component eff s
app l s u = div [] [form, list]
  where form = textInput []
        list = div [] $ Map.keys (s ^. l)
                        # map (\k -> item (l <<< at k <<< non (Item false "")) s u)
                        # Array.fromFoldable

main :: forall eff. Eff eff Unit
main = run state (app id)
  where state = Map.empty
                # Map.insert 0 (Item false "Groceries")
                # Map.insert 1 (Item false "Clean")
                # Map.insert 2 (Item false "Unit test")


non :: forall a. (Eq a) => a -> IsoP (Maybe a) a
non a = anon a (a == _)

anon :: forall a. a -> (a -> Boolean) -> IsoP (Maybe a) a
anon a p = iso (fromMaybe a) go where
  go b | p b       = Nothing
       | otherwise = Just b
