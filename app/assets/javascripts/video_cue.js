function onYouTubePlayerReady(playerId) {

    ytplayer = document.getElementById("artist-playlist-yt-player");

    ytplayer.cuePlaylist(artistVideoIDs);

    ytplayer.playVideo();

    console.log(artistVideoIDs);
    
}