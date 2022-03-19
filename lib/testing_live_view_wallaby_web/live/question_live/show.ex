defmodule TestingLiveViewWallabyWeb.QuestionLive.Show do
  use TestingLiveViewWallabyWeb, :live_view

  alias TestingLiveViewWallaby.Questions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:question, Questions.get_question!(id))}
  end

  defp page_title(:show), do: "Show Question"
  defp page_title(:edit), do: "Edit Question"
end
