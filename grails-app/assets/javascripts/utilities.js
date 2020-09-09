/* UOS Version: 2.2 - 2015/NOV/10 - DARAIOUS */
/* 20151110 - Interad Updates for XSS Vulnerability */
/* 20151006 - Interad Updates for SideTabs and Horizontal Tabs */


/***********************************************************************/

/* Popups

/***********************************************************************/



function popup(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width='+ w + ', height=' + h + ',left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=yes,resizable=yes,toolbar=no,menubar=no');

	if (window.focus) {newwindow.focus()}

	return false;

}



function popupHelp(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width=600,height=516,left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=yes,resizable=yes,toolbar=no,menubar=no');

	if (window.focus) {newwindow.focus()}

	return false;

}



function popupFlash(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width=836,height=516,left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=no,resizable=yes,toolbar=no,menubar=no,statusbar=no,status=no');

	if (window.focus) {newwindow.focus()}

	return false;

}



function popupPrint(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width=710,height=516,left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=yes,resizable=yes,toolbar=no,menubar=no');

	if (window.focus) {newwindow.focus()}

	return false;

}



function popupThirdparty(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width=815,height=400,left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=yes,resizable=yes,toolbar=yes,menubar=yes,location=yes');

	if (window.focus) {newwindow.focus()}

	return false;

}





function popupNewbrowser(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width=815,height=400,left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=yes,resizable=yes,toolbar=yes,menubar=yes,location=yes,status=yes');

	if (window.focus) {newwindow.focus()}

	return false;

}



function popupNonhtml(url) {

	LeftWindowPosition = ((document.all)?window.screenLeft:window.screenX)+50;

	TopWindowPosition = ((document.all)?window.screenTop:window.screenY)+5;

	newwindow=window.open(url,'','width=836,height=516,left=' + LeftWindowPosition + ',top=' + TopWindowPosition + ',scrollbars=no,resizable=yes,toolbar=no,menubar=no,statusbar=no,status=no,status=yes');

	if (window.focus) {newwindow.focus()}

	return false;

}







/***********************************************************************/

/* Stylesheet Toggle

/***********************************************************************/



function setActiveStyleSheet(title) {

var i, a, main;

for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {

if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {

a.disabled = true;

if(a.getAttribute("title") == title) a.disabled = false;

}

}



createCookie("stylesheetsetting", title, 365);



}



function getActiveStyleSheet() {

var i, a;

for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {

if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title") && !a.disabled) return a.getAttribute("title");

}

return null;

}



function getPreferredStyleSheet() {

var i, a;

for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {

if(a.getAttribute("rel").indexOf("style") != -1

&& a.getAttribute("rel").indexOf("alt") == -1

&& a.getAttribute("title")

) return a.getAttribute("title");

}

return null;

}



function createCookie(name,value,days) {

if (days) {

var date = new Date();

date.setTime(date.getTime()+(days*24*60*60*1000));

var expires = "; expires="+date.toGMTString();

}

else expires = "";

document.cookie = name+"="+ escape( value ) +expires+"; path=/";

}



function readCookie(name){

var nameEQ = name + "=";

var ca = document.cookie.split(';');

for(var i=0;i < ca.length;i++) 	{

var c = ca[i];

while (c.charAt(0)==' ') c = c.substring(1,c.length);

if (c.indexOf(nameEQ) == 0) return unescape( c.substring(nameEQ.length,c.length) );

}return null;

}                                                                                  



function applyResizeScript() {

    if(!document.getElementById) { return; }    

    var toolTextresizeNormal = document.getElementById("tool-textresize-normal");

	var toolTextresizeLarge = document.getElementById("tool-textresize-large");

	var toolTextresizeExtralarge = document.getElementById("tool-textresize-extralarge");



    if (!toolTextresizeNormal) { return; }

	if (!toolTextresizeLarge) { return; }

	if (!toolTextresizeExtralarge) { return; }

    

  

    toolTextresizeNormal.onclick = function()

        {setActiveStyleSheet('', 1); return false;}

	toolTextresizeNormal.keypress = function()

        {setActiveStyleSheet('', 1); return false;}

	toolTextresizeLarge.onclick = function()

        {setActiveStyleSheet('textsize-large');return false;}

	toolTextresizeLarge.keypress = function()

        {setActiveStyleSheet('textsize-large');return false;}

	toolTextresizeExtralarge.onclick = function()

        {setActiveStyleSheet('textsize-extralarge');return false;}

	toolTextresizeExtralarge.keypress = function()

        {setActiveStyleSheet('textsize-extralarge');return false;}

} 





