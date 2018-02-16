var player,
    time_update_interval = 0;

var timeLike = [];
var timeDislike = [];

function onYouTubeIframeAPIReady() {
    player = new YT.Player('video-placeholder', {
        width: 600,
        height: 400,
        videoId: 'Xa0Q0J5tOP0',
        events: {
            onReady: initialize
        }
    });
}

function initialize(){
    
    // Update the controls on load
    updateTimerDisplay();

    // Clear any old interval.
    clearInterval(time_update_interval);

    document.getElementById('video_title').innerHTML = player.getVideoData().title;

}


// Helper Functions

function formatTime(time){
    time = Math.round(time);

    var minutes = Math.floor(time / 60),
        seconds = time - minutes * 60;

    seconds = seconds < 10 ? '0' + seconds : seconds;

    return minutes + ":" + seconds;
}


$('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
});

function download(filename) {
  var pom = document.createElement('a');
  pom.setAttribute('href', 'data:text/plain;charset=utf-8,' +

  encodeURIComponent(filename + "\n" + player.getVideoData().title + "\n" + player.isMuted() + "\n" + player.getDuration() + "\n" + timeLike + "\n" + timeDislike + "\n" ));
  pom.setAttribute('download', filename + ".txt");

  pom.style.display = 'none';
  document.body.appendChild(pom);

  pom.click();

  document.body.removeChild(pom);
}

var up_v = false;
var down_v = false;


$('.down').on('click', function(){
    $('.down').removeClass('selected');
    $(this).addClass('selected');
    $('.up').removeClass('selected');

    if (down_v == false) {
        up_v = false;
        down_v = true;
    	timeDislike.push(player.getCurrentTime());
    }
});

$('.up').on('click', function(){
    $('.up').removeClass('selected');
    $(this).addClass('selected');
    $('.down').removeClass('selected');

    if (up_v == false) {
        up_v = true;
        down_v = false;
    	timeLike.push(player.getCurrentTime());
    }
});

