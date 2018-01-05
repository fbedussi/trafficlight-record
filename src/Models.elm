module Models exposing (..)

import Time exposing (Time)


type alias Model =
    { route : Route
    , data : Data
    }


type Route
    = Home
    | History
    | NotFoundRoute


type Direction
    = North
    | South
    | East
    | West


type Color
    = Red
    | Green


type alias PassageData =
    { time : Time
    , color : Color
    }


type alias Data =
    { north : List PassageData
    , south : List PassageData
    , east : List PassageData
    , west : List PassageData
    }


type alias JsonPassageData =
    ( String, PassageData )


type alias JsonString =
    String


type alias FirebaseCmd =
    { name : String
    , payload : JsonString
    }


resetModel : Route -> Model
resetModel route =
    Model
        route
        { north = []
        , south = []
        , east = []
        , west = []
        }
