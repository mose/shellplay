(function(){

  var current = 0;

  function draw() {
    $(".screen").hide();
    $("#s"+current).show();
  }

  function next() {
    current++;
    draw();
  }

  function previous() {
    console.log(current);
    if (current > 0) {
      current--;
    }
    draw();
  }

  draw();

  $(document).keydown(function(e) {
    switch(e.keyCode) {
      case 39: // ->
      case 78: // n
      case 13: // enter
        next();
        break;
      case 37: // <-
      case 80: // p
        previous();
        break;
      default:
        console.log(e.keyCode);
    }
  });

}());
