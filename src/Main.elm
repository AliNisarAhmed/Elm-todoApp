module Main exposing (Model, init)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { todos : List Todo
    , value : String
    }


type alias Todo =
    { text : String
    , completed : Bool
    }



-- MODEL


init : Model
init =
    { todos = [ { text = "I am first", completed = False } ]
    , value = ""
    }



-- MSG


type Msg
    = AddTodo
    | Change String



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo ->
            { model | todos = List.append model.todos [ { text = model.value, completed = False } ], value = "" }

        Change newValue ->
            { model | value = newValue }



-- VIEW


viewTodos : List Todo -> List (Html Msg)
viewTodos todos =
    List.map (\todo -> li [] [ text todo.text ]) todos


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Add Todo", value model.value, onInput Change ] []
        , button [ onClick AddTodo ] [ text "Click Me" ]
        , ul [] (viewTodos model.todos)
        ]


main =
    Browser.sandbox { init = init, update = update, view = view }
