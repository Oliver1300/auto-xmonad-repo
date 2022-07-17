import XMonad

main :: IO ()
main = xmonad def
  { terminal = "alacritty" -- changes the default terminal to alacritty NO TESTED YET
  , modMask = mod4Mask -- changes the mod key from default ALT to SUPER(windows key)
  }
