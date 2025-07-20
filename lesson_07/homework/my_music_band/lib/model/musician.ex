defmodule MyMusicBand.Model.Musician do

  @type musician() :: %{sounds: {[], []}}

  def analyze_sound(sound, {i, wrong_sounds}, valid_sounds) do
    if sound in valid_sounds do
      {i + 1, wrong_sounds}
    else
      {i + 1, [{i, sound} | wrong_sounds]}
    end
  end

  def next(%{sounds: {[], processed}}) do
    [sound | rest] = Enum.reverse(processed)
    {sound, %{sounds: {rest, [sound]}}}
  end

  def next(%{sounds: {[sound | rest], processed}}) do
    {sound, %{sounds: {rest, [sound | processed]}}}
  end
end

