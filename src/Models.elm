module Models exposing (..)

import Time exposing (Time)


type alias Model =
    { route : Route
    , data : Data
    , loginData : LoginData
    , userUid : UserUid
    }


type Route
    = LoginPage
    | Home
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


type alias Email =
    String


type alias Password =
    String


type alias LoginData =
    { email : Email
    , password : Password
    }


type LoginField
    = Email
    | Password


type alias UserUid =
    String

    
resetModel : Route -> Model
resetModel route =
    Model
        route
        { north = []
        , south = []
        , east = []
        , west = []
        }
        { email = ""
        , password = ""
        }
        ""


