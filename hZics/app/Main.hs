module Main where

import TrackIt
import Utils as FnUtls
import Banners

import Control.Concurrent.Async (concurrently)
import Control.Monad.IO.Class (liftIO)

import System.Directory (createDirectoryIfMissing)

import System.IO
import System.Process


main :: IO ()
main = do

  let dirForSaving = "./bytestrings/"

  createDirectoryIfMissing True dirForSaving

  putStr deadOpsKatakana
  putStr deadOpsBloody
  -- putStr deadOPS

  liftIO $ sendSMS

  putStrLn $ "\n TRACKING: " ++ "<NULL>"


  putStr drrsForensics



  -- Use mapConcurrently instead, this is sloppy batching - just for MVP
  let batchOne = [startTracking "https://deadrabbits.io/ARCHIVAL_FOOTAGE" "00"]
  let batchTwo = [startTracking "https://deadrabbits.io/LORE" "01", startTracking "https://deadrabbits.io/ARGs" "02"]
  let batchThree = [startTracking "https://deadrabbits.io/CLAN" "03"]
  let batchFour = [startTracking "https://deadrabbits.io/vlk_sys_check" "04"]
  -- let batchFive = [startTracking "https://deadrabbits.io/ARCHIVAL_FOOTAGE"]
  -- let batchSix = [startTracking "https://deadrabbits.io/ARCHIVAL_FOOTAGE"]
  -- let batchSeven = [startTracking "https://deadrabbits.io/ARCHIVAL_FOOTAGE"]
  -- let batchEight = [startTracking "https://deadrabbits.io/ARCHIVAL_FOOTAGE"]

  concurrently
    (concurrently 
      (FnUtls.loopFnMany batchThree 90 1)
      (FnUtls.loopFnMany batchFour 90 1))
    (concurrently 
      (FnUtls.loopFnMany batchOne 90 1)
      (FnUtls.loopFnMany batchTwo 90 1))

  print "\n\n TRACKER SHUTTING OFF \n"
