window.addEventListener("message", function (event) {
    if (event.data) {
        console.log(event.data)
        var audio = new Audio('ring.mp3');
        audio.volume = 0.10;
        audio.play();
    }
})