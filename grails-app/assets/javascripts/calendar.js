/*

	Updated Mar 2014
	- 
	
*/

var language = 'unknown';

var dictionaryFr = { today: 'Aujourd\'hui' , close : 'Fermer' , closeCalendar: 'Fermeture du calendrier' , disabled: 'désactivé' , nextMonth: 'Mois suivant ALT+N' , previousMonth: 'Mois précédent ALT+P' , nextYear: 'Année suivante ALT+Y' , previousYear: 'Année précédente ALT+L' };
var dictionaryEn = { today: 'Today', close : 'Close' , closeCalendar: 'Close Calendar' , disabled: 'disabled' , nextMonth: 'Next Month' , previousMonth: 'Previous Month' , nextYear: 'Next Year' , previousYear: 'Previous Year' };
var dictionary = dictionaryEn;

var titleAltAccessKeys = {nextMonth: 'ALT+N' , previousMonth: 'ALT+P' , nextYear: 'ALT+Y' , previousYear: 'ALT+L' }

var accessKeys = {prevMonth: 'accesskey="p"', nextMonth: 'accesskey="n"', prevYear: 'accesskey="l"', nextYear: 'accesskey="y"'};

var headerContents = '<div><div class="calendar-head"><div class="calendar-head-month"><a class="calendar-nav-previousmonth" title="Previous Month (XXX)" href="#" accesskeyplaceholder_prevmonth><img src="uos/_assets/images/calendar/nav-previousmonth.gif" alt="Previous Month (XXX)" /></a><span style="display:none;" class="calendar-nav-previousmonth-spacer"><img src="uos/_assets/images/calendar/nav-spacer.gif" alt="Previous Month (disabled)" /></span><span class="calendar-currentmonth">December</span><a class="calendar-nav-nextmonth" title="Next Month (January)" href="#" accesskeyplaceholder_nextmonth><img src="uos/_assets/images/calendar/nav-nextmonth.gif" alt="Next Month (XXX)" /></a><span style="display:none;" class="calendar-nav-nextmonth-spacer"><img src="uos/_assets/images/calendar/nav-spacer.gif" alt="Next Month (disabled)" /></span></div><div class="calendar-head-year"><a class="calendar-nav-previousyear" title="Previous Year (2008)" href="#" accesskeyplaceholder_prevyear><img src="uos/_assets/images/calendar/nav-previousyear.gif" alt="Previous Year (XXX)" /></a><span style="display:none;" class="calendar-nav-previousyear-spacer"><img src="uos/_assets/images/calendar/nav-spacer.gif" alt="Previous Year (disabled)" /></span><span class="calendar-currentyear">2009</span><a class="calendar-nav-nextyear" title="Next Year (2010)" href="#" accesskeyplaceholder_nextyear><img src="uos/_assets/images/calendar/nav-nextyear.gif" alt="Next Year (XXX)" /></a><span style="display:none;" class="calendar-nav-nextyear-spacer"><img src="uos/_assets/images/calendar/nav-spacer.gif" alt="Next Year (disabled)" /></span></div></div></div>';

var tableContentsEn = '<table summary="Select a date within this table to populate the form year, month and day." cellpadding="0" cellspacing="0"><tbody><tr class="cal-off-screen"><th colspan="7" class="calendar-currentmonth"></th></tr><tr class="cal-off-screen"><th colspan="7" class="calendar-currentyear"></th></tr><tr class="calendar-weekday-row cal-off-screen"><th id="daySu" class="calendar-weekday">Sunday</th><th id="dayMo" class="calendar-weekday">Monday</th><th id="dayTu" class="calendar-weekday">Tuesday</th><th id="dayWe" class="calendar-weekday ">Wednesday</th><th id="dayTh" class="calendar-weekday">Thursday</th><th id="dayFr" class="calendar-weekday">Friday</th><th id="daySa" class="calendar-weekday">Saturday</th></tr></tbody></table>';

var dayHeader = ["daySu", "dayMo", "dayTu", "dayWe", "dayTh", "dayFr", "daySa"];

var tableContentsFr = '<table cellpadding="0" cellspacing="0"><tbody><tr class="cal-off-screen"><th colspan="7" class="calendar-currentmonth"></th></tr><tr class="cal-off-screen"><th colspan="7" class="calendar-currentyear"></th></tr><tr class="calendar-weekday-row cal-off-screen"><th id="daySu" class="calendar-weekday">dimanche</th><th id="dayMo" class="calendar-weekday">lundi</th><th id="dayTu" class="calendar-weekday">mardi</th><th id="dayWe" class="calendar-weekday ">mercredi</th><th id="dayTh" class="calendar-weekday">jeudi</th><th id="dayFr" class="calendar-weekday">vendredi</th><th id="daySa" class="calendar-weekday">samedi</th></tr></tbody></table>';

