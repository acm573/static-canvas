{-# LANGUAGE OverloadedStrings          #-}

-------------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Static.Javascript
-- Copyright   :  (c) 2015 Jeffrey Rosenbluth
-- License     :  BSD-style (see LICENSE)
-- Maintainer  :  jeffrey.rosenbluth@gmail.com
--
-- DSL for creating HTML5 Canvas.
--
-------------------------------------------------------------------------------

module Graphics.Static.Javascript where

import Control.Monad.Writer
import Data.Double.Conversion.Text (toFixed)
import Data.Text                   (pack)
import Data.Text.Lazy.Builder      (Builder, fromText, singleton)
import Graphics.Static.Types

build :: Show a => a -> Builder
build = fromText .pack . show
   
comma :: Builder
comma = singleton ','

jsBool :: Bool -> Builder
jsBool True = "true"
jsBool False = "false"

jsInt :: Int -> Builder
jsInt = fromText . pack . show

jsDouble :: Double -> Builder
jsDouble = fromText . toFixed 4

jsColor :: Color -> Builder
jsColor (Hex t)        = fromText t
jsColor (RGB r g b)    = "rgb("  <> (build r)
                      <> comma   <> (build g)
                      <> comma   <> (build b) <> singleton ')'
jsColor (RGBA r g b a) = "rgba(" <> (build r)
                      <> comma   <> (build g)
                      <> comma   <> (build b)
                      <> comma   <> (jsDouble a) <> singleton ')'

jsStyle :: Style -> Builder
jsStyle (ColorStyle c) = jsColor c
jsStyle (GradientStyle (LG n)) = "gradient_" <> (build n)
jsStyle (GradientStyle (RG n)) = "gradient_" <> (build n)

jsLineCap :: LineCapStyle -> Builder
jsLineCap LineCapButt   = "butt"
jsLineCap LineCapRound  = "round"
jsLineCap LineCapSquare = "square"

jsLineJoin :: LineJoinStyle -> Builder
jsLineJoin LineJoinMiter = "miter"
jsLineJoin LineJoinRound = "round"
jsLineJoin LineJoinBevel = "bevel"

jsTextAlign :: TextAlignStyle -> Builder
jsTextAlign TextAlignStart  = "start"
jsTextAlign TextAlignEnd    = "end"
jsTextAlign TextAlignCenter = "center"
jsTextAlign TextAlignLeft   = "left"
jsTextAlign TextAlignRight  = "right"

jsTextBaseline :: TextBaselineStyle -> Builder
jsTextBaseline TextBaselineTop         = "top"
jsTextBaseline TextBaselineHanging     = "hanging"
jsTextBaseline TextBaselineMiddle      = "middle"
jsTextBaseline TextBaselineIdeographic = "ideographic"
jsTextBaseline TextBaselineBottom      = "bottom"
