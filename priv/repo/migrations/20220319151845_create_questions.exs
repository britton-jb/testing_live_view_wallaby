defmodule TestingLiveViewWallaby.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :text, :text

      timestamps()
    end
  end
end