var daysHeaderEn = '<table cellpadding="0" cellspacing="0"><tr><th class="calendar-weekday">Su</th><th class="calendar-weekday">Mo</th><th class="calendar-weekday">Tu</th><th class="calendar-weekday">We</th><th class="calendar-weekday">Th</th><th class="calendar-weekday">Fr</th><th class="calendar-weekday">Sa</th></tr></table>';

var daysHeaderFr = '<table cellspacing="0"><tbody><tr class="calendar-weekday-row"><th class="calendar-weekday calendar-sun" scope="col">di</th><th class="calendar-weekday" scope="col">lu</th><th class="calendar-weekday" scope="col">ma</th><th class="calendar-weekday" scope="col">me</th><th class="calendar-weekday" scope="col">je</th><th class="calendar-weekday" scope="col">ve</th><th class="calendar-weekday calendar-sat" scope="col">sa</th></tr></tbody></table>';

var tableContents = tableContentsEn;
var daysHeader = daysHeaderEn;

var monthNamesFr = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
var monthNamesEn = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

var dayNamesEn = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
var dayNamesFr = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];

var dayNames = dayNamesEn;

var startEndEN = {start: "Calendar start", end: "Calendar end"};
var startEndFR = {start: "•	Début du calendrier", end: "Fin du calendrier"};

var currDateEn = "Current Date";
var currDateFr = "Date courante";
var futDateEn = "Future Date";
var futDateFr = "Date future";

var startEnd = startEndEN;

var currDate = currDateEn;
var futDate = futDateEn;

//var startAccText = '<span class="cal-off-screen">Calendar start</span>';
//var endAccText = '<span class="cal-off-screen">Calendar end</span>';

var monthNames = monthNamesEn;

var popupCalendar;

function debug( v ){}

function setLanguage( lang )
{
	if(typeof lang === 'undefined')
		language = 'en';
	else
		language = lang.substr(0,2);
	
	if( language == 'fr' )
	{
		monthNames = monthNamesFr;
		tableContents = tableContentsFr;
		dictionary = dictionaryFr;
		startEnd = startEndFR;
		daysHeader = daysHeaderFr;
		dayNames = dayNamesFr;
		currDate = currDateFr;
		futDate = futDateFr;
	}
	else
	if( language == 'en' )
	{
		monthNames = monthNamesEn;
		tableContents = tableContentsEn;
		dictionary = dictionaryEn;
		startEnd = startEndEN;
		daysHeader = daysHeaderEn;
		dayNames = dayNamesEn;
		currDate = currDateEn;
		futDate = futDateEn;
	}
}

setLanguage( $('html').attr('lang') );

function createInlineCalendar( obj , options )
{        
	if( !options )options = {};	
	if( typeof( obj ) == "string" )
    	obj = document.getElementById( obj );
    if( !obj )
		return;

	var initial = (options['initial']? options['initial'] : new Date(Date()) );
	if( !(options['links']) ){ options['links'] = [] };
	

	$(obj).data( 'options' , options );
	$(obj).data( 'current-date' , initial );
	$(obj).data( 'selected-date' , options['selected']);
	
	__buildCalendarStructure( $(obj) );
	__populateCalendar( $(obj) , initial.getFullYear() , initial.getMonth() + 1 );
}

function createInlineDoubleCalendar( a, b , options )
{
	var first = {}, second = {};                                               
	if( !options ){ options = {}; };
	var initial = (options['initial']? options['initial'] : new Date(Date()) );
	for( option in options ){ second[option] = first[option] = options[option]};

	if( typeof( a ) == "string" )
    	a = document.getElementById( a );

	if( typeof( b ) == "string" )
	   	b = document.getElementById( b );


	first['links'] = [$(b)];
	second['links'] = [$(a)];
	
    first['disable-next'] = true;
	second['disable-previous'] = true;
	second['initial'] = new Date( initial.getFullYear() + (initial.getMonth() == 11? 1 : 0 ), initial.getMonth() + 1 %12  , initial.getDate() );
	
	createInlineCalendar( a , first );
	createInlineCalendar( b , second, 1 );
}
                                             
