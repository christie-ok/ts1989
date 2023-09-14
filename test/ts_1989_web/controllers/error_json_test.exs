defmodule Ts1989Web.ErrorJSONTest do
  use Ts1989Web.ConnCase, async: true

  test "renders 404" do
    assert Ts1989Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Ts1989Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
