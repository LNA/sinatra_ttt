$(function() {
  if ( i'm the board) {
    setTimeout(updateBoard, 1000);
  }
 });

function updateBoard () {
  $.getScript("/board".js);
  setTimeout(updateBoard, 1000);
}
