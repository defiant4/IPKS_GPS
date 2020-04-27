 var calendarWindow = null;
            var calendarColors = new Array();
            calendarColors['bgColor'] = '#BDC5D0';
            calendarColors['borderColor'] = '#333366';
            calendarColors['headerBgColor'] = '#143464';
            calendarColors['headerColor'] = '#FFFFFF';
            calendarColors['dateBgColor'] = '#8493A8';
            calendarColors['dateColor'] = '#004080';
            calendarColors['dateHoverBgColor'] = '#FFFFFF';
            calendarColors['dateHoverColor'] = '#8493A8';
            var calendarMonths = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
            var calendarWeekdays = new Array('S', 'M', 'T', 'W', 'T', 'F', 'S', 'S');
            var calendarUseToday = true;
            var calendarFormat = 'y/m/d';
            var calendarStartMonday = true;
            var calendarScreenX = 100; // either 'auto' or numeric
            var calendarScreenY = 100; // either 'auto' or numeric
             function getCalendar(in_dateField)
            {
                if (calendarWindow && !calendarWindow.closed) {
                    alert('Calendar window already open.  Attempting focus...');
                    try {
                        calendarWindow.focus();
                    }
                    catch(e) {}

                    return false;
                }

                //var cal_width = 415;
                //var cal_height = 310;

                var cal_width = 230;
                var cal_height = 180;

                // IE needs less space to make this thing
                if ((document.all) && (navigator.userAgent.indexOf("Konqueror") == -1)) {
                    //cal_width = 410;
                    var cal_width = 230;
                }

                calendarTarget = in_dateField;
                calendarWindow = window.open('/PacsApplication/calendar.html', 'dateSelectorPopup','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=0,dependent=no,width='+cal_width+',height='+cal_height + (calendarScreenX != 'auto' ? ',screenX=' + calendarScreenX : '') + (calendarScreenY != 'auto' ? ',screenY=' + calendarScreenY : ''));

                return false;
            }