module LoginPage exposing (..)

import Html exposing (Html, button, div, input, label, text)
import Html.Attributes exposing (class, for, hidden, id, name, placeholder, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Models exposing (Email, Model, Password)
import Msgs exposing (..)


loginPage : Model -> Html Msg
loginPage model =
    let
        historyPath =
            "/history"
    in
    div
        [ class "loginPage" ]
        [ div
            [ hidden
                (if String.isEmpty model.errorMsg then
                    True
                 else
                    False
                )
            ]
            [ text model.errorMsg ]
        , Html.form
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
                , onInput (\val -> UpdateLoginData Email val)
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
                , onInput (\val -> UpdateLoginData Password val)
                ]
                []
            , button
                [ class "btn"
                , type_ "submit"
                ]
                [ text "login" ]
            ]
        ]
