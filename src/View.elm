module View exposing (..)

import Graphics exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import List exposing (map)
import Models exposing (..)
import Msgs exposing (..)


onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
    onWithOptions "click" options (Decode.succeed message)


view : Model -> Html Msg
view model =
    case model.route of
        Models.Home ->
            homePage model

        Models.History ->
            history model

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]


getColorLabel : Color -> String
getColorLabel color =
    case color of
        Red ->
            "red"

        Green ->
            "green"


renderColor : Color -> Html Msg
renderColor color =
    span []
        [ getColorLabel color |> text ]


extractDirectionData : Model -> Direction -> List Color
extractDirectionData model direction =
    case direction of
        North ->
            model.data.north

        South ->
            model.data.south

        East ->
            model.data.east

        West ->
            model.data.west


getPercentage : Model -> Direction -> Color -> String
getPercentage model direction color =
    let
        colors =
            extractDirectionData model direction

        colorsLenght =
            List.length colors

        colorsFiltered =
            List.filter (\item -> item == color) colors

        colorsFilteredLength =
            List.length colorsFiltered

        percentage =
            round (toFloat colorsFilteredLength / toFloat colorsLenght * 100)
    in
    toString percentage


homePage : Model -> Html Msg
homePage model =
    let
        historyPath =
            "/history"
    in
    div
        [ class "homePage" ]
        [ div
            [ class "topContainer" ]
            [ div
                [ class "dataContainer" ]
                [ text ("red: " ++ getPercentage model North Red ++ "%") ]
            , trafficLight North
            , div
                [ class "dataContainer" ]
                [ text ("green: " ++ getPercentage model North Green ++ "%") ]
            ]
        , div
            [ class "middleContainer" ]
            [ trafficLight West
            , div
                [ class "compassContainer" ]
                [ compass () ]
            , trafficLight East
            ]
        , div
            [ class "bottomContainer" ]
            [ trafficLight South ]
        , a
            [ class "historyLink"
            , href historyPath
            , onLinkClick (ChangeLocation historyPath)
            ]
            [ text "data history" ]
        ]


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
        , a
            [ class "homeLink"
            , href homePath
            , onLinkClick (ChangeLocation homePath)
            ]
            [ text "data history" ]
        ]
