defmodule Pento.Repo.Migrations.UpdateUsers do
  use Ecto.Migration

  import Ecto.Query

  alias Pento.Repo

  def change do
    alter table(:users) do
      add :username, :string, null: true 
  end

  flush()

  query = from u in "users", select: [u.id, 
    fragment("split_part(email::TEXT, '@', 1)"), u.email, u.hashed_password,
    u.inserted_at, u.updated_at]

  results = Repo.all(query)

  up_users = Enum.map(results, fn [a,b,c,d,e,f] -> [id: a, username: b, email: c, 
    hashed_password: d, inserted_at: e, updated_at: f] end)

  Repo.insert_all("users", up_users, on_conflict: {:replace, [:username]}, conflict_target: :id)

  create unique_index(:users, [:username])

  end
end
