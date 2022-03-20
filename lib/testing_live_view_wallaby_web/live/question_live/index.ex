defmodule TestingLiveViewWallabyWeb.QuestionLive.Index do
  use TestingLiveViewWallabyWeb, :live_view

  alias TestingLiveViewWallaby.Questions
  alias TestingLiveViewWallaby.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    Questions.subscribe()
    {:ok, assign(socket, :questions, list_questions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Question")
    |> assign(:question, Questions.get_question!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Question")
    |> assign(:question, %Question{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questions")
    |> assign(:question, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    question = Questions.get_question!(id)
    {:ok, _} = Questions.delete_question(question)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:question_created, question}, socket) do
    appended_question_list = List.insert_at(socket.assigns.questions, -1, question)
    {:noreply, assign(socket, :questions, appended_question_list)}
  end

  @impl true
  def handle_info({:question_updated, updated_question}, socket) do
    updated_question_list =
      List.foldr(socket.assigns.questions, [], fn question, acc ->
        if question.id == updated_question.id do
          [updated_question | acc]
        else
          [question | acc]
        end
      end)

    updated_socket = assign(socket, :questions, updated_question_list)
    {:noreply, push_event(updated_socket, "highlight", %{id: updated_question.id})}
  end

  @impl true
  def handle_info({:question_deleted, question}, socket) do
    question_deleted(question, socket)
  end

  defp list_questions do
    Questions.list_questions()
  end

  defp question_deleted(question, socket) do
    filtered_questions = Enum.filter(socket.assigns.questions, &(&1.id != question.id))
    {:noreply, assign(socket, :questions, filtered_questions)}
  end
end
