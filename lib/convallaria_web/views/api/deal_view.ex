defmodule ConvallariaWeb.Api.DealView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.DealView

  def render("index.json", %{deals: deals}) do
    %{data: render_many(deals, DealView, "deal.json")}
  end

  def render("show.json", %{deal: deal}) do
    %{data: render_one(deal, DealView, "deal.json")}
  end

  def render("deal.json", %{deal: deal}) do
    %{id: deal.id,
      share_at: deal.share_at,
      back_at: deal.back_at,
      charge: deal.charge,
      status: deal.status,
      item_id: deal.item_id,
      item_type: deal.item_type,
      user_id: deal.user_id}
  end
end
