import XMonad

main :: IO ()
main = xmonad def
  { terminal = "alacritty" -- changes the default terminal to alacritty
  , modMask = mod4Mask -- changes the mod key from ALT to SUPER key
  }
