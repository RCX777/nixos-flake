import XMonad

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Cursor
import XMonad.Util.SpawnOnce

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

import XMonad.Actions.OnScreen

import qualified XMonad.StackSet as W
import Data.Map as M

main :: IO ()
main = do
       xmonad . withSB mySB . ewmhFullscreen . ewmh . docks $ def
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
        , workspaces         = myWorkspaces
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
        , ("M-<Esc>", spawn "eww open --toggle lockscreen")
        ]

myPP :: PP
myPP = def
  { ppCurrent          = \w -> "(button :class 'workspace_current' :onclick 'wmctrl -s" ++ w ++ "')"
  , ppHidden           = \w -> "(button :class 'workspace_active' :onclick 'wmctrl -s" ++ w ++ "')"
  , ppVisible          = \w -> "(button :class 'workspace_active' :onclick 'wmctrl -s" ++ w ++ "')"
  , ppHiddenNoWindows  = \w -> "(button :class 'workspace_inactive' :onclick 'wmctrl -s" ++ w ++ "')"
  , ppVisibleNoWindows = Just $ \w -> "(button :class 'workspace_inactive' :onclick 'wmctrl -s" ++ w ++ "')"
  , ppLayout           = const "(box :class 'workspaces' :halign 'center' :orientation 'h' :spacing 10"
  , ppTitle            = const ")"
  , ppSep              = " "
  , ppOrder            = \(ws : l : t : _) -> [l, ws, t]
  }

mySB :: StatusBarConfig
mySB = statusBarProp "eww open --toggle bar-container" (pure myPP)

myWorkspaces = ["0", "1", "2", "3", "4", "5"]

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                then W.sink w s
                else W.float w (W.RationalRect 0 0 1 1) s)

myStartupHook :: X ()
myStartupHook = do
    -- Replaces the 'X' cursor
    setDefaultCursor xC_left_ptr
    -- Cleans ~
    spawnOnce "rm -f $HOME/.xsession-errors*"
    -- Sets the background
    spawnOnce "feh --no-fehbg --bg-scale ~/Media/Images/Wallpapers/forest.png"
    -- Sets up my multiple screens (somehow doesn't break when the second screen is not connected)
    spawnOnce "xrandr --output HDMI-0 --mode 1920x1080 --rate 165 --primary"

myManageHook :: ManageHook
myManageHook = composeAll
    [ isDialog            --> doFloat
    , isFullscreen        --> doFullFloat
    , manageDocks
    ]

myLayout = tiled ||| Mirror tiled ||| noBorders Full ||| threeCol
  where
    b = 0
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = spacingRaw False (Border b 0 b 0) True (Border 0 b 0 b) True
             $ Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
