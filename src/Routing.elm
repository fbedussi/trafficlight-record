module Routing exposing (..)

import Debug
import Models exposing (Route(..))
import Navigation exposing (Location)
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map LoginPage top
        , map Home (s "home")
        , map History (s "history")
        ]


parseLocation : Location -> Route
parseLocation location =
    case parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
