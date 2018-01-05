module HistoryPage exposing (..)

import Graphics exposing (..)
import Helpers exposing (onLinkClick)
import HomePage exposing (homePage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import List exposing (map)
import Models exposing (..)
import Msgs exposing (..)


getColorLabel : Color -> String
getColorLabel color =
    case color of
        Red ->
            "red"

        Green ->
            "green"


renderColor : PassageData -> Html Msg
renderColor passageData =
    span []
        [ getColorLabel passageData.color |> text ]


history : Model -> Html Msg
history model =
    let
        homePath =
            "/"
    in
    div
        [ class "history" ]
        [ div [ class "north" ]
            (List.map
                renderColor
                model.data.north
            )
        , div [ class "south" ]
            (List.map
                renderColor
                model.data.south
            )
        , div [ class "east" ]
            (List.map
                renderColor
                model.data.east
            )
        , div [ class "west" ]
            (List.map
                renderColor
                model.data.west
            )
        , div [ class "footer" ]
            [ a
                [ class "homeLink btn"
                , href homePath
                , onLinkClick (ChangeLocation homePath)
                ]
                [ text "back" ]
            ]
        ]