/***********************************************************************/

/* Striped Tables

/***********************************************************************/



var stripe = function() {

	var tables = document.getElementsByTagName("table");	



	for(var x=0;x!=tables.length;x++){

		var table = tables[x];

		if (! table) { return; }

		

		var tbodies = table.getElementsByTagName("tbody");

				

			for (var h = 0; h < tbodies.length; h++) {

			if (tbodies[h].className == "contentframework-stripedtable"){

				var odd = false;

				var trs = tbodies[h].getElementsByTagName("tr");	

				

				for (var i = 0; i < trs.length; i++) {

					

					trs[i].onmouseover=function(){

						

						this.className += " contentframework-hoveredrow"; return false

						

					}

					

					trs[i].onmouseout=function(){

					

						this.className = this.className.replace("contentframework-hoveredrow", ""); return false

						

					}

					

					if(odd)

						

						trs[i].className += " contentframework-altrow";

						

										

					odd = !odd;

				

			}

			}

		}

	}

}





/***********************************************************************/

/* Get Element by Class

/***********************************************************************/



function getElementsByClass(searchClass,node,tag) {

	var classElements = new Array();

	if ( node == null )

		node = document;

	if ( tag == null )

		tag = '*';

	var els = node.getElementsByTagName(tag);

	var elsLen = els.length;

	var pattern = new RegExp("(^|\\s)"+searchClass+"(\\s|$)");

	for (i = 0, j = 0; i < elsLen; i++) {

		if ( pattern.test(els[i].className) ) {

			classElements[j] = els[i];

			j++;

		}

	}

	return classElements;

}





/***********************************************************************/

/* Expand/Collapse Content (Expands/Collapses a class, i.e. multiple elements)

/***********************************************************************/



function toggleIcon(obj, a_id) {

	var opener = document.getElementById(a_id);

	var content = getElementsByClass(obj);

	

	iconState = opener.firstChild.alt;

	iconState = iconState.replace("Collapse","");

	iconState = iconState.replace("Expand","");

	

	for ( i=0;i<content.length;i++ ) {

		if (content[i].style.display != "none" ) {

			content[i].style.display = 'none';

			opener.firstChild.src = opener.firstChild.src.replace("collapse","expand");

			opener.firstChild.alt = 'Expand' + iconState;

			opener.focus();

		} else {

		content[i].style.display = '';

           	opener.firstChild.src = opener.firstChild.src.replace("expand","collapse");

			opener.firstChild.alt = 'Collapse' + iconState;

		}	

		

	}

}





/***********************************************************************/

/* Expand/Collapse Content - French (Expands/Collapses a class, i.e. multiple elements)

/***********************************************************************/



function toggleIconFrench(obj, a_id) {

	var opener = document.getElementById(a_id);

	var content = getElementsByClass(obj);

	

	iconState = opener.firstChild.alt;

	iconState = iconState.replace("R\u00E9duire","");

	iconState = iconState.replace("D\u00E9velopper","");

	

	for ( i=0;i<content.length;i++ ) {

		if (content[i].style.display != "none" ) {

			content[i].style.display = 'none';

			opener.firstChild.src = opener.firstChild.src.replace("collapse","expand");

			opener.firstChild.alt = 'D\u00E9velopper' + iconState;

			opener.focus();

		} else {

		content[i].style.display = '';

           	opener.firstChild.src = opener.firstChild.src.replace("expand","collapse");

			opener.firstChild.alt = 'R\u00E9duire' + iconState;

		}	

		

	}

}


/***********************************************************************/ 
/* Expand/Collapse Inline Help Content 
/***********************************************************************/
function toggleHelpInline(obj, a_id, trigger, title_id) { 
	var content = document.getElementById(obj); 
	var opener = document.getElementById(a_id); 	
	var title = document.getElementById(title_id); 	
	var expandEN = 'Expand';
	var collapseEN = 'Collapse';
	var expandFR = 'D\u00E9velopper';
	var collapseFR = 'R\u00E9duire';
	
	iconState = opener.lastChild.alt; 
	
	if (content.style.display != "none" ) { 
			//collapsing
			content.style.display = 'none'; 
			
			opener.title = opener.title.replace(collapseEN, expandEN);
			opener.title = opener.title.replace(collapseFR, expandFR);
			
			opener.lastChild.alt = opener.lastChild.alt.replace(collapseEN, expandEN);
			opener.lastChild.alt = opener.lastChild.alt.replace(collapseFR, expandFR);
			
			opener.focus(); 
			
		} else { 
			//expanding			
			content.style.display = ''; 
			
			opener.title = opener.title.replace(expandEN, collapseEN);
			opener.title = opener.title.replace(expandFR, collapseFR);
			
			opener.lastChild.alt = opener.lastChild.alt.replace(expandEN, collapseEN);
			opener.lastChild.alt = opener.lastChild.alt.replace(expandFR, collapseFR);
			
			if(trigger == opener && title != null){
				//trigger is the link
				title.focus();
			}
		} 
}
		
