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
        initialView: 'dayGridMonth',
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
        events: '/temporary_schedules.json',
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
        navLinks: true,
        businessHours: {
            startTime: '09:00',
            endTime: '21:00'
        },
        editable: true,
        selectable: true,
        eventSources: [
            {
                googleCalendarApiKey: 'AIzaSyDK9wkF7x-CO1NcyEKBM5O2PEkOkOetWjk',
                googleCalendarId: 'japanese__ja@holiday.calendar.google.com',
                display: 'background',
            },
        ],
        eventClick: function(info){
            const instanceId = info.event._def.publicId
            const className = info.event.extendedProps.class_name
            $.ajax({
                type: 'GET',
                url: `/temporary_schedules/${instanceId}`,
                data: { class_name: className},
            }).done(function (res) {
                $('.modal-body').html(res);
                $('#edit-modal').fadeIn();
            }).fail(function (result) {
                // 失敗処理
                alert("failed");
            });
        },
    });
    //カレンダー表示
    calendar.render();

    //成功、失敗modalを閉じたときに予定を再更新してくれます
    //これがないと追加しても自動更新されません
    $(".error").on("click", function(){
        calendar.refetchEvents();
    });

});