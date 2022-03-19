defmodule TestingLiveViewWallabyWeb.Features.QuestionFeatureTest do
  use TestingLiveViewWallabyWeb.FeatureCase, async: true
  import TestingLiveViewWallaby.QuestionsFixtures

  setup [:create_question]

  describe "simple question form" do
    feature "that users can submit a question", %{session: session} do
      question = "How do I test simple things with Wallaby?"

      session
      |> visit("/questions")
      |> click(link("New Question"))
      |> fill_in(text_field("Text"), with: question)
      |> click(button("Save"))
      |> assert_has(css(".alert", text: "Question created successfully"))
      |> assert_has(css("#questions > tr > td", text: question))
    end
  end

  describe "live updating index" do
    # Note - the default generated LiveView doesn't update the index table,
    # but when you click edit, you see the edits.
    @sessions 2
    feature "that a user updating a question updates it for all users immediately", %{
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

  defp create_question(_) do
    question = question_fixture()
    %{question: question}
  end
end