/***********************************************************************/ 
/* Expand/Collapse Inline Help Content - French 
/***********************************************************************/
function toggleHelpInlineFrench(obj, a_id) { 
	//This function has been deprecated. It's been kept in place to avoid breaking existing implementations. 
	//Please only use function toggleHelpInline(obj, a_id, trigger, title_id)instead
	var content = document.getElementById(obj); 
	var opener = document.getElementById(a_id); 	
	iconState = opener.lastChild.alt; 
	iconState = iconState.replace("R\u00E9duire",""); 
	iconState = iconState.replace("D\u00E9velopper",""); 		
	
	if (content.style.display != "none" ) { 
			content.style.display = 'none'; 
			
			opener.title = opener.title.replace('Collapse', 'Expand');
			opener.lastChild.alt = 'D\u00E9velopper' + iconState; 
			opener.focus(); 
		} else { 
		content.style.display = ''; 
			opener.lastChild.alt = 'R\u00E9duire' + iconState; 
			opener.title = opener.title.replace('Expand', 'Collapse');
		} 
}



/***********************************************************************/
/* Expand/Collapse Absolute Help Content
/***********************************************************************/
function xstooltip_findPosX(obj) 
	{
	  var curleft = 0;
	  if (obj.offsetParent) 
	  {
		while (obj.offsetParent) 
			{
				curleft += obj.offsetLeft
				obj = obj.offsetParent;
			}
		}
		else if (obj.x)
			curleft += obj.x;
		return curleft;
	}
	
	function xstooltip_findPosY(obj) 
	{
		var curtop = 0;
		if (obj.offsetParent) 
		{
			while (obj.offsetParent) 
			{
				curtop += obj.offsetTop
				obj = obj.offsetParent;
			}
		}
		else if (obj.y)
			curtop += obj.y;
		return curtop;
	}

function toggleHelpAbsolute(obj, a_id) {
	var currentcallouts = getElementsByClass("callout"); 
	for ( i=0;i<currentcallouts.length;i++ ) { 
		currentcallouts[i].style.zIndex = '1'; 
	} 
	var content = document.getElementById(obj); 
	content.style.zIndex = 2; 
	content.style.position = 'absolute'; 

	var opener = document.getElementById(a_id);	 	iconState = opener.lastChild.alt; 
	iconState = iconState.replace("Collapse",""); 
	iconState = iconState.replace("Expand","");		if (content.style.display != "none" ) { 
			content.style.display = 'none'; 
			opener.lastChild.alt = 'Expand' + iconState; 
			opener.focus(); 
		} else { 
		content.style.display = ''; 
			opener.lastChild.alt = 'Collapse' + iconState; 
		} 	 
	if ((content.style.top == '' || content.style.top == 0)  
		&& (content.style.left == '' || content.style.left == 0)) 
	{ 
	
		// need to fixate default size (MSIE problem)
		content.style.width = content.offsetWidth + 'px';
		content.style.height = content.offsetHeight + 'px';		
	
		// if tooltip is too wide, shift left to be within parent 
		posX = 0;
		posY = 17;
		if (posX + content.offsetWidth > opener.offsetWidth) posX = opener.offsetWidth - content.offsetWidth;
		if (posX < 0 ) posX = 0; 
		
		x = xstooltip_findPosX(opener) + posX;
		y = xstooltip_findPosY(opener) + posY;
		
		content.style.top = y + 'px';
		content.style.left = x + 'px';
		
		content.style.position = 'absolute';
		
	}
}





/***********************************************************************/

/* Expand/Collapse Absolute Help Content - French

/***********************************************************************/





