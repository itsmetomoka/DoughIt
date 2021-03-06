// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .
//= require moment
//= require moment/ja.js
//= require tempusdominus-bootstrap-4.js
//= require jquery.raty.js

// ハンバーガーメニュー
$(function() {
  $('.hamburger').on('click',function() {
      $(this).toggleClass('active');
      if ($(this).hasClass('active')) {
          $('.globalMenuSp').addClass('active');
      } else {
          $('.globalMenuSp').removeClass('active');
      }
  });
});

// 画像アップロード
$(function() {
  function readURL(input) {
      if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
  $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
  }
  $("#lesson_img").change(function(){
      readURL(this);
  });
});

$(function () {
  $('#star').raty({　　　
    size: 36,
    starOff: "/assets/star-off.png",
    starOn: "/assets/star-on.png",
    scoreName: "score"
  });
});

  