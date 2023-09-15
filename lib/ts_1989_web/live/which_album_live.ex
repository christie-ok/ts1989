defmodule Ts1989Web.WhichAlbumLive do
  use Ts1989Web, :live_view

  alias Phoenix.PubSub

  @topic "increment_tally"

  @test %{
    movie: "super_pets",
    name: "Christie",
    question: :finish,
    worst: "katy_perry",
    genre: "country",
    version: "original",
    style: "ballad"
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, question: 0, test_assigns: @test)}
  end

  def render(assigns) do
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
    Question 4: Do you like the origial albums or Taylor's versions better?
    <.form for={:version} phx-submit="go_to_question_5">
      <div class="flex space-x-4">
        <div>
          <input type="radio" name={:version} value="original" /> Originals
          <img
            src="https://upload.wikimedia.org/wikipedia/en/e/e8/Taylor_Swift_-_Red.png"
            style="width:200px;height:200px;"
          />
        </div>
        <div>
          <input type="radio" name={:version} value="taylors" /> Taylor's Version
          <img
            src="https://magicvinyldigital.files.wordpress.com/2021/12/tsred_vinyl01.jpg?w=1000"
            style="width:200px;height:200px;"
          />
        </div>
      </div>
      <div class="mt-2"><.submit_button button_text="Next" /></div>
    </.form>
    """
  end

  defp question(%{question: 5} = assigns) do
    ~H"""
    Question 5: Do you love Taylor's pop hits, or are you nostalgic for her country roots?
    <.form for={:genre} phx-submit="go_to_question_6">
    <div class="flex space-x-4">
    <div>
      <input type="radio" name={:genre} value="pop" /> Pop
      <img
        src="https://www.hollywoodreporter.com/wp-content/uploads/2014/08/taylor_swift_video.jpg?w=3000"
        style="width:300px;height:200px;"
      />
    </div>
    <div>
      <input type="radio" name={:genre} value="country" /> Country
      <img
        src="https://images.radio.com/aiu-media/tswift-51d5f61e-1105-457a-a273-91d59beef251.jpg"
        style="width:300px;height:200px;"
      />
    </div>
  </div>
  <div class="mt-2"><.submit_button button_text="Next" /></div>
    </.form>
    """
  end

  defp question(%{question: 6} = assigns) do
    ~H"""
    Question 6: Do you love Taylor's lyrical ballads or her poppy dance beats?
    <.form for={:style} phx-submit="finish">
    <div class="flex space-x-4">
    <div>
      <input type="radio" name={:style} value="dance" /> Dance
      <img
        src="https://consequence.net/wp-content/uploads/2022/12/Taylor-Swift-lawsuit-dropped.jpg?quality=80&w=1031&h=580&crop=1&resize=1031%2C580&strip"
        style="width:300px;height:200px;"
      />
    </div>
    <div>
      <input type="radio" name={:style} value="ballad" /> Ballads
      <img
        src="https://cdn.theatlantic.com/thumbor/0O3tQcRaUPXo0lVGE5XISmzrvSQ=/267x0:1600x700/960x504/media/img/mt/2015/09/image_30-1/original.jpg"
        style="width:300px;height:200px;"
      />
    </div>
  </div>
  <div class="mt-2"><.submit_button button_text="Next" /></div>
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

    <div class="flex space-x-5">
      <.answer title="Movie/Show" img_url={img_url(@movie)} explanation={explanation(@movie)} />
      <.answer title="Most Hated" img_url={img_url(@worst)} explanation={explanation(@worst)} />
      <.answer title="Best Version" img_url={img_url(@version)} explanation={explanation(@version)} />
      <.answer title="Genre" img_url={img_url(@genre)} explanation={explanation(@genre)} />
      <.answer title="Style" img_url={img_url(@style)} explanation={explanation(@style)} />
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
      <img src={@img_url} style="width:400px;height:100px;" />
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
    {:noreply, assign(socket, question: 5, version: params["version"])}
  end

  def handle_event("go_to_question_6", params, socket) do
    {:noreply, assign(socket, question: 6, genre: params["genre"])}
  end

  def handle_event("finish", params, socket) do
    PubSub.broadcast(Ts1989.PubSub, @topic, {:add_one, socket.assigns.name})
    {:noreply, assign(socket, question: :finish, style: params["style"])}
  end

  defp img_url("dance"),
    do: "https://media.vanityfair.com/photos/544f9d76ddfb5c8644a0aae8/1:1/w_689,h_460,c_limit/taylor-swift-1989.jpg"

    defp img_url("ballad"), do: "https://pbs.twimg.com/media/E_fW-PVXsAAuSTk.jpg:large"

  defp img_url("pop"),
    do:
      "https://www.indystar.com/gcdn/-mm-/c3adb76d33eb24e53bfb4683581e22edafd19d7b/c=0-0-5177-2925/local/-/media/2015/09/17/Indianapolis/Indianapolis/635780663788302274-04TSWIFTVID.JPG?width=3200&height=1808&fit=crop&format=pjpg&auto=webp"

      defp img_url("country"),
    do:
      "https://www.soundslikenashville.com/wp-content/uploads/2015/07/Sam-Hunt-Taylor-Swift.jpg"

  defp img_url("taylors"),
    do:
      "https://upload.wikimedia.org/wikipedia/en/d/d5/Taylor_Swift_-_1989_%28Taylor%27s_Version%29.png"

      defp img_url("original"),
      do:
        "https://upload.wikimedia.org/wikipedia/en/thumb/f/f6/Taylor_Swift_-_1989.png/220px-Taylor_Swift_-_1989.png"

  defp img_url("san_andreas"),
    do:
      "https://m.media-amazon.com/images/M/MV5BZTliMTIxMTUtYjBkOC00ODJkLTgwZDMtZTVmZTVhYmJmYTJiXkEyXkFqcGdeQXVyMjQ2MTk1OTE@._V1_.jpg"

  defp img_url("ballers"),
    do:
      "https://www.pluggedin.com/wp-content/uploads/2020/01/shake-it-off-taylor-swift-review-image-1200x688.jpg"

  defp img_url("super_pets"),
    do:
      "https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/05/18/19/bad_blood1.jpg?width=1200"

  defp img_url("katy_perry"),
    do:
      "https://upload.wikimedia.org/wikipedia/en/9/9b/Taylor_Swift_Feat._Kendrick_Lamar_-_Bad_Blood_%28Official_Single_Cover%29.png"

  defp img_url("nicki_minaj"),
    do:
      "https://upload.wikimedia.org/wikipedia/en/9/9b/Taylor_Swift_Feat._Kendrick_Lamar_-_Bad_Blood_%28Official_Single_Cover%29.png"

  defp img_url("harry_styles"),
    do:
      "https://assets.teenvogue.com/photos/568bf51be4e50e9d5e672c3c/16:9/w_2560%2Cc_limit/swift-suffered.jpg"

      defp explanation("dance"),
    do: "You chose Taylor's dance music - you won't find better than 1989 dance tracks!"

    defp explanation("ballad"),
    do: "You love Taylor's ballads. 'Wildest Dreams' (1989) - need I say more?"

      defp explanation("pop"),
    do:
      "1989 has some of Taylor's most epic pop hits! 'Shake It Off', 'Bad Blood', and 'Welcome to New York' just to name a few!"

      defp explanation("country"),
    do:
      "Even though 1989's vibe is more pop than county, during the 1989 tour, Taylor sang with Sam Hunt in Chicago, going back to her country roots."

      defp explanation("original"),
    do:
      "You love Taylor's original albums. 1989 is an original classic!"

      defp explanation("taylors"),
    do:
      "You love Taylor's versions of her albums. Lucky for you 1989 (Taylor's Version) comes out October 27, 2023!"

  defp explanation("san_andreas"),
    do:
      "You chose the super ripped Dwayne Johnson in San Andreas. 'Style' from 1989 was featured in the movie!"

  defp explanation("ballers"),
    do:
      " You chose the smooth and stylish Spencer Strassmore Dwayne Johnson from Ballers. 'Shake It Off' from 1989 was featured in the show!"

  defp explanation("super_pets"),
    do:
      "You chose the adorable and loyal Krypto Dwayne Johnson from DC League of Super Pets. 'Bad Blood' from 1989 was featured in the movie!"

  defp explanation("katy_perry"),
    do:
      "You chose one of Taylor's longest running feuds: Katy Perry. It's pretty much common knowledge that 'Bad Blood' (on 1989) was written about Katy."

  defp explanation("nicki_minaj"),
    do:
      "You chose one of Taylor's most epic Twitter wars: Nicki Minaj. After 'Bad Blood' (on 1989) got nominations over Nicki's work, there's been nothing but Bad Blood."

  defp explanation("harry_styles"),
    do:
      "You chose one of Taylor's most infamous exes: Harry Styles. It is hypothesized that 'Out Of The Woods' and 'All You Had to Do Was Stay' (both on 1989) are about Harry."

  defp explanation(_), do: "TBD TBD TBD TBD TBD TBD TBD TBD TBD TBD TBD"
end
