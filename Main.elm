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
    = Ace
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


type CardName
    = Minor Rank Suit
    | Major Major


type alias Deck =
    List Card


type alias Card =
    { cardName : CardName
    , imgSrc : String
    , visible : Bool
    }


majorList : List Major
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


rankList : List Rank
rankList =
    [ Ace
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


suitList : List Suit
suitList =
    [ Wands
    , Cups
    , Swords
    , Pentacles
    ]


imgList : List String
imgList =
    [ "http://rider-waite.tarotsmith.net/cards/wands01ace.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands02.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands03.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands04.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands05.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands06.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands07.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands08.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands09.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands10.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands11page.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands12knight.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands13queen.jpg"
    , "http://rider-waite.tarotsmith.net/cards/wands14king.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups01ace.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups02.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups03.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups04.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups05.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups06.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups07.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups08.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups09.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups10.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups11page.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups12knight.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups13queen.jpg"
    , "http://rider-waite.tarotsmith.net/cards/cups14king.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords01ace.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords02.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords03.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords04.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords05.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords06.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords07.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords08.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords09.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords10.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords11page.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords12knight.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords13queen.jpg"
    , "http://rider-waite.tarotsmith.net/cards/swords14king.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents01ace.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents02.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents03.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents04.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents05.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents06.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents07.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents08.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents09.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents10.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents11page.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents12knight.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents13queen.jpg"
    , "http://rider-waite.tarotsmith.net/cards/pents14king.jpg"
    , "http://rider-waite.tarotsmith.net/cards/00fool.jpg"
    , "http://rider-waite.tarotsmith.net/cards/01magician.jpg"
    , "http://rider-waite.tarotsmith.net/cards/02priestess.jpg"
    , "http://rider-waite.tarotsmith.net/cards/03empress.jpg"
    , "http://rider-waite.tarotsmith.net/cards/04emperor.jpg"
    , "http://rider-waite.tarotsmith.net/cards/05hierophant.jpg"
    , "http://rider-waite.tarotsmith.net/cards/06lovers.jpg"
    , "http://rider-waite.tarotsmith.net/cards/07chariot.jpg"
    , "http://rider-waite.tarotsmith.net/cards/08strength.jpg"
    , "http://rider-waite.tarotsmith.net/cards/09hermit.jpg"
    , "http://rider-waite.tarotsmith.net/cards/10wheel.jpg"
    , "http://rider-waite.tarotsmith.net/cards/11justice.jpg"
    , "http://rider-waite.tarotsmith.net/cards/12hangedman.jpg"
    , "http://rider-waite.tarotsmith.net/cards/13death.jpg"
    , "http://rider-waite.tarotsmith.net/cards/14temperance.jpg"
    , "http://rider-waite.tarotsmith.net/cards/15devil.jpg"
    , "http://rider-waite.tarotsmith.net/cards/16tower.jpg"
    , "http://rider-waite.tarotsmith.net/cards/17star.jpg"
    , "http://rider-waite.tarotsmith.net/cards/18moon.jpg"
    , "http://rider-waite.tarotsmith.net/cards/19sun.jpg"
    , "http://rider-waite.tarotsmith.net/cards/20judgement.jpg"
    , "http://rider-waite.tarotsmith.net/cards/21world.jpg"
    ]


minorArcana : List CardName
minorArcana =
    List.Extra.lift2 (,) suitList rankList
        |> List.map (\( suit, rank ) -> Minor rank suit)


majorArcana : List CardName
majorArcana =
    List.map Major majorList



--model : Model
--model =
--    majorArcana


cardNames : List CardName
cardNames =
    minorArcana ++ majorArcana


cardList : List Card
cardList =
    List.map2 (,) cardNames imgList
        |> List.map (\( cardName, img ) -> { cardName = cardName, imgSrc = img, visible = False })


deck : Deck
deck =
    cardList



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
