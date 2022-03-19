defmodule TestingLiveViewWallabyWeb.QuestionLive.FormComponent do
  use TestingLiveViewWallabyWeb, :live_component

  alias TestingLiveViewWallaby.Questions

  @impl true
  def update(%{question: question} = assigns, socket) do
    changeset = Questions.change_question(question)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"question" => question_params}, socket) do
    changeset =
      socket.assigns.question
      |> Questions.change_question(question_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"question" => question_params}, socket) do
    save_question(socket, socket.assigns.action, question_params)
  end

  defp save_question(socket, :edit, question_params) do
    case Questions.update_question(socket.assigns.question, question_params) do
      {:ok, _question} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_question(socket, :new, question_params) do
    case Questions.create_question(question_params) do
      {:ok, _question} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
