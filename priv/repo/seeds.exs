# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Convallaria.Repo.insert!(%Convallaria.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Convallaria.{
  Accounts,
}

{:ok, u0} = Accounts.register_user(%{
  "mobile" => "13825279842",
  "password" => "123456",
  "password_confirmation" => "123456",
})

Accounts.mark_as_actived(u0)
Accounts.mark_as_admin(u0)

{:ok, u0} = Accounts.register_user(%{
  "mobile" => "18126129820",
  "password" => "123456",
  "password_confirmation" => "123456",
})

Accounts.mark_as_actived(u0)
