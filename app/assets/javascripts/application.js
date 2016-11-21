//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.autosize
//= require choice
//= require_self

$(document).ready(function(){
  $('textarea').autosize();
});

$('body').on('click', '.show-results-js', function(){
  $('.results').show();
});
