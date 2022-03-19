defmodule TestingLiveViewWallaby.Questions do
  @moduledoc """
  The Questions context.
  """

  import Ecto.Query, warn: false
  alias TestingLiveViewWallaby.Repo

  alias TestingLiveViewWallaby.Questions.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers(:question_created)
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers(:question_updated)
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    question
    |> Repo.delete()
    |> notify_subscribers(:question_deleted)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  def subscribe, do: Phoenix.PubSub.subscribe(TestingLiveViewWallaby.PubSub, topic())
  def subscribe(id), do: Phoenix.PubSub.subscribe(TestingLiveViewWallaby.PubSub, topic(id))

  defp topic, do: "questions"
  defp topic(id), do: "questions#{id}"

  def notify_subscribers({:ok, %Question{id: id} = question}, event) do
    Phoenix.PubSub.broadcast(TestingLiveViewWallaby.PubSub, topic(), {event, question})
    Phoenix.PubSub.broadcast(TestingLiveViewWallaby.PubSub, topic(id), {event, question})
    {:ok, question}
  end

  def notify_subscribers(result, _event), do: result
end
