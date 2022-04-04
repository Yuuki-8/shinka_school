$(function () {
  $('.js-text_field').on('keyup', function () {
    var name = $.trim($(this).val());
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/clubs/search', // リクエストを送信するURL
      data:  { name: name }, // サーバーに送信するデータ
      dataType: 'json' // サーバーから返却される型
    }).done(function (data) {
      $('.js-clubs li').remove();
      // 以下のコードを追加する
      $(data).each(function(i,club) {
        $('.js-clubs').append(
          `<li class="club"><a href="/clubs/${club.id}">${club.name}</a></li>`
        );
      });
    })
  });
});