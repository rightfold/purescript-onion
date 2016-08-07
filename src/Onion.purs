module Onion
( HTML
, h
, t

, run
) where

import Control.Monad.Eff (Eff)
import Prelude

foreign import data HTML :: # ! -> *

h :: forall eff p. String -> Record p -> Array (HTML eff) -> HTML eff
h = _h

t :: forall eff. String -> HTML eff
t = _t

run :: forall eff state
     . state
    -> (state -> (state -> Eff eff Unit) -> HTML eff)
    -> Eff eff Unit
run = _run

foreign import _h :: forall eff p. String -> Record p -> Array (HTML eff) -> HTML eff
foreign import _t :: forall eff. String -> HTML eff
foreign import _run :: forall eff state
                     . state
                    -> (state -> (state -> Eff eff Unit) -> HTML eff)
                    -> Eff eff Unit
