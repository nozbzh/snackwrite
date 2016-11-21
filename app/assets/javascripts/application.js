//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.autosize
//= require choice
//= require_self

$(document).ready(function(){
  $('textarea').autosize();
});

$(document).ready(function(){
  $('.show-results-js').on('click', function(){
    $('.results').show();
  });
});