function createPopupDoubleCalendar( from, options )
{
	if( !options ){ option = {}; };
	
	options['double'] = true;
	createPopupCalendar( from, options );                                         
	
	return false;
}   

//starting function -> this is called to create the cal.
function createPopupCalendar( from, options )
{
	if( popupCalendar )
	{    
		dismissPopupCalendar( true );
		return false;
	}
	
	setLanguage(options['lang']);
			  
	if( typeof( from ) == "string" )
    	from = document.getElementById( from );
		
	if( !options )
		options = { from: from};
	else
		options['from'] = from; // store the from element so as to re-focus on dismiss

	if( !options['position'] ){ options['position'] = 'below-right';}
	if( !options['x'] ){options['x'] = 0;}
	if( !options['y'] ){options['y'] = 0;}	
	
	headerContents = headerContents.replace('accesskeyplaceholder_prevmonth', (options['enableAccessKeys'] ? accessKeys['prevMonth'] : ''));
	headerContents = headerContents.replace('accesskeyplaceholder_nextmonth', (options['enableAccessKeys'] ? accessKeys['nextMonth'] : ''));
	headerContents = headerContents.replace('accesskeyplaceholder_prevyear', (options['enableAccessKeys'] ? accessKeys['prevYear'] : ''));
	headerContents = headerContents.replace('accesskeyplaceholder_nextyear', (options['enableAccessKeys'] ? accessKeys['nextYear'] : ''));
	
	
	var overlay = $('<div class="calendar-overlay"><span class="off-screen">Calendar start</span></div>');
	popupCalendar = $('<div class="calendar-wrapper-popup"><div class="calendar-header"><div class="calendar-header-close"><a href="#" onclick="return dismissPopupCalendar();" class="linkedtextandicon"><span>' + dictionary['close'] + '</span> <img src="uos/_assets/images/icons/close.gif" width="16" height="16" alt="' + dictionary['closeCalendar'] + '"></a></div><div class="calendar-header-today"><a href="#" title="Today is December 10, 2009">Today</a> is December 10, 2009</div></div></div>');

	$(popupCalendar).data('from' , (!options['focus']? from : options['focus'] ));
	
	//overlay.click(function(){ dismissPopupCalendar(); });
	overlay.css('height' , $(window).height() );
	overlay.css('z-index', '9999');
	
	popupCalendar.css('z-index', '10000');
	
	//these were "body", if we declare a div id, we can put the code into that div...... -> will need to standardize this if we want to have it transferable.
	$("#calendar-container").prepend(popupCalendar);
	$("#calendar-container").prepend(overlay);
	
	var first = $('<div id="popup-calendar-1" class="calendar calendar-popup calendar-1"> </div>');
	popupCalendar.append(first);

		
	var isDouble = options['double'];
	var firstOptions = {}, secondOptions = {};
	for( option in options ){ firstOptions[option] = secondOptions[option] = options[option]};
	var initial = (options['initial']? options['initial'] : new Date(Date()) );
	
	firstOptions['initial'] = initial;
	firstOptions['links'] = [];
	if( isDouble )firstOptions['disable-next'] = true;
	
	first.data( 'options' , firstOptions );
	first.data( 'current-date' , initial );

	createInlineCalendar( first, firstOptions );
	
	if( isDouble )
	{
		var second = $('<div id="popup-calendar-2" class="calendar calendar-popup calendar-2"></div>');
		popupCalendar.append( second );

		var secondOptions = {};
		for( option in options ){ secondOptions[option] = options[option]};

  		secondOptions['disable-previous'] = true;
		secondOptions['links'] = [$(first)];
		firstOptions['links'] = [$(second)];


		first.data( 'options' , firstOptions );
		second.data( 'options' , secondOptions );
		second.data( 'current-date' , initial );
		second.data( 'offset' , 1 );
		
		initial = new Date( initial.getFullYear() + (initial.getMonth() == 11? 1 : 0 ), (initial.getMonth() + 1) %12 );
		secondOptions['initial'] = initial;

		createInlineCalendar( second , secondOptions );
	}
	else
	{
		$(popupCalendar).find('.calendar-header-today').remove();
	}
	
	var pos = $(from).offset()
	
	pos['bottom'] = pos['top'] + $(from).outerHeight(true);
	pos['right'] = pos['left'] + $(from).outerWidth(true);

	if( options['position'] == 'below-left')
	{
		popupCalendar.css('top' , options['y'] + pos['bottom'] );
		popupCalendar.css('left' , options['x'] + pos['right'] - popupCalendar.outerWidth() );
	}else
	if( options['position'] == 'below-right')
	{
		popupCalendar.css('top' , options['y'] + pos['bottom'] );
		popupCalendar.css('left' , options['x'] + pos['left']  );

	}else
	if( options['position'] == 'above-left')
	{
		popupCalendar.css('top' , options['y'] + pos['top']  - popupCalendar.outerHeight());
		popupCalendar.css('left' , options['x'] + pos['right'] - popupCalendar.outerWidth() );

	}else
	if( options['position'] == 'above-right')
	{
		popupCalendar.css('top' , options['y'] + pos['top']  - popupCalendar.outerHeight());
		popupCalendar.css('left' , options['x'] + pos['left']);

	}else if( options['position'] == 'before-top')
	{
		popupCalendar.css('top' , options['y'] + pos['bottom'] - popupCalendar.outerHeight() );
		popupCalendar.css('left' , options['x'] + pos['left'] - popupCalendar.outerWidth() );
	}else
	if( options['position'] == 'before-bottom')
	{
		popupCalendar.css('top' , options['y'] + pos['top'] );
		popupCalendar.css('left' , options['x'] + pos['left'] - popupCalendar.outerWidth() );

	}else
	if( options['position'] == 'after-top')
	{
		popupCalendar.css('top' , options['y'] + pos['bottom'] - popupCalendar.outerHeight() );
		popupCalendar.css('left' , options['x'] + pos['right'] );

	}else
	if( options['position'] == 'after-bottom')
	{
		popupCalendar.css('top' , options['y'] + pos['top'] );
		popupCalendar.css('left' , options['x'] + pos['right']);

	}
	
	popupCalendar.append('<span class="off-screen"">Calendar end</span>');
	
	popupCalendar.append( '<div class="calendar-footer"><div class="calendar-footer-close"><a href="#" onclick="return dismissPopupCalendar();" onBlur="document.getElementById(\'popup-calendar-1-nextmonth\').focus();" class="linkedtextandicon"><span>' +dictionary['close'] + '</span> <img src="uos/_assets/images/icons/close.gif" width="16" height="16" alt="' + dictionary['closeCalendar'] + '"></a></div></div>' );

  	if( $.browser.msie )
	{
		popupCalendar.bgiframe();
	}
	
	popupCalendar.find('.calendar-header-close a').trigger('focus');	
	return false;
}

