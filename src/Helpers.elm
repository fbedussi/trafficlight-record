module Helpers exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode


onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
    onWithOptions "click" options (Decode.succeed message)
