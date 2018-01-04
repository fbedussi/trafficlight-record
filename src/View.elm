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


getDirectionIndicatorOffest : Data -> ( Int, Int )
getDirectionIndicatorOffest data =
    let
        northLength =
            List.length data.north
                |> toFloat

        southLength =
            List.length data.south
                |> toFloat

        eastLength =
            List.length data.east
                |> toFloat

        westLength =
            List.length data.west
                |> toFloat

        totalLength =
            northLength + southLength + eastLength + westLength

        xOffset =
            (eastLength - westLength) / totalLength * 100

        yOffset =
            (southLength - northLength) / totalLength * 100
    in
    ( round xOffset, round yOffset )


getTotalRedPercentage : Model -> Int
getTotalRedPercentage model =
    let
        totalValues =
            model.data.north
                |> List.append model.data.south
                |> List.append model.data.east
                |> List.append model.data.west

        numberOfValues =
            List.length totalValues

        reds =
            List.filter (\val -> val == Red) totalValues

        numberOfReds =
            List.length reds
    in
    round (toFloat numberOfReds / toFloat numberOfValues * 100)


homePage : Model -> Html Msg
homePage model =
    let
        historyPath =
            "/history"
    in
    div
        [ class "homePage" ]
        [ div
            [ class "redBar"
            , style [ ( "height", (getTotalRedPercentage model |> toString) ++ "%" ) ]
            ]
            []
        , div
            [ class "topContainer" ]
            [ trafficLight North
            ]
        , div
            [ class "middleContainer" ]
            [ trafficLight West
            , div
                [ class "compassContainer" ]
                [ compass ()
                , div
                    [ class "directionIndicator"
                    , style [ ( "transform", "translate(" ++ (getDirectionIndicatorOffest model.data |> Tuple.first |> toString) ++ "%, " ++ toString (Tuple.second (getDirectionIndicatorOffest model.data)) ++ "%)" ) ]
                    ]
                    []
                ]
            , trafficLight East
            ]
        , div
            [ class "bottomContainer" ]
            [ trafficLight South ]
        , div [ class "footer" ]
            [ a
                [ class "historyLink btn"
                , href historyPath
                , onLinkClick (ChangeLocation historyPath)
                ]
                [ text "view data" ]
            ]
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
        , div [ class "footer" ]
            [ a
                [ class "homeLink btn"
                , href homePath
                , onLinkClick (ChangeLocation homePath)
                ]
                [ text "back" ]
            ]
        ]
