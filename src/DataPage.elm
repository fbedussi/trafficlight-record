module DataPage exposing (..)

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


renderColor : PassageData -> String
renderColor passageData =
    getColorLabel passageData.color


renderDirectionData : String -> List PassageData -> Html Msg
renderDirectionData direction passageData =
    passageData
        |> List.map renderColor
        |> String.join ", "
        |> String.append (direction ++ ": ")
        |> text


getTotalPassages : Data -> Int
getTotalPassages data =
    List.length data.north + List.length data.south + List.length data.east + List.length data.west


getPercentage : Int -> Int -> Float
getPercentage number total =
    toFloat number / toFloat total * 100


textNodeFromNumber : Int -> Html Msg
textNodeFromNumber number =
    number |> toString |> text


dataPage : Model -> Html Msg
dataPage model =
    let
        homePath =
            "/home"
    in
    div
        [ class "dataPage" ]
        [ div
            [ class "recapWrapper" ]
            [ div
                [ class "recapWrapper-row" ]
                [ span
                    [ class "recapWrapper-label" ]
                    [ text "Total passages: " ]
                , span
                    [ class "recapWrapper-data" ]
                    [ getTotalPassages model.data |> textNodeFromNumber ]
                ]
            , div
                [ class "recapWrapper-north" ]
                [ text "North" ]
            , div
                [ class "recapWrapper-row" ]
                [ span
                    [ class "recapWrapper-label" ]
                    [ text "Total passages: " ]
                , span
                    [ class "recapWrapper-data" ]
                    [ model.data.north |> List.length |> textNodeFromNumber ]
                ]
            , div
                [ class "recapWrapper-row" ]
                [ span
                    [ class "recapWrapper-label" ]
                    [ text "% passages: " ]
                , span
                    [ class "recapWrapper-data" ]
                    [ getTotalPassages model.data |> getPercentage (List.length model.data.north) |> toString |> text ]
                ]
            ]
        , div
            [ class "dataWrapper" ]
            [ div
                [ class "north" ]
                [ span
                    []
                    [ model.data.north
                        |> renderDirectionData "north"
                    ]
                ]
            , div
                [ class "south" ]
                [ span
                    []
                    [ model.data.south
                        |> renderDirectionData "south"
                    ]
                ]
            , div
                [ class "east" ]
                [ span
                    []
                    [ model.data.east
                        |> renderDirectionData "east"
                    ]
                ]
            , div
                [ class "west" ]
                [ span
                    []
                    [ model.data.west
                        |> renderDirectionData "west"
                    ]
                ]
            , div
                [ class "footer" ]
                [ a
                    [ class "homeLink btn"
                    , href homePath
                    , onLinkClick (ChangeLocation homePath)
                    ]
                    [ text "back" ]
                ]
            ]
        ]