function toggleHelpAbsoluteFrench(obj, a_id) {

	var content = document.getElementById(obj);

	var opener = document.getElementById(a_id);	

	

	iconState = opener.lastChild.alt;

	iconState = iconState.replace("R\u00E9duire","");

	iconState = iconState.replace("D\u00E9velopper","");



	

		if (content.style.display != "none" ) {

			content.style.display = 'none';

			opener.lastChild.alt = 'D\u00E9velopper' + iconState;

			opener.focus();

		} else {

		content.style.display = '';

			opener.lastChild.alt = 'R\u00E9duire' + iconState;

		}

	

	

	if ((content.style.top == '' || content.style.top == 0) 

		&& (content.style.left == '' || content.style.left == 0))

	{

		// need to fixate default size (MSIE problem)

		content.style.width = content.offsetWidth + 'px';

		content.style.height = content.offsetHeight + 'px';		

	

		// if tooltip is too wide, shift left to be within parent 

		posX = 0;

		posY = 17;

		if (posX + content.offsetWidth > opener.offsetWidth) posX = opener.offsetWidth - content.offsetWidth;

		if (posX < 0 ) posX = 0; 

		

		x = xstooltip_findPosX(opener.lastChild) + posX;

		y = xstooltip_findPosY(opener.lastChild) + posY;

		

		content.style.top = y + 'px';

		content.style.left = x + 'px';

		

		content.style.position = 'absolute';

		content.style.zIndex = 2;

	

	}

	



}





/***********************************************************************/

/* Hide objects with "jshide" class (element is not seen by Screen Readers)

/***********************************************************************/



function hidejshideObject() {

	var jshidevar = getElementsByClass("jshide");

		

	for ( i=0;i<jshidevar.length;i++ ) {

		jshidevar[i].style.display = 'none';

	}

}





/***********************************************************************/

/* Hide objects with "jsaccessiblehide" class (element is seen by Screen Readers)

/***********************************************************************/



function hidejsaccessiblehideObject() {

	var jsaccessiblehidevar = getElementsByClass("jsaccessiblehide");

		

	for ( j=0;j<jsaccessiblehidevar.length;j++ ) {

		jsaccessiblehidevar[j].style.position = 'absolute';

		jsaccessiblehidevar[j].style.left = '-5000px';

	}

}



/***********************************************************************/

/* Tab Script

/***********************************************************************/



//** Tab Content script v2.0- © Dynamic Drive DHTML code library (http://www.dynamicdrive.com)


if(typeof String.prototype.trim !== 'function') {
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g, ''); 
	}
}
					
function ddtabcontent(tabinterfaceid, c_id, lang){
	this.tabinterfaceid=tabinterfaceid //ID of Tab Menu main container

	this.tabs=document.getElementById(tabinterfaceid).getElementsByTagName("li") //Get all tab links within container

	this.enabletabpersistence=true

	this.hottabspositions=[] //Array to store position of tabs that have a "rel" attr defined, relative to all tab links, within container

	this.currentTabIndex=0 //Index of currently selected hot tab (tab with sub content) within hottabspositions[] array

	this.subcontentids=[] //Array to store ids of the sub contents ("rel" attr values)

	this.revcontentids=[] //Array to store ids of arbitrary contents to expand/contact as well ("rev" attr values)

	this.selectedClassTarget="link" //keyword to indicate which target element to assign "selected" CSS class ("linkparent" or "link")
	
	this.lang = typeof lang === 'undefined' ? 'en' : (lang.toLowerCase() == 'fr' ? 'fr' : 'en');
	
	//This needs to be in place so that tabs implemented before c_id was added to the main call don't break
	if(typeof c_id !== 'undefined'){
		this.contentContainer = document.getElementById(c_id);
	
		this.contentSections = document.getElementById(c_id).children;
	}
}

ddtabcontent.getCookie=function(Name){ 

	var re=new RegExp(Name+"=[^;]+", "i"); //construct RE to search for target name/value pair

	if (document.cookie.match(re)) //if cookie found

		return document.cookie.match(re)[0].split("=")[1] //return its value

	return ""

}


ddtabcontent.setCookie=function(name, value){

	document.cookie = name+"="+value+";path=/" //cookie value is domain wide (path=/)

}