function dismissPopupCalendar( dontfocus )
{
	try
	{
		var from = $(popupCalendar).data('from');
		
		$('.calendar-overlay').remove();
		popupCalendar.remove();
		popupCalendar = '';
		                                 
		if( !dontfocus )
		{
			$(from).trigger('focus');
		}
		
	}catch(e){	popupCalendar = ''; }
	return false;
}

function selectDate( obj , date )
{
	wrapChain( obj , function(calendar, source)
	{
		var options = $(calendar).data('options');
	
		var previous = $(calendar).data('selected-date');
		$(calendar).data('selected-date', date);

		if( previous )
		{
			var tmp = $('#' + __dateToId( $(calendar).attr('id') , previous) );
			tmp.removeClass('calendar-selected'); 
			tmp.removeAttr('title');
		};
		                                                                    
		if( !source )
			return false;
	
		$('#' + __dateToId( $(calendar).attr('id') , date) ).addClass('calendar-selected');
		$('#' + __dateToId( $(calendar).attr('id') , date) ).attr( 'title' , __selectedTitle( date ) );
	
	

		__setField( options['day'], date.getDate() );
		__setField( options['month'], date.getMonth() + 1 );
		__setField( options['year'], date.getFullYear() );
		
		var separator = (options['separator']? options['separator'] : '/');
		if( options['dmy' ])dmy( date , document.getElementById(options['dmy']), separator );
		if( options['ymd' ])ymd( date , document.getElementById(options['ymd']), separator );
		if( options['mdy' ])mdy( date , document.getElementById(options['mdy']), separator );

		if( options['custom'] ) options['custom']( date );
	
		if( $(calendar).hasClass('calendar-popup') )
			dismissPopupCalendar();
	});
		
	return false;
}

// verbs: return true if matches 

function dmy( date , field , separator ){ field.value = date.getDate() + separator + (date.getMonth() + 1) + separator + date.getFullYear(); }
function ymd( date , field , separator)	{ field.value = date.getFullYear() + separator + (date.getMonth() + 1) + separator + date.getDate(); }
function mdy( date , field , separator ){ field.value = (date.getMonth() + 1) + separator + date.getDate() + separator + date.getFullYear(); }



