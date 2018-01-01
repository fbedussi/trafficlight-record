module Models exposing (..)


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


type alias Data =
    { north : List Color
    , south : List Color
    , east : List Color
    , west : List Color
    }


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