ddtabcontent.prototype={

	setLang:function(lang){
		var offScreenTextSelectedEN = 'Currently selected.';
		var offScreenTextClickEN = 'Click to read content.';
		var offScreenTextselectedFR = 'Actuellement sélectionné.';
		var offScreenTextClickFR = 'cliquez sur cet élément pour lire le contenu associé.';
		var prevTabLinkTextEN = 'Previous item';
		var nextTabLinkTextEN = 'Next item';
		var prevTabLinkTextFR = 'Objet précédent';
		var nextTabLinkTextFR = 'Objet suivant';
		
		this.offScreenTextSelected = '';
		this.offScreenTextClick = '';
		
		if(lang == 'fr'){
			this.offScreenTextSelected = offScreenTextselectedFR;
			this.offScreenTextClick = offScreenTextClickFR;
			this.prevTabText = prevTabLinkTextFR;
			this.nextTabText = nextTabLinkTextFR;
		}
		else{
			this.offScreenTextSelected = offScreenTextSelectedEN;
			this.offScreenTextClick = offScreenTextClickEN;
			this.prevTabText = prevTabLinkTextEN;
			this.nextTabText = nextTabLinkTextEN;
		}
	},

	expandit:function(tabid_or_position){ //PUBLIC function to select a tab either by its ID or position(int) within its peers

		this.cancelautorun() //stop auto cycling of tabs (if running)

		var tabref=""

		try{

			if (typeof tabid_or_position=="string" && document.getElementById(tabid_or_position).getAttribute("rel")) //if specified tab contains "rel" attr

				tabref=document.getElementById(tabid_or_position)

			else if (parseInt(tabid_or_position)!=NaN && this.tabs[tabid_or_position].getAttribute("rel")) //if specified tab contains "rel" attr

				tabref=this.tabs[tabid_or_position]

		}

		catch(err){alert("Invalid Tab ID or position entered!")}

		if (tabref!="") //if a valid tab is found based on function parameter

			this.expandtab(tabref) //expand this tab

	},
	
	cycleit:function(dir, autorun){ //PUBLIC function to move foward or backwards through each hot tab (tabinstance.cycleit('foward/back') )

		if (dir=="next"){

			var currentTabIndex=(this.currentTabIndex<this.hottabspositions.length-1)? this.currentTabIndex+1 : 0

		}

		else if (dir=="prev"){

			var currentTabIndex=(this.currentTabIndex>0)? this.currentTabIndex-1 : this.hottabspositions.length-1

		}

		if (typeof autorun=="undefined") //if cycleit() is being called by user, versus autorun() function

			this.cancelautorun() //stop auto cycling of tabs (if running)

		this.expandtab(this.tabs[this.hottabspositions[currentTabIndex]])

	},



	setpersist:function(bool){ //PUBLIC function to toggle persistence feature

			this.enabletabpersistence=bool

	},



	setselectedClassTarget:function(objstr){ //PUBLIC function to set which target element to assign "selected" CSS class ("linkparent" or "link")

		this.selectedClassTarget=objstr || "link"

	},



	getselectedClassTarget:function(tabref){ //Returns target element to assign "selected" CSS class to

		return (this.selectedClassTarget==("linkparent".toLowerCase()))? tabref.parentNode : tabref

	},



	urlparamselect:function(tabinterfaceid){

		var result=window.location.search.match(new RegExp(tabinterfaceid+"=(\\d+)", "i")) //check for "?tabinterfaceid=2" in URL

		return (result==null)? null : parseInt(RegExp.$1) //returns null or index, where index (int) is the selected tab's index

	},

	expandtab:function(tabref, focus){
		focus = typeof focus !== 'undefined' ? focus : true; // check if we want to focus or not, only one place is setting the value to false, so all other times it is true
		var subcontentid=tabref.getAttribute("rel") //Get id of subcontent to expand
		var offScreenTextElement;

		//Get "rev" attr as a string of IDs in the format ",john,george,trey,etc," to easily search through

		var associatedrevids=(tabref.getAttribute("rev"))? ","+tabref.getAttribute("rev").replace(/\s+/, "")+"," : ""

		this.expandsubcontent(subcontentid)

		this.expandrevcontent(associatedrevids)

		for (var i=0; i<this.tabs.length; i++){ //Loop through all tabs, and assign only the selected tab the "currentpage" classes
			var wrapRegExp = /primarytabs-wrap/;
			var matchCount = this.getselectedClassTarget(this.tabs[i]).className.search(wrapRegExp);
			
			 if ( this.getselectedClassTarget(this.tabs[i]).className=(this.tabs[i].getAttribute("rel") == subcontentid) ) {
				// check whether the tab has the wrap class defined
				if(matchCount != -1) {
					// there was a match, so include the primarytabs-wrap class to the definition
					this.getselectedClassTarget(this.tabs[i]).className = "primarytabs-wrap sidetabs-currentpage primarytabs-currentpage";
				} else {
					// no match, so only define the currentpage classes
					this.getselectedClassTarget(this.tabs[i]).className = "sidetabs-currentpage primarytabs-currentpage";
				}
				
				document.getElementById(this.offScreenTextPrefix + this.tabs[i].id).innerHTML = this.offScreenTextSelected + ' ' + document.getElementById(this.offScreenTextPrefix + this.tabs[i].id).innerHTML;
				
			 } else {
				// check whether the tab has the wrap class defined
				if(matchCount != -1) {
					// there was a match, so redefine the class to only contain the primarytabs-wrap class
					this.getselectedClassTarget(this.tabs[i]).className = "primarytabs-wrap";
					
					document.getElementById(this.offScreenTextPrefix + this.tabs[i].id).innerHTML.replace(this.offScreenTextSelected, '');
					
				} else {
					// no match, so remove all class definitions
					this.getselectedClassTarget(this.tabs[i]).className = "";
					
					offScreenTextElement = document.getElementById(this.offScreenTextPrefix + this.tabs[i].id);
					
					offScreenTextElement.innerHTML = offScreenTextElement.innerHTML.replace(this.offScreenTextSelected, '').trim();
					
				}
			 }
		}

		if (this.enabletabpersistence) //if persistence enabled, save selected tab position(int) relative to its peers

			ddtabcontent.setCookie(this.tabinterfaceid, tabref.tabposition)

		this.setcurrenttabindex(tabref.tabposition) //remember position of selected tab within hottabspositions[] array
		
		if(focus)
			document.getElementById(subcontentid).focus()
		
	},



	expandsubcontent:function(subcontentid){

		for (var i=0; i<this.subcontentids.length; i++){

			var subcontent=document.getElementById(this.subcontentids[i]) //cache current subcontent obj (in for loop)

			subcontent.style.display=(subcontent.id==subcontentid)? "block" : "none" //"show" or hide sub content based on matching id attr value

		}
	},



	expandrevcontent:function(associatedrevids){

		var allrevids=this.revcontentids

		for (var i=0; i<allrevids.length; i++){ //Loop through rev attributes for all tabs in this tab interface

			//if any values stored within associatedrevids matches one within allrevids, expand that DIV, otherwise, contract it

			document.getElementById(allrevids[i]).style.display=(associatedrevids.indexOf(","+allrevids[i]+",")!=-1)? "block" : "none"

		}

	},



	setcurrenttabindex:function(tabposition){ //store current position of tab (within hottabspositions[] array)

		for (var i=0; i<this.hottabspositions.length; i++){

			if (tabposition==this.hottabspositions[i]){

				this.currentTabIndex=i

				break

			}

		}

	},



	autorun:function(){ //function to auto cycle through and select tabs based on a set interval

		this.cycleit('next', true)

	},



	cancelautorun:function(){

		if (typeof this.autoruntimer!="undefined")

			clearInterval(this.autoruntimer)

	},



	init:function(automodeperiod){

		var persistedtab=ddtabcontent.getCookie(this.tabinterfaceid) //get position of persisted tab (applicable if persistence is enabled)
	
		var selectedtab=-1 //Currently selected tab index (-1 meaning none)

		var selectedtabfromurl=this.urlparamselect(this.tabinterfaceid) //returns null or index from: tabcontent.htm?tabinterfaceid=index
		
		this.offScreenTextPrefix = 'offscreentext_';

		this.setLang(this.lang);
		
		this.automodeperiod=automodeperiod || 0

		for (var i=0; i<this.tabs.length; i++){

			this.tabs[i].tabposition=i //remember position of tab relative to its peers
			
			this.tabs[i].firstChild.firstChild.innerHTML += '<span id="' + this.offScreenTextPrefix + this.tabs[i].id + '" class="cal-off-screen">' + this.offScreenTextClick + '</span>';
			
			//Keyboard navigation handling for tabs. If forward-tabbing on a selected tab, send focus to the content for it, not next tab
			this.tabs[i].onkeydown = function(e){
				var event = window.event ? window.event : e;
				var isIE = event.target ? false : true;
				var src = !isIE ? event.target : event.srcElement;
				
				//Only doing custom handling when tabbing forward from selected tab. Tabbing back uses default behaviour.
				/*if(src.parentNode.parentNode.className.indexOf('sidetabs-currentpage') > -1 && event.keyCode == 9 && !event.shiftKey){ 
					document.getElementById(src.parentNode.parentNode.getAttribute('rel')).focus();
					
					if(isIE)
						event.returnValue = false;
					else
						event.preventDefault();
				}*/
			}
			

			if (this.tabs[i].getAttribute("rel")){

				var tabinstance=this

				this.hottabspositions[this.hottabspositions.length]=i //store position of "hot" tab ("rel" attr defined) relative to its peers

				this.subcontentids[this.subcontentids.length]=this.tabs[i].getAttribute("rel") //store id of sub content ("rel" attr value)

				this.tabs[i].onclick=function(){

					tabinstance.expandtab(this)

					tabinstance.cancelautorun() //stop auto cycling of tabs (if running)

					return false

				}

				if (this.tabs[i].getAttribute("rev")){ //if "rev" attr defined, store each value within "rev" as an array element

					this.revcontentids=this.revcontentids.concat(this.tabs[i].getAttribute("rev").split(/\s*,\s*/))

				}

				if (selectedtabfromurl==i || this.enabletabpersistence && selectedtab==-1 && parseInt(persistedtab)==i || !this.enabletabpersistence && selectedtab==-1 && this.getselectedClassTarget(this.tabs[i]).className=="selected"){

					selectedtab=i //Selected tab index, if found

				}

			}

		} //END for loop (tabs)
		
		var currentContentSection;
		var prevLink;
		var nextLink;
		
		//This needs to be in place so that tabs implemented before c_id was added to the main call don't break
		if(typeof this.contentSections === 'undefined') this.contentSections = 0;
		
		for(i = 0; i < this.contentSections.length; i++){
			currentContentSection = this.contentSections[i];
			
				if(i != 0){
					prevLink = document.createElement('a');
					prevLink.className = 'prev-tab-link link-hidden';
					prevLink.innerHTML = this.prevTabText;
					prevLink.href = '#';
					prevLink.id = 'prev' + i;
					
					for(var j = 0; j < this.tabs.length; j++){
						if(this.tabs[j].attributes['rel'].value == currentContentSection.id && j > 0){
							prevLink.tab = this.tabs[j - 1].id;
							}
					}
					
					function setFocusToTab(id, event){
						document.getElementById(id).children[0].children[0].focus();
						
						if(typeof event.preventDefault == 'function')
							event.preventDefault();
						else
							event.returnValue = false;	
					}
					
					prevLink.onclick = function(e){ 
						var event = window.event ? window.event : e;
						var src = event.target ? event.target : event.srcElement;
						
						setFocusToTab(src.tab, event);
					}

					prevLink.onkeypress = function(e){
						var event = window.event ? window.event : e;
						var src = event.target ? event.target : event.srcElement;
						
						if(event.keyCode == 13)
							setFocusToTab(src.tab, event);
					}
					
					currentContentSection.appendChild(prevLink);
				}
					
				if(i < this.contentSections.length - 1){
					nextLink= document.createElement('a');
					nextLink.className = 'next-tab-link link-hidden';
					nextLink.innerHTML = this.nextTabText;
					nextLink.href = '#';
					nextLink.id = 'next' + i;
					
					for(j = 0; j < this.tabs.length; j++){
						if(this.tabs[j].attributes['rel'].value == currentContentSection.id && j < this.tabs.length - 1){
							nextLink.tab = this.tabs[j + 1].id;
						}
					}
				
				nextLink.onclick = function(e){
					var event = window.event ? window.event : e;
					var src = event.target ? event.target : event.srcElement;
					
					setFocusToTab(src.tab, event);
				}
				
				nextLink.onkeypress = function(e){
					var event = window.event ? window.event : e;
					var src = event.target ? event.target : event.srcElement;
					
					if(event.keyCode == 13)
						setFocusToTab(src.tab, event);

				}
				
				currentContentSection.appendChild(nextLink);
			}
			
		} //END for loop (content sections)

		if (selectedtab!=-1) //if a valid default selected tab index is found
			
			//Added the second paramater as false, this prevents focus being given on load defaults to true all other times
			this.expandtab(this.tabs[selectedtab], false) //expand selected tab (either from URL parameter, persistent feature, or class="selected" class)

		else //if no valid default selected index found

			this.expandtab(this.tabs[this.hottabspositions[0]], false) //Just select first tab that contains a "rel" attr

		if (parseInt(this.automodeperiod)>500 && this.hottabspositions.length>1){

			this.autoruntimer=setInterval(function(){tabinstance.autorun()}, this.automodeperiod)

		}

	} //END int() function



} //END Prototype assignment





