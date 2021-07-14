//インストールしたファイルたちを呼び出します。
import { Calendar} from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid'
import googleCalendarApi from '@fullcalendar/google-calendar'

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作っていきます。
document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');

    //カレンダーの中身を設定(月表示とか、クリックアクション起こしたいとか、googleCalendar使うととか)
    var calendar = new Calendar(calendarEl, {
        plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi ],


        //細かな表示設定
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 1,
        headerToolbar: {
            start: '',
            center: 'title',
            end: 'today prev,next'
        },
        expandRows: true,
        stickyHeaderDates: true,
        buttonText: {
            today: '今日'
        },
        allDayText: '終日',
        height: "auto",
        events: '/reservations.json',

        dateClick: function(info){
            //クリックした日付の情報を取得
            const year  = info.date.getFullYear();
            const month = (info.date.getMonth() + 1);
            const day   = info.date.getDate();

            //ajaxでevents/newを着火させ、htmlを受け取ります
            $.ajax({
                type: 'GET',
                url:  '/reservations/new',
            }).done(function (res) {
                // 成功処理
                // 受け取ったhtmlをさっき追加したmodalのbodyの中に挿入します
                $('.modal-body').html(res);

                //フォームの年、月、日を自動入力
                $('#event_start_1i').val(year);
                $('#event_start_2i').val(month);
                $('#event_start_3i').val(day);

                $('#event_end_1i').val(year);
                $('#event_end_2i').val(month);
                $('#event_end_3i').val(day);

                //ここのidはevents/newのurlにアクセスするとhtmlがコードとして表示されるので、
                //開始時間と終了時間のフォームを表しているところのidを確認してもらうことが確実です

                $('#create-modal').fadeIn();

            }).fail(function (result) {
                // 失敗処理
                alert("failed");
            });
        },
        eventClick: function(info){
            //表示されたイベントをクリックしたときのイベント(詳しくは次回の記事へ)
        },
        eventClassNames: function(arg){
            //表示されたイベントにclassをcss用に追加する(詳しくは次回の記事へ)
        }

    });
    //カレンダー表示
    calendar.render();

    //成功、失敗modalを閉じたときに予定を再更新してくれます
    //これがないと追加しても自動更新されません
    $(".error").on("click", function(){
        calendar.refetchEvents();
    });

});