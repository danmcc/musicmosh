function onYouTubePlayerReady(playerId) {

    ytplayer = document.getElementById("artist-playlist-yt-player");

    ytplayer.cuePlaylist(artistVideoIDs);

    ytplayer.playVideo();

    ytplayer.addEventListener("onStateChange", "nextArtist");


}

function nextArtist(event) {
    
    //If the playlist has ended, redirect to the next artist
    if(event == 0)
    {
        document.location.href = document.getElementById("next-show-link").getAttribute('href', 2);
    }

}