/***********************************************************************/

/* Accessible script for select forms without a submit button

/***********************************************************************/



//(c)2006 Thomas Frank, Studentlitteratur



niceSelect=function(){    

  var f=document.forms;

    for (var i=0;i<f.length;i++){          // Walks all the forms in the document.

    var e=f[i].elements;

    for(var j=0;j<e.length;j++){        // Walks all the elements in the form.

      if(e[j].type=="select-one"){      // Chooses elements that are select 

                          // box (that does not allow multiple

                          // selections).

        e[j].formnu=i;

                          // Here comes the "trick" of this 

                          // script: it redefines the 

                          // event handlers of the element.

                          

        e[j].onclick=function(){      // If the selection is made

                          // with the mouse, the it

                          // behaves like a normal selectbox

                          // menu and submits). 

          this.onchange=function(){

            f[this.formnu].submit()

          }

        };

        e[j].onblur=function(){        // This "disarms" the onblur function

                          // so that it will not submit as soon

                          // as the default option is deselected

                          // (by moving down the select list with

                          // the arrow key).

          this.onchange=function(){return true}  

        };

        e[j].onkeydown=function(e){      // When keys are pressed on the keyboard...

          if (e){theEvent = e} else {theEvent=event};

          if (theEvent.keyCode==13){    // ...only submit when 'enter' is pressed.

            if((this.onchange+"").indexOf("submit")<0){

              f[this.formnu].submit()

            }

          }

        }

      }

    }

  }

}


