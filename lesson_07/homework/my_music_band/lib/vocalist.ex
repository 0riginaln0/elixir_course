defmodule MyMusicBand.Vocalist do
  alias MyMusicBand.Model.Musician

  @vocal_sounds [:"A-a-a", :"O-o-o", :"E-e-e", :Wooo, :" "]

  def init(sounds) do
    case Enum.reduce(sounds, {1, []}, fn sound, wrong_sounds ->
           Musician.analyze_sound(sound, wrong_sounds, @vocal_sounds)
         end) do
      {_, []} -> {:ok, %{sounds: {sounds, []}}}
      {_, wrong_sounds} -> {:error, Enum.reverse(wrong_sounds)}
    end
  end

  def next(vocalist) do
    Musician.next(vocalist)
  end
end
