defmodule ConvallariaWeb.Admin.VerifyCodeView do
  use ConvallariaWeb, :view
  
  def is_validated?(verify_code) do
    send_time = verify_code.inserted_at
    NaiveDateTime.add(send_time, 60, :second) > NaiveDateTime.utc_now()
    # cond do
    #   NaiveDateTime.add(send_time, 60, :second) > NaiveDateTime.utc_now() ->
    #     "有效"
    #   true ->
    #     "expired"
    # end
  end
end
