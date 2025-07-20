defmodule MyMusicBand.Guitarist do
  alias MyMusicBand.Model.Musician

  @guitar_sounds [:A, :D, :E, :" "]

  def init(sounds) do
    case Enum.reduce(sounds, {1, []}, fn sound, wrong_sounds ->
           Musician.analyze_sound(sound, wrong_sounds, @guitar_sounds)
         end) do
      {_, []} -> {:ok, %{sounds: {sounds, []}}}
      {_, wrong_sounds} -> {:error, Enum.reverse(wrong_sounds)}
    end
  end

  def next(guitarist) do
    Musician.next(guitarist)
  end
end
