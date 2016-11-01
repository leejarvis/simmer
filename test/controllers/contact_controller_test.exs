defmodule Simmer.ContactControllerTest do
  use Simmer.ConnCase

  @email "lee@jarvo.io"

  @params %{
    "contact" => %{
      "email"      => @email,
      "first_name" => "Lee",
      "last_name"  => "Jarvis",
    }
  }

  test "GET /contacts", %{conn: conn} do
    conn = get(conn, contact_path(conn, :index))
    assert json_response(conn, 200) == %{"contacts" => []}

    Fixtures.create(:contact)
    conn = get(conn, contact_path(conn, :index))
    %{"contacts" => contacts} = json_response(conn, 200)
    assert Enum.count(contacts) == 1
  end

  describe "POST /contacts" do
    test "valid payload", %{conn: conn} do
      conn = post(conn, contact_path(conn, :create, @params))

      assert json_response(conn, :created) == @params
      assert get_resp_header(conn, "location") == [contact_path(conn, :show, @email)]
    end

    test "invalid payload", %{conn: conn} do
      conn = post(build_conn(), contact_path(conn, :create, %{"contact" => %{"first_name" => "Lee"}}))

      assert json_response(conn, :unprocessable_entity) == %{
        "errors" => %{"email" => ["can't be blank"]}
      }
    end
  end

  test "DELETE /contacts/:email", %{conn: conn} do
    contact = Fixtures.create(:contact)
    conn    = delete(conn, contact_path(conn, :delete, contact.email))

    assert response(conn, :no_content)
  end
end
