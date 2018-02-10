module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import List
import Random.List
import Random
import List.Extra


main =
    Html.program { init = ( deck, Cmd.none ), view = view, update = update, subscriptions = always Sub.none }



-- MODEL


type alias Model =
    Deck


type Rank
    = One
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Page
    | Knight
    | Queen
    | King


type Suit
    = Wands
    | Cups
    | Swords
    | Pentacles


type Major
    = Fool
    | Magician
    | HighPriestess
    | Empress
    | Emperor
    | Hierophant
    | Lovers
    | Chariot
    | Strength
    | Hermit
    | WheelOfFortune
    | Justice
    | HangedMan
    | Death
    | Temperance
    | Devil
    | Tower
    | Star
    | Moon
    | Sun
    | Judgement
    | World


type Card
    = Minor Rank Suit
    | Major Major


type alias Deck =
    List Card


majorList =
    [ Fool
    , Magician
    , HighPriestess
    , Empress
    , Emperor
    , Hierophant
    , Lovers
    , Chariot
    , Strength
    , Hermit
    , WheelOfFortune
    , Justice
    , HangedMan
    , Death
    , Temperance
    , Devil
    , Tower
    , Star
    , Moon
    , Sun
    , Judgement
    , World
    ]


rankList =
    [ One
    , Two
    , Three
    , Four
    , Five
    , Six
    , Seven
    , Eight
    , Nine
    , Ten
    , Page
    , Knight
    , Queen
    , King
    ]


suitList =
    [ Wands
    , Cups
    , Swords
    , Pentacles
    ]


minorArcana : List Card
minorArcana =
    List.Extra.lift2 (,) rankList suitList
        |> List.map (\( fst, snd ) -> Minor fst snd)


majorArcana : List Card
majorArcana =
    List.map Major majorList


model : Model
model =
    majorArcana


deck : Deck
deck =
    minorArcana ++ majorArcana



-- UPDATE


type Msg
    = Shuffle
    | Shuffled (List Card)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Shuffle ->
            ( model, Random.generate Shuffled (Random.List.shuffle deck) )

        Shuffled deck ->
            ( deck, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Shuffle ] [ text "Read my fortune" ]
        , text (toString model)
        ]
