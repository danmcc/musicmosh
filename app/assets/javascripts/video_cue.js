function cuePlaylist(event) {

  event.target.cuePlaylist(artistVideoIDs);

  event.target.addEventListener("onStateChange", "nextArtist");

}

function nextArtist(event) {

  //If the playlist has ended, redirect to the next artist
  if (event.data == 0) {
    document.location.href = document.getElementById("next-show-link").getAttribute('href', 2);
  }

  //If the video has loaded and the user is not mobile
  //start playing
  if (event.data == 5 && !(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))) {
    console.log('melo');
    event.target.playVideo();
  }

}