function future( date ){ var today = new Date(Date()); return (((date - today) > 0) || (date.getFullYear() == today.getFullYear() && date.getMonth() == today.getMonth() && date.getDate() == today.getDate()));}
function past( date ){	return !future( date );}
function weekdays( date ){	return (date.getDay() > 0 && date.getDay() < 6);}
function weekends( date ){	return !weekdays( date );}
function mondays( date ){return date.getDay() == 1;}
function tuesdays( date ){return date.getDay() == 2;}
function wednesdays( date ){return date.getDay() == 3;}
function thursdays( date ){return date.getDay() == 4;}
function fridays( date ){return date.getDay() == 5;}
function saturdays( date ){return date.getDay() == 6;}
function sundays( date ){return date.getDay() == 0;}
function everyday( date ){	return true; }

// Verb validator

function validateDate( date , allow, deny )
{
	for( i = 0 ; i < deny.length ; i++ )
	{
		if( deny[i](date) )
			return false;
	}
	
	for( i = 0 ; i < allow.length ; i++ )
	{
		if( allow[i](date) )
			return true;
	}
	return false;
}

// navigation buttons

function wrapChain( calendar , func )
{
	var links = $(calendar).data('options')['links'];// [calendar].concat($(calendar).data('options')['links']);   
	                                                 
	func( calendar , true );
	for( var i = 0 ; i < links.length ; i++  )
	{
		func( $(links[i]) , false);
	}
}

function nextYear( obj )
{
	wrapChain( obj , function(calendar, source)
	{
		var current = calendar.data( 'current-date' );
		var currentYear = current.getFullYear() + 1;

		current.setFullYear( currentYear );
		__populateCalendar( calendar, currentYear, current.getMonth() + 1 );
	});
	
	return false;	
}

function prevYear( obj )
{
	wrapChain( obj , function(calendar,source)
	{
		var current = calendar.data( 'current-date' );
		var currentYear = current.getFullYear() - 1;

		current.setFullYear( currentYear );
		__populateCalendar( calendar, currentYear, current.getMonth() + 1 );
	});
	
	return false;
}

function nextMonth( obj )
{
	wrapChain( obj , function(calendar,source)
	{
		var current = $(calendar).data( 'current-date' );
		var currentMonth = current.getMonth() + 1;
		var currentYear = current.getFullYear();
  
		if( ++currentMonth > 12 )
		{
			currentMonth = 1;
			currentYear++;
		}	
	
		current.setFullYear( currentYear );
		current.setMonth( currentMonth - 1 );
		
		__populateCalendar( calendar, currentYear, currentMonth );
		
	});
	return false;
}

function prevMonth( obj )
{
	wrapChain( obj , function(calendar,source)
	{
	
		var current = $(calendar).data( 'current-date' );
		var currentMonth = current.getMonth() + 1;
		var currentYear = current.getFullYear();
  
		if( --currentMonth < 1 )
		{
			currentMonth = 12;
			currentYear--;
		}	
	
		current.setFullYear( currentYear );
		current.setMonth( currentMonth - 1 );

		__populateCalendar( calendar, currentYear, currentMonth );
	});
	
	return false;
}


function thisMonth( obj )
{
	wrapChain( obj , function(calendar,source)
	{
		var today = new Date(Date());
		var currentMonth = today.getMonth() + 1 + (calendar.data('offset')? calendar.data('offset'):0 );
		var currentYear = today.getFullYear();
		
		if( currentMonth > 12 )
		{
			currentYear++;
			currentMonth = 1;
		}

		__populateCalendar( calendar, currentYear, currentMonth );
		
	});

	return false;
}

// helper routines       

function __setField( id, value )
{
	var field = document.getElementById(id);
	if( !field ){ return; }
	
	if( field.tagName.toLowerCase() == 'input' )
	{
		field.value = value;
	}                       
	if( field.tagName.toLowerCase() == 'select' )
	{
		for( i = 0 ; i < field.options.length ; i++ )
		{
			if( field.options[i].value == value )
			{
				field.selectedIndex = i;
				return;
			}
		}
	}
	
}

function __selectedTitle( date )
{
	if( language == 'en' )
	{
		return date.getDate() + ' ' + monthNames[date.getMonth()] + ', ' + date.getFullYear() + ' is selected';		
	}
	else if(language == 'fr' )
	{
		return 'Le ' + date.getDate() + ' ' + monthNames[date.getMonth()] + ' ' + date.getFullYear() + ' est choisi';		
	}
}

