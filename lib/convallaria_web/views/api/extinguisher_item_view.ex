defmodule ConvallariaWeb.Api.ExtinguisherItemView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.ExtinguisherItemView

  def render("index.json", %{extinguisher_items: extinguisher_items}) do
    %{data: render_many(extinguisher_items, ExtinguisherItemView, "extinguisher_item.json")}
  end

  def render("show.json", %{extinguisher_item: extinguisher_item}) do
    %{data: render_one(extinguisher_item, ExtinguisherItemView, "extinguisher_item.json")}
  end

  def render("extinguisher_item.json", %{extinguisher_item: extinguisher_item}) do
    %{id: extinguisher_item.id,
      uuid: extinguisher_item.uuid,
      name: extinguisher_item.name,
      desc: extinguisher_item.desc}
  end
end
