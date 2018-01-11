module View exposing (..)

import Graphics exposing (..)
import HistoryPage exposing (history)
import HomePage exposing (homePage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import List exposing (map)
import LoginPage exposing (loginPage)
import Models exposing (..)
import Msgs exposing (..)


view : Model -> Html Msg
view model =
    case model.route of
        Models.LoginPage ->
            loginPage model

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
