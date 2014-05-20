$(function() {
  setTimeout(updateBoard, 1000);
 });

function updateBoard () {
  $.getScript("/test_board.js");
  setTimeout(updateBoard, 1000);
}
