// Always test to check for a connection!
// console.log("Testing - JavaScript file has been linked correctly!");

// Find the 'count this' class on the page and animate it
$(window).on('turbolinks:load', function(){
  $(".count-up").each(function(){
      $(this).prop('Counter',0).animate({//0からカウントアップ
            Counter: $(this).text()
        }, {
        // スピードやアニメーションの設定
            duration: 2000,//数字が大きいほど変化のスピードが遅くなる。2000=2秒
            easing: 'swing',//動きの種類。他にもlinearなど設定可能
            step: function (now) {
                $(this).text(Math.ceil(now));
            }
        });
    });
});