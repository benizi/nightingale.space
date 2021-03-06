module Note exposing (..)


type Accidental
    = Sharp
    | Flat


type Note
    = Note
        { tweetId : Int
        , letter : String
        , accidental : Maybe Accidental
        , octave : Int
        , length : String
        , parseStart : Int
        , parseEnd : Int
        }


type alias PortNote =
    { tweetId : Int
    , letter : String
    , accidental : Maybe String
    , octave : Int
    , length : String
    , parseStart : Int
    , parseEnd : Int
    }


toPortNote (Note note) =
    { tweetId = note.tweetId
    , letter = note.letter
    , accidental =
        case note.accidental of
            Just Sharp ->
                Just "+"

            Just Flat ->
                Just "-"

            Nothing ->
                Nothing
    , octave = note.octave
    , length = note.length
    , parseStart = note.parseStart
    , parseEnd = note.parseEnd
    }
