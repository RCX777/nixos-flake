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
       xmonad . ewmhFullscreen . ewmh =<< statusBar "xmobar" sjanssenPP toggleStrutsKey (def
        { modMask            = mod4Mask      -- Rebind Mod to the Super key
        , startupHook        = myStartupHook
        , focusFollowsMouse  = True
        , clickJustFocuses   = False
        , layoutHook         = avoidStruts $ smartBorders myLayout      -- Use custom layouts
        , manageHook         = myManageHook  -- Match on certain windows
        , terminal           = "alacritty"
        , borderWidth        = 2
        , focusedBorderColor = "#cba6f7"
        , normalBorderColor  = "#b4befe"
        , handleEventHook    = swallowEventHook (className =? "Alacritty") (return True)
        , workspaces         = withScreens 2 ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        }
        `additionalKeysP`
        [ ("M-w"  , spawn "firefox"                   )
        , ("M-e"  , spawn "alacritty"                 )
        , ("M-r"  , spawn "killall xmobar; xmonad --restart")
        , ("M-`"  , spawn "rofi -show drun"           )
        , ("M-<Left>", moveTo Prev workspaceOnCurrentScreen)
        , ("M-<Right>", moveTo Next workspaceOnCurrentScreen)
        , ("M-f",   withFocused toggleFloat)
        , ("<Print>", spawn "flameshot gui")
        ])

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                then W.sink w s
                else (W.float w (W.RationalRect 0 0 1 1) s))

currentScreen :: X ScreenId
currentScreen = gets (W.screen . W.current . windowset)

isOnScreen :: ScreenId -> WindowSpace -> Bool
isOnScreen s ws = s == unmarshallS (W.tag ws)

workspaceOnCurrentScreen :: WSType
workspaceOnCurrentScreen = WSIs $ do
    s <- currentScreen
    return $ \x -> W.tag x /= "NSP" && isOnScreen s x

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "rm -f $HOME/.xsession-errors*"
    spawnOnce "feh --no-fehbg --bg-scale ~/Media/Images/Wallpapers/forest.png"
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
    tiled    = smartSpacing 5 $ Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

