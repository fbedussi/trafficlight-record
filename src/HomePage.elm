module HomePage exposing (..)

import Graphics exposing (..)
import Helpers exposing (onLinkClick)
import Html exposing (..)
import Html.Attributes exposing (..)
import List exposing (map)
import Models exposing (..)
import Msgs exposing (..)


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
            List.filter (\val -> val.color == Red) totalValues

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
            [ class "trafficLightsWrapper" ]
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
            ]
        , div [ class "footer" ]
            [ a
                [ class "historyLink btn"
                , href historyPath
                , onLinkClick (ChangeLocation historyPath)
                ]
                [ text "view data" ]
            ]
        ]
