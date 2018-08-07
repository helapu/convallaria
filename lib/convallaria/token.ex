defmodule Convallaria.Token do
  @moduledoc false

  alias Convallaria.Accounts.User

  @verification_salt "Convallaria"

  @endpoint "ibaludobsenudkaeoiukoeaukb"
  
  def generate_token(%User{id: user_id}) do
    Phoenix.Token.sign(@endpoint, @verification_salt, user_id)
    # Phoenix.Token.sign(ConvallariaWeb.Endpoint, @verification_salt, user_id)
  end

  def verify_token(token, expired_seconds \\ 86_400) do
    Phoenix.Token.verify(@endpoint, @verification_salt, token, max_age: expired_seconds)
  end
end
