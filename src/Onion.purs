module Onion
( Component
, run
) where

import Control.Monad.Eff (Eff)
import Onion.HTML (HTML)
import Prelude

type Component eff s = s -> (s -> Eff eff Unit) -> HTML eff

run :: forall eff s. s -> Component eff s -> Eff eff Unit
run = _run

foreign import _run :: forall eff s. s -> Component eff s -> Eff eff Unit
