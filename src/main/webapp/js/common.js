function checkFormValidation(formObj){
		var resultObj = new Array();
		var isContinue = true;

		formObj.find(":input").each(function(){
			$(this).removeClass('ui-state-error');
			if(isContinue){
				if($(this).attr("nullable") == "false"){
					if(jQuery.trim($(this).val()).length == 0){
						resultObj["inputObj"] = $(this);
						resultObj["errorMsg"] = "의 값이 없습니다.";
						$(this).addClass('ui-state-error');

						isContinue = false;
					}
				}
				if($(this).attr("minlength") != undefined){
					//최소값 체크
					if(jQuery.trim($(this).val()).length < $(this).attr("minlength")){
						resultObj["inputObj"] = $(this);
						resultObj["errorMsg"] = "의 길이가 짧습니다. 최소 ["+ $(this).attr("minlength")+"] 현재 ["+jQuery.trim($(this).val()).length+"]";
						$(this).addClass('ui-state-error');
						
						isContinue = false;
					}
				}
				
				//한글입력 방지 옵션 체크
				if($(this).attr("han") == "false"){
					var strParam = $(this).val();
				    var i;
				    for(i=0; i<strParam.length; i++) {
				        if(strParam.charCodeAt(i) > 255){
				        	resultObj["inputObj"] = $(this);
							resultObj["errorMsg"] = "(에)는 한글을 사용할 수 없습니다.";
							$(this).addClass('ui-state-error');

							isContinue = false;
				        }
				    }
				}
				
				///FF인 경우는 속성값이 없을땐 -1을 리턴함....별도의 처리
				var maxLenCheck = 0;
				if(!costumBrowser.isIE){
					try{
						maxLenCheck = parseInt($(this).attr("maxlength"));
					}catch(e){
						maxLenCheck = -1;
					}
				}
				if($(this).attr("maxlength") != undefined && maxLenCheck > -1){
					//최대값 체크(textarea같은거를 위한거임)
					var maxlength = 0;
					try{
						maxlength = parseInt($(this).attr("maxlength")) * 2;
						var nowlength = getByteForJquery($(this));
	
						if(nowlength > maxlength){
							var errMsg = "는 최대 (" + maxlength + " Byte에 해당하는 글자 수)자 까지 입력 가능 합니다. 현재는 " + nowlength + "byte입니다.";
							errMsg += "\n(한글은 3byte, 영문ㆍ숫자ㆍ공백은 1byte입니다.)";
							
							resultObj["inputObj"] = $(this);
							resultObj["errorMsg"] = errMsg;
							$(this).addClass('ui-state-error');
							
							isContinue = false;
						}
					}catch(e){
						alert("유효성 검사에서 오류가 발생하였습니다.");
						isContinue = false;
					}					
				}
				
				if($(this).attr("isNumber") != undefined){
					var val = $(this).val();
					if(!isNumber(val)){
						resultObj["inputObj"] = $(this);
						resultObj["errorMsg"] = "의 값은 숫자로만 입력하셔야 합니다.";
						$(this).addClass('ui-state-error');
						
						isContinue = false;
					}
				}
			}
		});
		return resultObj;
	}
/* 유효성 검사 및 alert 띄우기 */
function checkFormValidationCallAlert(formObj){
	//유효성 체크
	var resultNullCheck =  checkFormValidation(formObj);

	if(resultNullCheck["inputObj"] != null){
		alert(resultNullCheck["inputObj"].attr("alt") + resultNullCheck["errorMsg"]);
		resultNullCheck["inputObj"].focus();
		return false;
	}else{
		//이상 없으면 submit
		return true;
	}
	return false;
}

/****************************************************************
 * Browser()
 *  : 브라우저 판단
 *
 * date   : 2006-12-27
 ****************************************************************/
 function Browser() {

    var ua, s, i;

    this.isIE    = false;
    this.isNS    = false;
    this.version = null;

    ua = navigator.userAgent;

    s = "MSIE";
    if ((i = ua.indexOf(s)) >= 0) {
        this.isIE = true;
        this.version = parseFloat(ua.substr(i + s.length));
        return;
    }

    s = "Netscape6/";
    if ((i = ua.indexOf(s)) >= 0) {
        this.isNS = true;
        this.version = parseFloat(ua.substr(i + s.length));
        return;
    }

    // Treat any other "Gecko" browser as NS 6.1.
    s = "Gecko";
    if ((i = ua.indexOf(s)) >= 0) {
        this.isNS = true;
        this.version = 6.1;
        return;
    }
}
var costumBrowser = new Browser();

