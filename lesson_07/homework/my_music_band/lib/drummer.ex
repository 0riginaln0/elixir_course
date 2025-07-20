defmodule MyMusicBand.Drummer do
  alias MyMusicBand.Model.Musician

  @drum_sounds [:BOOM, :Doom, :Ts, :" "]

  def init(sounds) do
    case Enum.reduce(sounds, {1, []}, fn sound, wrong_sounds ->
           Musician.analyze_sound(sound, wrong_sounds, @drum_sounds)
         end) do
      {_, []} -> {:ok, %{sounds: {sounds, []}}}
      {_, wrong_sounds} -> {:error, Enum.reverse(wrong_sounds)}
    end
  end

  def next(drummer) do
    Musician.next(drummer)
  end
end
