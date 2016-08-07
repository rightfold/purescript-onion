module Main
( main
) where

import Control.Monad.Eff (Eff)
import Data.Lens ((+~), (^.), _1, _2, LensP)
import Data.Tuple (Tuple(Tuple))
import Onion (run)
import Onion.HTML (button, div, HTML, onclick, text)
import Prelude hiding (div)

type CounterState = Int
counter :: forall eff s. LensP s Int -> s -> (s -> Eff eff Unit) -> HTML eff
counter l s u = button [onclick (u (s # l +~ 1))]
                       [text (show (s ^. l))]

type AppState = Tuple CounterState CounterState
app :: forall eff s. LensP s AppState -> s -> (s -> Eff eff Unit) -> HTML eff
app l s u = div [] [ counter (l <<< _1) s u
                   , counter (l <<< _2) s u
                   ]

main :: forall eff. Eff eff Unit
main = run (Tuple 0 0) (app id)
