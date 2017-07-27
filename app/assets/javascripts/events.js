$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();

	$('#calendar').fullCalendar({
		header: {
			left: 'prevYear,prev,next,nextYear today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay,listYear,listMonth'
		},
		buttonText: {
	    today:    	'dziś',
	    month:    	'miesiąc',
	    week:     	'tydzień',
	    day:      	'dzień',
	    list:     	'lista-dzień',
	    listYear: 	'lista-rok',
	    listMonth: 	'lista-miesiąc'
		},
		locale: 'pl',
		timezone: 'local',
		allDayText: 'Cały dzień',
		weekHeader: 'Tydz',
		dateFormat: 'dd.mm.yy',
		monthNames: ['Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'],
		monthNamesShort: ['Sty', 'Lu', 'Mar', 'Kw', 'Maj', 'Cze', 'Lip', 'Sie', 'Wrz', 'Pa', 'Lis', 'Gru'],
		dayNames: ["Niedziela","Poniedziałek","Wtorek","Środa","Czwartek","Piątek","Sobota"],
		dayNamesShort: ["Nie","Pn","Wt","Śr","Czw","Pt","So"],
		dayNamesMin: ["N","Pn","Wt","Śr","Cz","Pt","So"],
		firstDay: 1,
		editable: false,
		timeFormat: 'HH:mm',
		axisFormat: 'HH:mm',
		slotLabelFormat: 'HH:mm', 
		timezone: "local",
	    events: {
			  url: '/events.json',
			  type: 'GET',
			  error: function() {
			      alert('there was an error while fetching events!');
			  },
			  //textColor: 'white'
		}

	});
});
