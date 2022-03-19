defmodule TestingLiveViewWallabyWeb.Features.QuestionFeatureTest do
  use TestingLiveViewWallabyWeb.FeatureCase, async: true

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
end
