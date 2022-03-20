defmodule TestingLiveViewWallabyWeb.Features.QuestionFeatureTest do
  use TestingLiveViewWallabyWeb.FeatureCase, async: true
  import TestingLiveViewWallaby.QuestionsFixtures

  setup [:create_question]

  describe "live index when creating a question" do
    feature "users should be able to submit the form and create a question", %{session: session} do
      question_text = "How do I test simple things with Wallaby?"

      session
      |> visit("/questions")
      |> click(link("New Question"))
      |> fill_in(text_field("Text"), with: question_text)
      |> click(button("Save"))
      |> assert_has(css(".alert", text: "Question created successfully"))
      |> assert_has(css("#questions > tr > td", text: question_text))
    end
  end

  describe "live index when updating a question" do
    # Note - the default generated LiveView doesn't update the index table,
    # but when you click edit, you see the edits.
    @sessions 2
    feature "should update a question for all users immediately", %{
      question: question,
      sessions: [session1, session2]
    } do
      new_text = "Have I fixed the bug?"

      session2
      |> visit("/questions")
      |> assert_has(css("#questions > tr > td", text: question.text))

      session1
      |> visit("/questions")
      |> click(link("Edit"))
      |> fill_in(text_field("Text"), with: new_text)
      |> click(button("Save"))

      assert_has(session2, css("#questions > tr > td", text: new_text))
    end
  end

  describe "live index when deleting a question" do
    feature "should prompt the user if they're sure via javascript before deletion", %{
      session: session,
      question: question
    } do
      confirmation_message =
        session
        |> visit("/questions")
        |> accept_confirm(fn session ->
          click(session, link("Delete"))
        end)

      assert confirmation_message == "Are you sure?"
      refute_has(session, css("#questions > tr > td", text: question.text))
    end
  end

  defp create_question(_) do
    question = question_fixture()
    %{question: question}
  end
end
