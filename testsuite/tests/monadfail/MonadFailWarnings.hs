module MonadFailWarnings where

import Data.Functor.Identity
import Control.Monad.ST

-- should warn, because the do-block gets a general Monad constraint,
-- but should have MonadFail
general :: Monad m => m a
general = do
    Just x <- undefined
    undefined

-- should warn, because Identity isn't MonadFail
identity :: Identity a
identity = do
    Just x <- undefined
    undefined

-- should NOT warn, because IO is MonadFail
io :: IO a
io = do
    Just x <- undefined
    undefined

-- should warn, because (ST s) is not MonadFail
st :: ST s a
st = do
    Just x <- undefined
    undefined

-- should NOT warn, because matching against newtype
newtype Newtype a = Newtype a
newtypeMatch :: Identity a
newtypeMatch = do
    Newtype x <- undefined
    undefined

-- should NOT warn, because Data has only one constructor
data Data a = Data a
singleConMatch :: Identity a
singleConMatch = do
    Data x <- undefined
    undefined

-- should NOT warn, because patterns always match
test6, test7, test8, test9 :: Monad m => m a
test6 = do x <- undefined
           undefined
test7 = do ~(x:y) <- undefined
           undefined
test8 = do _ <- undefined
           undefined
test9 = do (a,b) <- undefined
           undefined
