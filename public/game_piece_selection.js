$(function() {
  $('#player_one_mark').on ('change', function(event){
    var $this = $(this);
    if (($this).val() == "X") {
      $('#player_two_mark').val("O");
    }
    else{
      $('#player_two_mark').val("X");
    }
  });
});

$(function() {
  $('#player_two_mark').on ('change', function(event){
    var $this = $(this);
    if (($this).val() == "X") {
      $('#player_one_mark').val("O");
    }
    else{
      $('#player_one_mark').val("X");
    }
  });
});
