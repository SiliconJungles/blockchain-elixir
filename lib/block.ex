defmodule Block do
  def new(index, previousHash \\ "", timestamp, data) do
    %{
      index: index,
      previousHash: previousHash,
      timestamp: timestamp,
      hash: hash(index, previousHash, timestamp, data)
    }
  end

  defp hash(index, previousHash, timestamp, data) do
    :crypto.hash(:sha256, "#{index}#{previousHash}#{timestamp}#{data}")
    |> Base.encode16()
  end
end