function __todayTitle( date )
{
	if( language == 'en' )
	{
		//return ' is ' + monthNames[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear();
		//' is ' + monthNames[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear() + " the day-> "  + dayNamesEn[date.getDay()];
		return date.getDate() + " (" + dayNames[date.getDay()] + ", " + monthNames[date.getMonth()] + " " + date.getFullYear() + ") - " + currDate;
			
	}
	else if(language == 'fr' )
	{
		return ', le ' + date.getDate() + ' ' + monthNames[date.getMonth()] + ' ' + date.getFullYear();		
	}
}

function __dateToId( prefix, date )
{
	var first = new Date( date.getFullYear(), date.getMonth() , 1 );
	var offset = (date.getDate() + first.getDay() - 1);
	
	return 'td-' + prefix + '-' + Math.floor(offset / 7) + '-' + (offset % 7);
}


function __withDefault( obj, index, def )
{
	var tmp = obj[index];
	if( tmp )
		return tmp;
	else
		return def;		
}

function __daysInMonth(iYear, iMonth)
{
	return 32 - new Date(iYear, iMonth, 32).getDate();
}

function __buildCalendarStructure( obj )
{                                     
	var options = obj.data( 'options' );
	var objId = obj.attr('id');
	obj.html('');
	
	
	var calendar = $(headerContents).appendTo( obj );
	
	
	
	calendar.append(daysHeader);
	var table = $(tableContents).appendTo( calendar );
	                                    
	var data = '';

	for( var i = 0 ; i < 6 ; i++ )
	{       
		data += '<tr>';
		for( var j = 0 ; j < 7 ; j++ )
		{               
			var className = 'calendar-day'
			if( j == 6 )
				className += ' calendar-sat';
			if( j == 0 )
				className += ' calendar-sun';

			var id = i + '-' + j;

			data += '<td headers="popup-calendar-1-currentmonth popup-calendar-1-currentyear '+dayHeader[j]+'" class="' + className + '" id="td-' + objId + '-' + id + '">&nbsp;</td>';
		}              
		data += '</tr>';
	}

	table.find('tbody').append( data );
	
	if( options['disable-next'] )
	{
		calendar.find(".calendar-nav-nextmonth").remove();
		calendar.find(".calendar-nav-nextmonth-spacer").show();
		calendar.find(".calendar-nav-nextmonth-spacer").attr('title','');
		calendar.find(".calendar-nav-nextmonth-spacer img").attr('alt','');		
		
		calendar.find(".calendar-nav-nextyear").remove();
		calendar.find(".calendar-nav-nextyear-spacer").show();
		calendar.find(".calendar-nav-nextyear-spacer").attr('title','');
		calendar.find(".calendar-nav-nextyear-spacer img").attr('alt','');		
		
	}else
	{
		calendar.find(".calendar-nav-nextmonth").each(function(i)
		{
			$(this).click( function(){ return nextMonth(obj); } );
			$(this).attr('id' , objId + '-nextmonth' );
		});
		calendar.find('.calendar-nav-nextyear').each(function(i)
		{
			$(this).click( function(){ return nextYear(obj); } );
			$(this).attr('id' , objId + '-nextyear' );
		})
	}
		
	if( options['disable-previous'] )
	{
		calendar.find(".calendar-nav-previousmonth").remove();
		calendar.find('.calendar-nav-previousmonth-spacer').show();
		calendar.find('.calendar-nav-previousmonth-spacer').attr('title','');
		calendar.find('.calendar-nav-previousmonth-spacer img').attr('alt','');		  
		
    	calendar.find(".calendar-nav-previousyear").remove();
		calendar.find('.calendar-nav-previousyear-spacer').show();		
		calendar.find('.calendar-nav-previousyear-spacer').attr('title','');
		calendar.find('.calendar-nav-previousyear-spacer img').attr('alt','');		
	}
	else
	{
		calendar.find('.calendar-nav-previousmonth').each(function(i)
		{
			$(this).click( function(){ return prevMonth(obj); } );
			$(this).attr( 'id' , objId + '-previousmonth' );
		});

		calendar.find('.calendar-nav-previousyear').each(function(i)
		{
			$(this).click( function(){ return prevYear(obj); } );
			$(this).attr( 'id' , objId + '-previousyear' );
		});
	}
	
	$(popupCalendar).find('.calendar-header-today').each(function()
	{
		$(this).html('');
		var link = $('<a href="#">' + dictionary['today'] + '</a>');
		var today = new Date(Date());
		
		link.attr('title' , dictionary['today'] + __todayTitle( today ) );
		
		link.click(function(e)
		{
			return thisMonth(obj);
		});
		
		$(this).append( link );
		$(this).append( __todayTitle( today ) );
	});		
	
	calendar.find('.calendar-currentmonth').attr( 'id' , objId + '-currentmonth' );
	calendar.find('.calendar-currentyear').attr('id', objId + '-currentyear' );

}                          

