module Onion
( run
) where

import Control.Monad.Eff (Eff)
import Onion.HTML (HTML)
import Prelude

run :: forall eff state
     . state
    -> (state -> (state -> Eff eff Unit) -> HTML eff)
    -> Eff eff Unit
run = _run

foreign import _run :: forall eff state. state -> (state -> (state -> Eff eff Unit) -> HTML eff) -> Eff eff Unit
