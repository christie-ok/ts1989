defmodule Ts1989Web.WhichAlbumLive do
  use Ts1989Web, :live_view

  alias Phoenix.PubSub

  @topic "increment_tally"

  @test %{
    movie: "san_andreas",
    name: "Christie",
    question: :finish,
    worst: "harry_styles"
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, question: 0, test_assigns: @test)}
  end

  def render(assigns) do
    IO.inspect(assigns)

    ~H"""
    <%= question(assigns) %>
    """
  end

  defp question(%{question: 0} = assigns) do
    ~H"""
    <p class="flex justify-center font-bold">&#11015 click on Taylor to start &#11015</p>
    <div phx-click="go_to_question_1" class="cursor-pointer">
      <img src="https://deadline.com/wp-content/uploads/2023/01/Screen-Shot-2023-01-24-at-12.02.27-AM.png" />
    </div>
    """
  end

  defp question(%{question: 1} = assigns) do
    ~H"""
    Question 1:
    "[But I've got blank space, baby
    And I'll] write your name":
    <.form for={:person} phx-submit="go_to_question_2">
      <input type="text" name={:name} />

      <.submit_button button_text="Next" />
    </.form>
    """
  end

  defp question(%{question: 2} = assigns) do
    ~H"""
    Question 2: What Dwayne "The Rock" Johnson is best?
    <.form for={:rock} phx-submit="go_to_question_3">
      <div class="flex space-x-4">
        <div>
          <input type="radio" name={:rock} value="super_pets" /> Animated
          <img
            src="https://m.media-amazon.com/images/I/81iRixbg8kL._SL1500_.jpg"
            style="width:200px;height:300px;"
          />
        </div>
        <div>
          <input type="radio" name={:rock} value="ballers" /> Smooth
          <img
            src="https://i.ebayimg.com/images/g/iAsAAOSwr~tb6H-s/s-l1600.jpg"
            style="width:200px;height:300px;"
          />
        </div>
        <div>
          <input type="radio" name={:rock} value="san_andreas" /> Jacked
          <img src="https://movieposters2.com/images/1301791-b.jpg" style="width:200px;height:300px;" />
        </div>
      </div>
      <div class="mt-2"><.submit_button button_text="Next" /></div>
    </.form>
    """
  end

  defp question(%{question: 3} = assigns) do
    ~H"""
    Question 3: Who is the worst?
    <.form for={:worst} phx-submit="go_to_question_4">
      <div class="flex space-x-4">
        <div>
          <input type="radio" name={:worst} value="katy_perry" /> Katy Perry
          <img
            src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeS6UkJc5-yibdsICv6l-O3-QpGiWuN3DOrA&usqp=CAU"
            style="width:200px;height:300px;"
          />
        </div>
        <div>
          <input type="radio" name={:worst} value="nicki_minaj" /> Nicki Minaj
          <img
            src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Nicki_Minaj_MTV_VMAs_4.jpg/640px-Nicki_Minaj_MTV_VMAs_4.jpg"
            style="width:200px;height:300px;"
          />
        </div>
        <div>
          <input type="radio" name={:worst} value="harry_styles" /> Harry Styles
          <img
            src="https://ntvb.tmsimg.com/assets/assets/878203_v9_bc.jpg"
            style="width:200px;height:300px;"
          />
        </div>
      </div>
      <div class="mt-2"><.submit_button button_text="Next" /></div>
    </.form>
    """
  end

  defp question(%{question: 4} = assigns) do
    ~H"""
    QUESTION 4
    <.form for={:q4} phx-submit="go_to_question_5">
      <div class="mt-2"><.submit_button button_text="Next" /></div>
    </.form>
    """
  end

  defp question(%{question: 5} = assigns) do
    ~H"""
    QUESTION 5
    <.form for={:q5} phx-submit="finish">
      <div class="mt-2"><.submit_button button_text="Finish" /></div>
    </.form>
    """
  end

  defp question(%{question: :finish} = assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="text-3xl text-violet-500 justify-center">
        <%= @name %>, Taylor's best album for you is "1989"!!
      </div>
      <div class="flex space-x-2 justify-center mt-2">
        <img src="https://upload.wikimedia.org/wikipedia/en/f/f6/Taylor_Swift_-_1989.png" />
        <img src="https://upload.wikimedia.org/wikipedia/en/f/f6/Taylor_Swift_-_1989.png" />
        <img src="https://upload.wikimedia.org/wikipedia/en/f/f6/Taylor_Swift_-_1989.png" />
      </div>
    </div>

    <div class="flex space-x-2">
    <.answer title="Movie/Show" img_url={img_url(@movie)} explanation={explanation(@movie)} />
    <.answer title="Most Hated" img_url={img_url(@worst)} explanation={explanation(@worst)} />
    <.answer title="QUESTION 3" img_url={img_url(@worst)} explanation={explanation(:tbd)} />
    <.answer title="QUESTION 4" img_url={img_url(@worst)} explanation={explanation(:tbd)} />
    </div>

    """
  end

  defp submit_button(assigns) do
    ~H"""
    <button type="submit" class="p-2 border bg-pink-400 font-bold"><%= @button_text %></button>
    """
  end

  defp answer(assigns) do
    ~H"""
    <div class="w-1/3 mt-2">
      <div class="flex text-xl justify-center"><%= @title %></div>
      <img src={@img_url} />
      <div><%= @explanation %></div>
    </div>
    """
  end

  @impl true
  def handle_event("go_to_question_1", _params, socket) do
    {:noreply, assign(socket, question: 1)}
  end

  def handle_event("go_to_question_2", params, socket) do
    {:noreply, assign(socket, question: 2, name: params["name"])}
  end

  def handle_event("go_to_question_3", params, socket) do
    {:noreply, assign(socket, question: 3, movie: params["rock"])}
  end

  def handle_event("go_to_question_4", params, socket) do
    {:noreply, assign(socket, question: 4, worst: params["worst"])}
  end

  def handle_event("go_to_question_5", params, socket) do
    {:noreply, assign(socket, question: 5, snack: params["snack"]["snack"])}
  end

  def handle_event("finish", _params, socket) do
    PubSub.broadcast(Ts1989.PubSub, @topic, {:add_one, socket.assigns.name})
    {:noreply, assign(socket, question: :finish)}
  end

  defp img_url("san_andreas"), do: "https://m.media-amazon.com/images/M/MV5BZTliMTIxMTUtYjBkOC00ODJkLTgwZDMtZTVmZTVhYmJmYTJiXkEyXkFqcGdeQXVyMjQ2MTk1OTE@._V1_.jpg"
  defp img_url("ballers"), do: "https://www.pluggedin.com/wp-content/uploads/2020/01/shake-it-off-taylor-swift-review-image-1200x688.jpg"
  defp img_url("super_pets"), do: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/05/18/19/bad_blood1.jpg?width=1200"
  defp img_url("katy_perry"), do: "https://upload.wikimedia.org/wikipedia/en/9/9b/Taylor_Swift_Feat._Kendrick_Lamar_-_Bad_Blood_%28Official_Single_Cover%29.png"
  defp img_url("nicki_minaj"), do: "https://upload.wikimedia.org/wikipedia/en/9/9b/Taylor_Swift_Feat._Kendrick_Lamar_-_Bad_Blood_%28Official_Single_Cover%29.png"
  defp img_url("harry_styles"), do: "https://assets.teenvogue.com/photos/568bf51be4e50e9d5e672c3c/16:9/w_2560%2Cc_limit/swift-suffered.jpg"

  defp explanation("san_andreas"), do: "You chose the super ripped Dwayne Johnson in San Andreas. 'Style' from 1989 was featured in the movie!"
  defp explanation("ballers"), do: " You chose the smooth and stylish Spencer Strassmore Dwayne Johnson from Ballers. 'Shake It Off' from 1989 was featured in the show!"
  defp explanation("super_pets"), do: "You chose the adorable and loyal Krypto Dwayne Johnson from DC League of Super Pets. 'Bad Blood' from 1989 was featured in the movie!"
  defp explanation("katy_perry"), do: "You chose one of Taylor's longest running feuds: Katy Perry. It's pretty much common knowledge that 'Bad Blood' (on 1989) was written about Katy."
  defp explanation("nicki_minaj"), do: "You chose one of Taylor's most epic Twitter wars: Nicki Minaj. After 'Bad Blood' (on 1989) got nominations over Nicki's work, there's been nothing but Bad Blood."
  defp explanation("harry_styles"), do: "You chose one of Taylor's most infamous exes: Harry Styles. It is hypothesized that 'Out Of The Woods' and 'All You Had to Do Was Stay' (both on 1989) are about Harry."
  defp explanation(_), do: "TBD TBD TBD TBD TBD TBD TBD TBD TBD TBD TBD v"
end