function __populateHeader( obj , year, month )
{
	var options = $(obj).data( 'options' );
		
 	$(obj).find( '.calendar-nav-nextyear' ).attr('title', dictionary['nextYear'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['nextYear'] + ')' : '') + ' (' + (year + 1) + ')');
 	$(obj).find( '.calendar-nav-nextyear img' ).attr('alt', dictionary['nextYear'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['nextYear'] + ')' : '') + ' (' + (year + 1) + ')');
 	$(obj).find( '.calendar-nav-previousyear' ).attr('title', dictionary['previousYear'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['previousYear'] + ')' : '') + ' (' + (year - 1) + ')');
 	$(obj).find( '.calendar-nav-previousyear img' ).attr('alt', dictionary['previousYear'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['previousYear'] + ')' : '') + ' (' + (year - 1) + ')');

	$(obj).find( '.calendar-nav-nextmonth' ).attr('title', dictionary['nextMonth'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['nextMonth'] + ')' : '') + ' (' + monthNames[month%12]+ ')');
	$(obj).find( '.calendar-nav-nextmonth img' ).attr('alt', dictionary['nextMonth'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['nextMonth'] + ')' : '') + ' (' + monthNames[month%12]+ ')');
	$(obj).find( '.calendar-nav-previousmonth' ).attr('title', dictionary['previousMonth'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['previousMonth'] + ')' : '') + ' (' + monthNames[(month + 10)%12]+ ')');
	$(obj).find( '.calendar-nav-previousmonth img' ).attr('alt', dictionary['previousMonth'] + (options['enableAccessKeys'] ? ' (' + titleAltAccessKeys['previousMonth'] + ')' : '') + ' (' + monthNames[(month + 10)%12]+ ')');	
	$(obj).find( '.calendar-currentmonth').html( monthNames[month - 1 ]);
	$(obj).find( '.calendar-currentyear').html( year );
}

