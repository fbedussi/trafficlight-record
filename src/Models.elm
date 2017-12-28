module Models exposing (..)


type alias Model =
    { route : Route
    , data : Data
    }


type Route
    = Home
    | Page1
    | NotFoundRoute


type alias Data =
    { north : List Bool
    , south : List Bool
    , east : List Bool
    , west : List Bool
    }


type alias FirebaseCmd =
    { name : String
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
