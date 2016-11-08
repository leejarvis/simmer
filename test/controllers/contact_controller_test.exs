defmodule Simmer.ContactControllerTest do
  use Simmer.ConnCase

  alias Simmer.Contact

  @email "lee@jarvo.io"

  @params %{
    "email"      => @email,
    "first_name" => "Lee",
    "last_name"  => "Jarvis",
  }

  test "GET /contacts", %{project: project, conn: conn} do
    empty_conn = get(conn, contact_path(conn, :index))
    assert json_response(empty_conn, 200) == %{"contacts" => []}

    Fixtures.create(project, :contact)
    conn = get(conn, contact_path(conn, :index))
    %{"contacts" => contacts} = json_response(conn, 200)
    assert Enum.count(contacts) == 1
  end

  describe "POST /contacts" do
    test "valid payload", %{conn: conn} do
      conn = post(conn, contact_path(conn, :create, %{"contact" => @params }))

      assert json_response(conn, :created)
      assert get_resp_header(conn, "location") == [contact_path(conn, :show, @email)]
    end

    test "invalid payload", %{conn: conn} do
      conn = post(conn, contact_path(conn, :create, %{"contact" => %{"first_name" => "Lee"}}))

      assert json_response(conn, :unprocessable_entity) == %{
        "errors" => %{"email" => ["can't be blank"]}
      }
    end
  end

  test "GET /contacts/:email", %{project: project, conn: conn} do
    contact  = Fixtures.create(project, :contact)
    conn     = get(conn, contact_path(conn, :show, contact))

    assert json_response(conn, 200)["contact"]
  end

  test "PATCH /contacts/:email", %{project: project, conn: conn} do
    contact = Fixtures.create(project, :contact)
    conn    = patch(conn, contact_path(conn, :update, contact), %{"contact" => %{"first_name" => "John"}})

    assert json_response(conn, 200)["contact"]["first_name"] == "John"
    assert "John" == Repo.get!(Contact, contact.id).first_name
  end

  test "DELETE /contacts/:email", %{project: project, conn: conn} do
    contact = Fixtures.create(project, :contact)
    conn    = delete(conn, contact_path(conn, :delete, contact.email))

    assert response(conn, :no_content)
    assert nil == Repo.get(Contact, contact.id)
  end
end