function __populateCalendar( obj, year, month )
{
	var options = $(obj).data( 'options' );
	var objId = $(obj).attr('id');
	var deny = (options['deny']? options['deny']:[]);
	var allow = (options['allow']?options['allow']:[everyday]);
	var firstOfMonth = new Date( year, month - 1, 1 );
	var firstDay = firstOfMonth.getDay() + 1;
	var lastDay = __daysInMonth( year, month - 1 );
	var today = new Date(Date());
	var selected = $(obj).data('selected-date');//options['selected'];

	var bThisMonth = ((today.getMonth() + 1) == month && today.getFullYear() == year ) ;
	today = today.getDate();

	
	__populateHeader( obj , year, month );

	for( var i = 0 ; i < 6 ; i++ )
	{
		for( var j = 0 ; j < 7 ; j++ )
		{
			var td = document.getElementById( 'td-' + objId + '-' + i+'-'+j );
			var dayOfMonth = ((i*7) + j + 1) - firstDay + 1;
			
			$(td).removeClass( 'calendar-today' );
			$(td).removeClass( 'calendar-selected' );
			$(td).removeAttr('title');
			

		
			if( dayOfMonth < 1 || dayOfMonth > lastDay )
			{
				$(td).addClass( 'calendar-othermonth' ); 				
				td.innerHTML = '&nbsp;'; 
				
				$(td).hover( function(){}, function(){} );
			}
			else			
			{
				var day = new Date( year, month - 1, dayOfMonth );				

				
				$(td).removeClass( 'calendar-othermonth' ); 				
				
				$(td).hover( function(){ $(this).addClass('calendar-hover');}, function(){$(this).removeClass('calendar-hover');} );
				
				if( !validateDate( day, allow, deny ))
				{
					$(td).addClass( 'calendar-disabled' );
					//$(td).html( "<span title='past date -" + month + "<- Month Day->"  + day + "'>" + dayOfMonth + "</span>" );
					//var theDateToFillIn = " (" + dayNamesEn[day.getDay()] + ", " + monthNames[day.getMonth()] + " " + day.getFullYear() + ") - Past Date";
					var theDateToFillIn = "Past Date";
					$(td).html(dayOfMonth + "<span class='cal-off-screen'>"+theDateToFillIn+"</span>" );
		
				}
				else
				{
					var today = new Date();
					if(today.getDate() == day.getDate() && today.getFullYear() == day.getFullYear() && today.getMonth() == day.getMonth()) {
						var theDateToFillInTitle = " (" + dayNames[day.getDay()] + ", " + monthNames[day.getMonth()] + " " + day.getFullYear() + ") - " + currDate;
						var theDateToFillIn = " " + currDate;
						$(td).addClass( 'calendar-today' );
					} else {
						var theDateToFillInTitle = " (" + dayNames[day.getDay()] + ", " + monthNames[day.getMonth()] + " " + day.getFullYear() + ") - " + futDate;
						var theDateToFillIn = " " + futDate;
					}
					$(td).html( '<a href="#" title="'+dayOfMonth+theDateToFillInTitle+'">' + dayOfMonth + '<span class="cal-off-screen">'+theDateToFillIn+'</span></a>' );
					var link = $(td).find('a');
					link.data('date' , new Date( year, month - 1, dayOfMonth ));
					link.click( function() { return selectDate( obj , $(this).data('date')); } );
					
					link.focus( function() { $(this).parent('td').addClass('calendar-hover');} );
					link.blur(  function() { $(this).parent('td').removeClass('calendar-hover')} );
					
					$(td).removeClass( 'calendar-disabled' );
				}
				
				if( selected && (selected - day == 0))
				{
					$(td).addClass('calendar-selected');
					$(td).attr( 'title' , __selectedTitle( selected ));
				}
				else					
				if( bThisMonth && today == day.getDate() )
				{
					$(td).addClass( 'calendar-today' );
					///$(td).attr('title' , dictionary['today'] + __todayTitle( day ));
					$(td).attr('title' , __todayTitle( day ));
				}				
			}
		}
	}
	
	var begin = options['begin'];
	var end = options['end'];
	
	if( begin && !options['disable-previous'] ) // ignore this if the 'previous' buttons are disabled
	{
		if( (year < begin.getFullYear()) || (year == begin.getFullYear() && month <= (begin.getMonth() + 1) ))
		{
			obj.find('.calendar-nav-previousmonth').hide();
			obj.find('.calendar-nav-previousmonth').attr('title', dictionary['previousMonth'] + ' (' + dictionary['disabled'] + ')' );
			obj.find('.calendar-nav-previousmonth-spacer').show();			
		}
		else
		{
			obj.find('.calendar-nav-previousmonth').show();
			obj.find('.calendar-nav-previousmonth-spacer').hide();
		}
		
		if( year == begin.getFullYear() || (year == (begin.getFullYear() + 1) && month < (begin.getMonth() + 1) ))
		{
			obj.find('.calendar-nav-previousyear').hide();
			obj.find('.calendar-nav-previousyear').attr('title', dictionary['previousYear'] + ' (' + dictionary['disabled'] + ')' );						
			obj.find('.calendar-nav-previousyear-spacer').show();			
		}
		else
		{
			obj.find('.calendar-nav-previousyear').show();
			obj.find('.calendar-nav-previousyear-spacer').hide();			
		}
	}
	
	if( end && !options['disable-next'] ) // ignore this if the 'next' buttons are disabled
	{
		if( (year > end.getFullYear()) || (year == end.getFullYear() && month >= (end.getMonth() + 1) ))
		{
			obj.find('.calendar-nav-nextmonth').hide();
			obj.find('.calendar-nav-nextmonth').attr('title', dictionary['nextMonth'] + ' (' + dictionary['disabled'] + ')' );			
			obj.find('.calendar-nav-nextmonth-spacer').show();			
		}
		else
		{
			obj.find('.calendar-nav-nextmonth').show();
			obj.find('.calendar-nav-nextmonth-spacer').hide();
		}
		
		if( year == end.getFullYear() || (year == (end.getFullYear() + 1) && month > (end.getMonth() + 1) ))
		{
			obj.find('.calendar-nav-nextyear').hide();			
			obj.find('.calendar-nav-nextyear').attr('title', dictionary['nextYear'] + ' (' + dictionary['disabled'] + ')' );									
			obj.find('.calendar-nav-nextyear-spacer').show();			
		}
		else
		{
			obj.find('.calendar-nav-nextyear').show();
			obj.find('.calendar-nav-nextyear-spacer').hide();
		}
	}
	
}