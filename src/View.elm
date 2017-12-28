module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Icons exposing (..)
import Json.Decode as Decode
import List exposing (map)
import Models exposing (..)
import Msgs exposing (..)
import TouchEvents exposing (onTouchStart)


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
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.Home ->
            homePage model

        Models.Page1 ->
            page1

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]


renderVal : Bool -> Html Msg
renderVal val =
    let
        label =
            if val == True then
                "green"
            else
                "red"
    in
    span []
        [ text label ]


homePage : Model -> Html Msg
homePage model =
    div [ class "homePage" ]
        [ div [ class "north" ]
            (List.map
                renderVal
                model.data.north
            )
        , div [ class "south" ]
            (List.map
                renderVal
                model.data.south
            )
        , div [ class "east" ]
            (List.map
                renderVal
                model.data.east
            )
        , div [ class "west" ]
            (List.map
                renderVal
                model.data.west
            )
        ]


page1 : Html Msg
page1 =
    div
        []
        [ text "page1" ]
