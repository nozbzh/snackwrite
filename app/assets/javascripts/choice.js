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
          $("[class^=bubble]").width($(window).width()/4.5);
          $("[class^=bubble]").height($('[class^=bubble]').width());
          
          $winHeight = Math.max($(window).height(), 400);
          $('.bubble-push').css('top', ($winHeight*0.35)+'px');
          $('.bubble-shadow').css('top', ($winHeight*0.37)+'px');
      
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