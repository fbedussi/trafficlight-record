module Graphics exposing (..)

import Html exposing (Html)
import Html.Events exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


trafficLight : Direction -> Html Msg
trafficLight direction =
    svg
        [ viewBox "0 0 62.579 159.553"
        , height "170.19"
        , width "66.751"
        , class "trafficLight"
        ]
        [ g
            [ transform "translate(-219.734 -376.09)" ]
            [ rect
                [ ry "12.923"
                , y "379.047"
                , x "222.69"
                , height "153.64"
                , width "56.665"
                , fill "none"
                , stroke "#000"
                , strokeWidth "5.914"
                , strokeLinecap "round"
                , strokeLinejoin "bevel"
                ]
                []
            , Svg.path
                [ d "M230.537 406.675a20.487 20.487 0 0 1 20.667-20.287 20.487 20.487 0 0 1 20.305 20.649 20.487 20.487 0 0 1-20.63 20.324 20.487 20.487 0 0 1-20.343-20.61"
                , fill "red"
                , onClick (HandleClick direction Red)
                ]
                []
            , Svg.path
                [ d "M230.537 454.152a20.487 20.487 0 0 1 20.667-20.287 20.487 20.487 0 0 1 20.305 20.649 20.487 20.487 0 0 1-20.63 20.325 20.487 20.487 0 0 1-20.343-20.612"
                , fill "#f60"
                ]
                []
            , Svg.path
                [ d "M230.537 501.63a20.487 20.487 0 0 1 20.667-20.287 20.487 20.487 0 0 1 20.305 20.648 20.487 20.487 0 0 1-20.63 20.325 20.487 20.487 0 0 1-20.343-20.611"
                , fill "green"
                , onClick (HandleClick direction Green)
                ]
                []
            ]
        ]


compass : () -> Html msg
compass () =
    svg
        [ viewBox "0 0 206.286 289"
        , height "308.267"
        , width "220.039"
        , class "compass"
        ]
        [ Svg.path
            [ d "M37.466 151.322h139"
            , fill "none"
            , stroke "#000"
            , strokeWidth "3.537"
            ]
            []
        , Svg.path
            [ d "M106.966 245.771V56.873"
            , fill "none"
            , stroke "#000"
            , strokeWidth "3.234"
            ]
            []
        , Svg.path
            [ d "M117.684 64.174H96.25l5.358-9.282 5.36-9.282 5.358 9.282z"
            , stroke "#000"
            , strokeWidth "4.022"
            , strokeLinecap "round"
            , strokeLinejoin "bevel"
            ]
            []
        , Svg.path
            [ d "M95.931 0h5.313l12.93 24.395V0h3.828v29.16h-5.313L99.76 4.766V29.16h-3.828V0z"
            ]
            []
        , Svg.path
            [ d "M113.812 262.864v3.495q-2.04-.975-3.85-1.454-1.81-.48-3.496-.48-2.928 0-4.525 1.136-1.579 1.136-1.579 3.23 0 1.756 1.047 2.66 1.065.888 4.01 1.438l2.165.444q4.01.763 5.908 2.697 1.917 1.916 1.917 5.145 0 3.85-2.591 5.838-2.573 1.987-7.559 1.987-1.88 0-4.01-.426-2.111-.426-4.382-1.26v-3.69q2.182 1.224 4.276 1.845t4.116.621q3.07 0 4.738-1.206 1.668-1.207 1.668-3.443 0-1.951-1.207-3.052-1.189-1.1-3.921-1.65l-2.183-.425q-4.01-.799-5.802-2.502-1.792-1.704-1.792-4.738 0-3.513 2.467-5.536 2.484-2.022 6.83-2.022 1.864 0 3.798.337t3.957 1.011zM0 137.709h3.62L9.19 160.1l5.554-22.392h4.027l5.572 22.392 5.554-22.392h3.637l-6.654 26.49h-4.507l-5.589-22.995-5.642 22.996H6.636L0 137.709zM189.217 137.709h16.75v3.016H192.8v7.843h12.616v3.016H192.8v9.6h13.485v3.016h-17.069v-26.491z"
            ]
            []
        ]
