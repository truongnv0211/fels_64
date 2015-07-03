var do_lesson_function = function(){
  var sum;
  $(this).find("input").prop("checked", true);
  $(".answer_counting").html("1/20");
  sum = 0;
  return $(".answer-selected").click(function(){
    sum += 1;
    if (sum <= 20) {
      $(".answer_counting").html(sum + "/" + 20);
      $(this).find("input").prop("checked", true);
      $(this).parent().parent().hide().next().next().show();
      if (sum === 20){
        $(".submit-answer").removeClass("hidden");
      }
    }
    return false;
  });
};
$(document).on("click", ".answer-selected", do_lesson_function);

