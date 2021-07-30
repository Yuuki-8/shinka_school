//インストールしたファイルたちを呼び出します。
import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid';
import googleCalendarApi from '@fullcalendar/google-calendar';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作っていきます。
document.addEventListener('turbolinks:load', function () {
    var calendarEl = document.getElementById('calendar');

    var calendar = new Calendar(calendarEl, {
        plugins: [ timeGridPlugin, monthGridPlugin, interactionPlugin, googleCalendarApi, listPlugin ],
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 1,
        headerToolbar: {
            left: "dayGridMonth timeGridWeek timeGridDay listMonth",
            start: '',
            center: 'title',
            right: 'today prev,next'
        },
        initialView: 'timeGridWeek',
        expandRows: true,
        stickyHeaderDates: true,
        buttonText: {
            today: '今日',
            month: '月',
            list: 'リスト',
            week: '週',
            day: '日'
        },
        views: {
            dayGridMonth: {
                titleFormat: { year: 'numeric', month: 'numeric' },
            },
            listMonth: {
                titleFormat: { year: 'numeric', month: 'numeric' },
                listDayFormat: { month: 'numeric', day: 'numeric', weekday: 'narrow' },
                listDaySideFormat: false
            }
        },
        allDayText: '終日',
        height: "auto",
        events: '/calendars.json',
        customButtons: {
            nextWithScroll: {
                icon : 'fa-chevron-right',
                click: function(e) {
                    calendar.next();
                    $(window).scrollTop(calendarEl_posT);
                }
            },
            prevWithScroll: {
                icon : 'fa-chevron-left',
                click: function(e) {
                    calendar.prev();
                    $(window).scrollTop(calendarEl_posT);
                }
            }
        },
        footerToolbar: {
            right: "prev,next"
        },
        navLinks: true, // can click day/week names to navigate views
        businessHours: {
            startTime: '09:00',
            endTime: '21:00'
        },
        editable: true,
        selectable: true,
        dateClick: function(info){
            //クリックした日付の情報を取得
            const year  = info.date.getFullYear();
            const month = (info.date.getMonth() + 1);
            const day = info.date.getDate();
            const startHour = (( '00' + (info.date.getHours() - 9)).slice( -2 ));
            const endHour = (( '00' + (info.date.getHours() - 8)).slice( -2 ));
            const min = ( '00' + info.date.getMinutes()).slice( -2 );

            //ajaxでevents/newを着火させ、htmlを受け取ります
            $.ajax({
                type: 'GET',
                url:  '/calendars/new',
            }).done(function (res) {
                // 成功処理
                // 受け取ったhtmlをさっき追加したmodalのbodyの中に挿入します
                $('.modal-body').html(res);

                //フォームの年、月、日を自動入力
                $('#calendar_start_date_1i').val(year);
                $('#calendar_start_date_2i').val(month);
                $('#calendar_start_date_3i').val(day);
                $('#calendar_start_date_4i').val(startHour);
                $('#calendar_start_date_5i').val(min);

                $('#calendar_end_date_1i').val(year);
                $('#calendar_end_date_2i').val(month);
                $('#calendar_end_date_3i').val(day);
                $('#calendar_end_date_4i').val(endHour);
                $('#calendar_end_date_5i').val(min);

                //ここのidはevents/newのurlにアクセスするとhtmlがコードとして表示されるので、
                //開始時間と終了時間のフォームを表しているところのidを確認してもらうことが確実です

                $('#create-modal').fadeIn();

            }).fail(function (result) {
                // 失敗処理
                alert("failed");
            });
        },
        eventClick: function(info){
            const instanceId = info.event._def.publicId
            const className = info.event.extendedProps.class_name
            $.ajax({
                type: 'GET',
                url: `/calendars/${instanceId}`,
                data: { class_name: className},
            }).done(function (res) {
                $('.modal-body').html(res);
                $('#edit-modal').fadeIn();
            }).fail(function (result) {
                // 失敗処理
                alert("failed");
            });
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