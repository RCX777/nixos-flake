import XMonad

import XMonad.Layout.NoBorders

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.WindowSwallowing

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab
import XMonad.Util.Run
import XMonad.Util.Cursor

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing

import XMonad.Hooks.EwmhDesktops

import XMonad.Util.SpawnOnce

import XMonad.Layout.IndependentScreens
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import Data.Map as M

toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

main :: IO ()
main = do
       xmonad $ docks $ ewmhFullscreen $ ewmh $ def
        { modMask            = mod4Mask      -- Rebind Mod to the Super key
        , startupHook        = myStartupHook
        , focusFollowsMouse  = True
        , clickJustFocuses   = False
        , layoutHook         = noBorders $ avoidStruts myLayout
        , manageHook         = myManageHook  -- Match on certain windows
        , terminal           = "alacritty"
        , borderWidth        = 0
        , focusedBorderColor = "#cba6f7"
        , normalBorderColor  = "#b4befe"
        , handleEventHook    = swallowEventHook (className =? "Alacritty") (return True)
        , workspaces         = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        }
        `additionalKeysP`
        [ ("M-w"  , spawn "firefox"                       )
        , ("M-e"  , spawn "alacritty"                     )
        , ("M-b"  , sendMessage ToggleStruts              )
        , ("M-r"  , spawn "killall eww; xmonad --restart" )
        , ("M-`"  , spawn "rofi -show drun"               )
        , ("M-f",   withFocused toggleFloat               )
        , ("<Print>", spawn "flameshot gui"               )
        , ("<XF86AudioLowerVolume>", spawn "pamixer -d 2" )
        , ("<XF86AudioRaiseVolume>", spawn "pamixer -i 2" )
        , ("<Esc>", spawn "eww close lockscreen"          )
        , ("M-<Esc>", spawn "eww open --toggle lockscreen")
        ]

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                then W.sink w s
                else (W.float w (W.RationalRect 0 0 1 1) s))

myStartupHook :: X ()
myStartupHook = do
    setDefaultCursor xC_left_ptr
    spawnOnce "rm -f $HOME/.xsession-errors*"
    spawnOnce "feh --no-fehbg --bg-scale ~/Media/Images/Wallpapers/forest.png"
    spawn     "eww open --toggle bar-container"
    spawnOnce "xrandr --output HDMI-0 --mode 1920x1080 --rate 165 --primary --right-of eDP-1-1 --output eDP-1-1 --auto"

myManageHook :: ManageHook
myManageHook = composeAll
    [ isDialog            --> doFloat
    , isFullscreen        --> doFullFloat
    , manageDocks
    ]

myLayout = tiled ||| Mirror tiled ||| noBorders Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = spacingRaw False (Border 10 0 10 0) True (Border 0 10 0 10) True $ Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