//Jquery용 바이트 가져오기
//Jquery객체를 넘길것...
function getByteForJquery(obj)
{
	var byteSize = 0;
	var retValue = "";
	var aa = 0;
   
	if ( obj == null ) {
		return 0;
	} else {
		for( var i = 0; i < obj.val().length; i++ ) {
			var chr = escape(obj.val().charAt(i));		
			if ( chr.length == 1 ) {					
				byteSize ++;
				retValue += obj.val().charAt(i);
			} else if ( chr.indexOf("%u") != -1 ) {		
				byteSize += 3;
			} else if ( chr.indexOf("%") != -1 ) {		
				byteSize += chr.length/3;
				retValue += obj.val().charAt(i);
			}
		}
	}
			
	return byteSize;
}



/****************************************************************
 * isEmpty(form.field) : 입력값이 비어있는지 체크
 * examples  :
 ****************************************************************/
function isEmpty(input) {
    if (input.value == null || input.value.replace(/ /gi,"") == "") {
        return true;
    }
    return false;
}



/****************************************************************
 * containsChars(form.field, chars) :
 * 입력값에 특정 문자가 있는지 체크
 * 특정 문자를 허용하지 않으려 할 때 사용
 * examples  :
 *
 * if( containsChars(form.field, "!,*&^%$#@~;") ) {
 *     alert('입력값에 특수문자가 포함되었네요.');
 * }
 ****************************************************************/
function containsChars(input, chars) {
    for (var inx = 0; inx < input.value.length; inx++) {
       if (chars.indexOf(input.value.charAt(inx)) != -1)
           return true;
    }
    return false;
}



/****************************************************************
 * containsCharsOnly(form.field, chars) :
 * 입력값이 특정 문자만으로 되어있는지 체크
 * examples  :
 *
 * if( containsCharsOnly(form.field, "ABO") ) {
 *     alert('입력값이 A or B or O 문자로만 구성되어 있네요.');
 * }
 *
 * return : 입력값이 지정한 특정문자로만 되어 잇으면 TRUE
 * date   : 2002-10-28
 ****************************************************************/
function containsCharsOnly(input,chars) {
    for (var inx = 0; inx < input.length; inx++) {
       if (chars.indexOf(input.charAt(inx)) == -1)
           return false;
    }
    return true;
}


/****************************************************************
 * isAlphabet(form.field) : 입력값이 알파벳으로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로
 * 사용해도 좋다.
 * examples  :
 *
 * if( isAlphabet(form.field.value) ) {
 *     alert('입력값이 알파벳으로만 구성되어 있네요.');
 * }
 ****************************************************************/
function isAlphabet(input) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    return containsCharsOnly(input,chars);
}


/****************************************************************
 * isUpperCase(form.field.value) : 입력값이 알파벳 대문자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로
 * 사용해도 좋다.
 * examples  :
 *
 * if( isUpperCase(form.field.value) ) {
 *     alert('입력값이 알파벳 대문자로만 구성되어 있네요.');
 * }
 ****************************************************************/
function isUpperCase(input) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return containsCharsOnly(input, chars);
}


/****************************************************************
 * isLowerCase(form.field.value) : 입력값이 알파벳 소문자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로
 * 사용해도 좋다.
 * examples  :
 *
 * if( isLowerCase(form.field.value) ) {
 *     alert('입력값이 알파벳 소문자로만 구성되어 있네요.');
 * }
 *
 * return : 입력값이 알파벳 소문자로만 이루어져 있으면 TRUE
 ****************************************************************/
function isLowerCase(input) {
    var chars = "abcdefghijklmnopqrstuvwxyz";
    return containsCharsOnly(input,chars);
}


/****************************************************************
 * isNumber(form.field.value) : 입력값이 숫자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 숫자 지역변수를 전역변수로
 * 사용해도 좋다.
 * examples  :
 *
 * if( isNumber(form.field.value) ) {
 *     alert('입력값이 숫자로만 구성되어 있네요.');
 * }
 *
 * return : 입력값이 숫자로만 이루어져 있으면 TRUE
 ****************************************************************/
function isNumber(input) {
    var chars = "0123456789";
    return containsCharsOnly(input,chars);
}


/****************************************************************
 * isAlphaNum(form.field.value) : 입력값이 알파벳과 숫자로만 되어 있는지 체크
 * 본 함수가 자주 호출될 경우에는 캐릭터 지역변수를 전역변수로
 * 사용해도 좋다.
 * examples  :
 *
 * if( isAlphaNum(form.field.value) ) {
 *     alert('입력값이 알파벳과 숫자로만 구성되어 있네요.');
 * }
 *
 * return : 입력값이 알파벳과 숫자로만 이루어져 있으면 TRUE
 * date   : 2002-10-28
 ****************************************************************/
