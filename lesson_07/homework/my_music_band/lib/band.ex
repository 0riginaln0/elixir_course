defmodule MyMusicBand.Band do
  alias MyMusicBand.Model.Musician

  def init() do
    %{players: []}
  end

  def add_player(band, player) do
    %{band | players: band.players ++ [player]}
  end

  def next(band) do
    {sounds, players} =
      band.players
      |> Enum.map(fn player ->
        {sound, updated_player} = Musician.next(player)
        {sound, updated_player}
      end)
      |> Enum.unzip()

    {sounds, %{players: players}}
  end

  def sample_band do
    %{
      players: [
        %{
          sounds:
            {[
               :"A-a-a",
               :"O-o-o",
               :" ",
               :"A-a-a",
               :Wooo,
               :" ",
               :"E-e-e",
               :"O-o-o",
               :Wooo,
               :" ",
               :"O-o-o",
               :Wooo
             ], []}
        },
        %{sounds: {[:A, :D, :" ", :A, :E, :" ", :E, :D, :A], []}},
        %{sounds: {[:BOOM, :Ts, :Ts, :Doom, :Ts, :Ts], []}}
      ]
    }
  end
end
