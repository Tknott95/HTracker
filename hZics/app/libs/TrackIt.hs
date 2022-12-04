module TrackIt where


import Network.HTTP.Conduit (simpleHttp)

import qualified Data.ByteString.Lazy as LB
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy.Char8 as LBC
import Control.Concurrent (threadDelay, ThreadId, forkIO)

import Control.Monad.IO.Class (liftIO)
import System.IO
import System.Process

-- import Banners
import Colors

sendSMS :: IO ()
sendSMS = do
  let kout_flags = [] :: [String]

  putStrLn $ concat kout_flags 

  (_, Just kout, _, _) <- createProcess (proc "./sendSMS.sh" kout_flags){ std_out = CreatePipe }
  print kout


-- deadRabbitsURL = "https://deadrabbits.io"
-- vlkSysCheck = deadRabbitsURL ++ "/vlk_sys_check"

hasChanged :: LB.ByteString -> LB.ByteString -> Bool
hasChanged _i _j = _i /= _j

openURL :: String -> IO LB.ByteString
openURL _i = simpleHttp _i


forkedChanges :: LB.ByteString -> String -> String -> IO ()
forkedChanges _src _fileName _urlTracking = do
  handle <- openFile ("bytestrings/"++_fileName++".txt") ReadMode
  contents <- hGetContents handle

  let src_check = LBC.pack contents

  if hasChanged _src src_check 
    then sendSMS
  else print ""

  if hasChanged _src src_check
    then putStrLn $  bYlw
      ++ _urlTracking
      ++ "\n ^| " 
      ++ bRed
      ++ (show $ hasChanged _src src_check) ++ clr
    -- print $ hasChanged src src_test
  else 
    putStrLn $ dYlw
      ++ _urlTracking
      ++ "\n ^| " 
      ++ alt2
      ++ (show $ hasChanged _src src_check) ++ clr

  print ""

-- could be better to just loop over itself and delay in here with recursion passing back the src
startTracking :: String -> String -> IO ()
startTracking _urlTracking _fileName = do
  -- putStr deadOpsKatakana
  -- putStr deadOpsBloody
  -- putStr deadOPS

  -- THESE ARE ALL RUNNING ON THREADS NOW, SO NEEDING TO PUL BANNER OUT A LAYER
  -- MAY PASS IN an [IO()] in the future
  -- putStr drrsForensics
  -- putStr "\n \n\
  -- \   Welcome to deadOps \n\
  -- \   To utilize my abilities, please continue! \n"

  -- putStr deadOPS

  putStrLn $ alt ++
    "\n  TRACKING: " 
    ++ _urlTracking ++ clr

  src <- openURL (_urlTracking)
  -- src_test <- openURL (vlkSysCheck)
  
  forkIO $ writeFile ("bytestrings/"++_fileName++".txt") (LBC.unpack src)

  tID <- forkIO $ forkedChanges src _fileName _urlTracking
  print $ "threadID: "++ (show tID)

