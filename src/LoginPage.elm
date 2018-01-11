module LoginPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Html.Events exposing (..)


loginPage : Model -> Html Msg
loginPage model =
    let
        historyPath =
            "/history"
    in
    div
        [ class "loginPage" ]
        [ Html.form
            [ class "loginForm"
            , onSubmit Login
            ]
            [ label
                [ class "label"
                , for "emailField"
                ]
                []
            , input
                [ class "textInput"
                , id "emailField"
                , name "email"
                , type_ "email"
                , value model.loginData.email
                , placeholder "me@example.com"
                , onInput (\val -> (UpdateLoginData Email val))                 
                ]
                []
            , label
                [ class "label"
                , for "passwordField"
                ]
                []
            , input
                [ class "textInput"
                , id "passwordField"
                , name "password"
                , type_ "password"
                , value model.loginData.password
                , onInput (\val -> (UpdateLoginData Password val)) 
                ]
                []
            , button
                [class "btn"
                , type_ "submit"]
                [text "login"]
            ]
        ]