/***********************************************************************/

/* Disclaimer page redirect */
/* 20151116 - Interad Updates for XSS Vulnerability */

/***********************************************************************/
function grabDisclaimerUrl() {
	//URL Regex
	var re = /(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?/;
	
	//Get Link
	var myParam = location.search.split('link=')[1];

	if (myParam ) {
		//Remove GA params if available
		if (myParam.indexOf("&_ga") >= 0) {
			myParam = myParam.substring(0, myParam.indexOf("&_ga"));
		}

		//Validate URL
		if (re.test(unescape(myParam))) {
			theURL = unescape(myParam);

			document.getElementById("pagetitle").style.display = "block";
			document.getElementById("redirect-info").style.display = "block";
			document.getElementById("stepnav").style.display = "block";
			
			// //Encode URL output
			var tmp = document.createElement('div');
			tmp.appendChild(document.createTextNode(theURL));
			theURL = tmp.innerHTML;

			//Append URL to the page
			pageURL = document.getElementById("redirect-url");
			pageURL.innerHTML = theURL;
		}
		else {
			//Show warning message if URL is invalid
			document.getElementById("redirect-info").style.display = "none";
			document.getElementById("stepnav").style.display = "none";
			document.getElementById("pagetitle").style.display = "none";
			document.getElementById("redirect-warning").style.display = "block";
		}
	}
	else {
		//Show warning message if URL is blank
		if (document.getElementById("redirect-info")) {
			document.getElementById("redirect-info").style.display = "none";
			document.getElementById("stepnav").style.display = "none";
			document.getElementById("pagetitle").style.display = "none";
			document.getElementById("redirect-warning").style.display = "block";
		}
	}
}
addLoadEvent(grabDisclaimerUrl); 

function getParams() {
    var idx = document.URL.indexOf('?');
    var params = new Array();
    if (idx != -1) {
        var pairs = document.URL.substring(idx+1, document.URL.length).split('&');
        for (var i=0; i<pairs.length; i++) {
            nameVal = pairs[i].split('=');
            params[nameVal[0]] = nameVal[1];
            }
        }
    return params;
    }

params = getParams();


/***********************************************************************/
/* On Load Events
/***********************************************************************/

function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
}

// Apply text resize script
addLoadEvent(applyResizeScript); 

// Apply table row banding/highlighting script
addLoadEvent(stripe); 

// Hide elements using JS
addLoadEvent(hidejshideObject); 
addLoadEvent(hidejsaccessiblehideObject); 

// Style sheet settings
var cookie = readCookie("stylesheetsetting");
var title = cookie ? cookie : getPreferredStyleSheet();
setActiveStyleSheet(title);
