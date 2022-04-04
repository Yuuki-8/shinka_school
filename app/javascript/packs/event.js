document.addEventListener("turbolinks:load", function () {
  $(function () {
    $('.js-text_field_title').on('keyup', function () {
      var title = $.trim($(this).val());
      console.log(title);
      $.ajax({
        type: 'GET', // リクエストのタイプ
        url: '/events/search', // リクエストを送信するURL
        data:  { title: title}, // サーバーに送信するデータ
        dataType: 'json' // サーバーから返却される型
      }).done(function (data) {
        $('.js-events li').remove();
        // 以下のコードを追加する
        $(data).each(function(i,event) {
          $('.js-events').append(
            `<li class="event"><a href="/events/${event.id}">${event.title}</a></li>`
          );
        });
      })
    });
    $('.js-text_field_place').on('keyup', function () {
      var place = $.trim($(this).val());
      $.ajax({
        type: 'GET', // リクエストのタイプ
        url: '/events/search', // リクエストを送信するURL
        data:  { place: place}, // サーバーに送信するデータ
        dataType: 'json' // サーバーから返却される型
      }).done(function (data) {
        $('.js-events li').remove();
        // 以下のコードを追加する
        $(data).each(function(i,event) {
          $('.js-events').append(
            `<li class="event"><a href="/events/${event.id}">${event.place}</a></li>`
          );
        });
      })
    });
    $('.js-start_date_field').on('change', function () {
      var start_date = $.trim($(this).val());
      $.ajax({
        type: 'GET', // リクエストのタイプ
        url: '/events/search', // リクエストを送信するURL
        data:  { start_date: start_date}, // サーバーに送信するデータ
        dataType: 'json' // サーバーから返却される型
      }).done(function (data) {
        $('.js-events li').remove();
        // 以下のコードを追加する
        $(data).each(function(i,event) {
          $('.js-events').append(
            `<li class="event"><a href="/events/${event.id}">${event.start_date}</a></li>`
          );
        });
      })
    });
    $('.js-end_date_field').on('change', function () {
      var end_date = $.trim($(this).val());
      $.ajax({
        type: 'GET', // リクエストのタイプ
        url: '/events/search', // リクエストを送信するURL
        data:  { end_date: end_date}, // サーバーに送信するデータ
        dataType: 'json' // サーバーから返却される型
      }).done(function (data) {
        $('.js-events li').remove();
        // 以下のコードを追加する
        $(data).each(function(i,event) {
          $('.js-events').append(
            `<li class="event"><a href="/events/${event.id}">${event.end_date}</a></li>`
          );
        });
      })
    });
  });
});