function isAlphaNum(input) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return containsCharsOnly(input,chars);
}


/****************************************************************
 * hasHangul(form.field.value) : 문자열에 한글이 포함되어 있는지 여부 체크
 * 현재 단순히 ascii코드가 255 보다 크면 한글이 존재하는 걸루 여김.
 * examples  :
 *
 * if( hasHangul(form.field.value) ) {
 *     alert('입력값에 한글이 포함되어 있네요.');
 * }
 *
 * return : 입력값에 한글이 포함되어 있다면 TRUE
 * date   : 2002-10-28
 ****************************************************************/
function hasHangul(value) {
    var strParam = value;
    var i;
    for(i=0; i<strParam.length; i++) {
        if(strParam.charCodeAt(i) > 255) return true;
    }
    return false;
}



/****************************************************************
 * isNumComma(form.field, format) :
 * 입력값이 사용자가 정의한 포맷 형식인지 체크
 * 자세한 format 형식은 자바스크립트의 'regular expression(정규식)'을 참조
 * 정규식에 대한 내용은 검색엔진을 통해 찾아보면 나옴.
 * examples  :
 *
 * if (isValidFormat(form.field, "[xyz]")) {
 *        alert('x-z 까지의 문자가 존재하네요.');
 * }
 *
 * return : 입력값이 지정한 올바른 포맷으로 되어 있으면 TRUE
 * date   : 2002-10-28
 ****************************************************************/
function isValidFormat(input, format) {
    if (input.value.search(format) != -1) {
        return true;
    }
    return false;
}


/****************************************************************
 * isValidEmail(form.field) : 입력값이 이메일 형식인지 체크
 * examples  :
 *
 * if (isValidEmail(form.field)) {
 *        alert('입력값이 이메일 형식이네요.');
 * }
 *
 * return : 입력값이 이메일 형식으로 되어있으면 TRUE
 * date   : 2002-10-28
 ****************************************************************/
function isValidEmail(input) {
    /*--
    var format = /^(\S+)@(\S+)\.([A-Za-z]+)$/;
    --*/
    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(input,format);
}



/****************************************************************
 * isValidPhone(form.field) : 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크
 * examples  :
 *
 * if (isValidPhone(form.field)) {
 *        alert('입력값이 전화번호 형식이네요.');
 * }
 *
 * return : 입력값이 전화번호 형식(숫자-숫자-숫자)이면 TRUE
 * date   : 2002-10-28
 ****************************************************************/
function isValidPhone(input) {
    var format = /^(\d+)-(\d+)-(\d+)$/;
    return isValidFormat(input,format);
}

/****************************************************************
 * 회원 아이디 형식의 패턴을 체크
 * 아이디 형식은 영문, 숫자형식의 6~15자리이여야 하며 첫자리는 반드시 영문으로 시작 
 * return : 입력값이 패턴에 맞는 형식이면 TRUE
 * date : 2009-03-31
 ****************************************************************/
function isMemberIdPattern(str) {
	var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9]{5,15}$/;
	return pattern.test(str);
}


$.ajaxSetup({
	   type: "POST"
		   , statusCode:{
			   418: function(){
				   alert("로그아웃 되었습니다.");
				   location.href="/loginForm.do";
			   }
		   }
 });

$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);



function callAjax(url, paramData, successFunction, dataType){
	$.ajax({
		type: "POST",	
		dataType: dataType,
		url: url,
		data: paramData,
		success: successFunction,
		error:error
	});
}
function callAjax2Json(url, paramData, successFunction){
	callAjax(url, paramData, successFunction, "json");
}
function callAjax2Html(url, paramData, successFunction){
	callAjax(url, paramData, successFunction, "html");
}
function error( xhr , textStatus, errorThrown){
	if(!popLogin(errorThrown)){
		$.messager.alert('ERROR',errorThrown,'error');  
	}
}

function popLogin(errorThrown){
//	if((errorThrown+"").indexOf("SyntaxError") != -1){
		//재 로그인 요청
		alert("작업을 진행하려면 로그인이 필요 합니다.");
		//LOGIN POPUP
		window.open(
    			"/login/pop/form.do",'popUpLogin','height=480,width=500,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
		return true;
//	}
//	return false;
}	


Date.prototype.yyyymmdd = function() {
	   var yyyy = this.getFullYear().toString();
	   var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based
	   var dd  = this.getDate().toString();
	   return yyyy + (mm[1]?mm:"0"+mm[0]) + (dd[1]?dd:"0"+dd[0]); // padding
	  };