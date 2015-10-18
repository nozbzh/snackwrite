 function loadXMLDoc()
{
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

}

$(document).ready(function() {
  $(window).resize(
    function(){
          $windowWidth = $(this).width();
          
          $("[class^=bubble]").width($(window).width()/4.5);
          $("[class^=bubble]").height($('[class^=bubble]').width());
          $bubbleWidth = $("[class^=bubble]").width();
          console.log($bubbleWidth);
          $('.bubble-push').css('top', ($(window).height()*0.35)+'px');
          $('.bubble-shadow').css('top', ($(window).height()*0.37)+'px');
          $(".choice").css('font-size',($(window).width()/17)+'px');
      }
  );

  $(window).resize();
  $(function ()
    {
      $('.bubble-push').mouseenter(function () {
          $(this).animate({top:'+=2%'}, 'fast');
      }).mouseleave(function ()
      {
          $(this).animate({top:'-=2%'}, 'fast');
      });
    });
});