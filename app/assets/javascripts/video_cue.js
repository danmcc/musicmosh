function cuePlaylist(event) {

  event.target.cuePlaylist(artistVideoIDs);

  event.target.addEventListener("onStateChange", "nextArtist");

}

function nextArtist(event) {

  //If the playlist has ended, redirect to the next artist
  if (event.data == 0) {
    document.location.href = document.getElementById("next-show-link").getAttribute('href', 2);
  }

  //When the video is cued and loaded, start playing
  if (event.data == 5) {
    event.target.playVideo();
  }

}