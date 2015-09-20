{-# LANGUAGE RebindableSyntax #-}

module MonadFailWarningsWithRebindableSyntax where

import Prelude

test1 f g = do
    Just x <- f
    g
