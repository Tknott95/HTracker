module Utils where

import Control.Monad.IO.Class (liftIO)
import Control.Concurrent (threadDelay, ThreadId)
import Control.Monad (forM_)

loopFn :: IO () -> Int -> Int -> IO ()
loopFn _fn _secInMin _minsTotal = do
  liftIO $ _fn 
  -- 20 is seconds in min - 1 is how many minutes - so 20 sec calls here
  threadDelay $ (1000 * 1000 * _secInMin * _minsTotal) 
  loopFn _fn _secInMin _minsTotal

loopFnMany :: [IO ()] -> Int -> Int -> IO ()
loopFnMany _fn _secInMin _minsTotal = do
  forM_ _fn $ \ijk -> do
    ijk
  -- 20 is seconds in min - 1 is how many minutes - so 20 sec calls here
  threadDelay $ (1000 * 1000 * _secInMin * _minsTotal) 
  loopFnMany _fn _secInMin _minsTotal

-- loopFnFork :: IO ThreadId -> Int -> Int -> IO ()
-- loopFnFork _fn _secInMin _minsTotal = do
--   liftIO $ _fn 
--   -- 20 is seconds in min - 1 is how many minutes - so 20 sec calls here
--   threadDelay $ (1000 * 1000 * _secInMin * _minsTotal) 
--   loopFnFork _fn _secInMin _minsTotal
