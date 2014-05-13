$(function() {
  $('#player_one_piece').on ('change', function(event){
    var $this = $(this);
    if (($this).val() == "X") {
      $('#player_two_piece').val("O");
    }
    else{
      $('#player_two_piece').val("X");
    }
  });
});

$(function() {
  $('#player_two_piece').on ('change', function(event){
    var $this = $(this);
    if (($this).val() == "X") {
      $('#player_one_piece').val("O");
    }
    else{
      $('#player_one_piece').val("X");
    }
  });
});