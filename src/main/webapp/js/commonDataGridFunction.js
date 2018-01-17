var editIndex = undefined;
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#dg').datagrid('validateRow', editIndex)){
			var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'ID'});
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index){
		if (editIndex != index){
			if (endEditing()){
				$('#dg').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	}
	function append(){
		if (endEditing()){
			$('#dg').datagrid('appendRow',{});
			editIndex = $('#dg').datagrid('getRows').length-1;
			$('#dg').datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
	}
	function reject(){
		$('#dg').datagrid('rejectChanges');
		editIndex = undefined;
	}
	
	function appendStatusValue(id, status){
		var paramData = "";
		if(id == undefined){
			paramData +="&id=";
			paramData +="&status=C";
		}else if(status == 'D'){
			paramData +="&id="+id ;
			paramData +="&status=D";
		}else{
			paramData +="&id="+id ;
			paramData +="&status=U";
		}
		return paramData;
	}
	/* DATE BOX 관련 */

	$.fn.datebox.defaults.formatter = function(date){
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		var h = date.getHours();
		var mi = date.getMinutes();
		if(h != 0 || mi != 0 ){
			return y+''+(m<10?('0'+m):m)+''+(d<10?('0'+d):d)+''+(h<10?('0'+h):h)+''+(mi<10?('0'+mi):mi);
		}else{
			return y+''+(m<10?('0'+m):m)+''+(d<10?('0'+d):d);
		}
		
	};
	$.fn.datebox.defaults.parser = function(s){
		if (!s) return new Date();
		if(s.length == 12){
			var y = parseInt(s.substring(0,4),10);
			var m = parseInt(s.substring(4,6),10);
			var d = parseInt(s.substring(6,8),10);
			var h = parseInt(s.substring(8,10),10);
			var mi = parseInt(s.substring(10,12),10);
			if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(mi)){
				return new Date(y,m-1,d,h,mi);
			} else {
				return new Date();
			}
		}else{
			var y = parseInt(s.substring(0,4),10);
			var m = parseInt(s.substring(4,6),10);
			var d = parseInt(s.substring(6,8),10);
			if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
				return new Date(y,m-1,d);
			} else {
				return new Date();
			}
			
		}
	};
	
	
	$.fn.datetimebox.defaults.formatter = function(dt){
		var y = dt.getFullYear();
		var m = dt.getMonth()+1;
		var d = dt.getDate();
		var h = dt.getHours();
		var mi = dt.getMinutes();
			
		return y+''+(m<10?('0'+m):m)+''+(d<10?('0'+d):d)+''+(h<10?('0'+h):h)+''+(mi<10?('0'+mi):mi);
	};
	$.fn.datetimebox.defaults.parser = function(s){
		if (!s) return new Date();
		var y = parseInt(s.substring(0,4),10);
		var m = parseInt(s.substring(4,6),10);
		var d = parseInt(s.substring(6,8),10);
		var h = parseInt(s.substring(8,10),10);
		var mi = parseInt(s.substring(10,12),10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(mi)){
			return new Date(y,m-1,d,h,mi);
		} else {
			return new Date();
		}
	};
	
	
	$.extend($.fn.validatebox.defaults.rules, {  
		yearDate: {  
			validator: function(value, param){
				return value.length == 4 && isNumber(value);
			},  
			message: 'YYYY 형식으로 입력하세요.'  
		},
		monthDate: {  
			validator: function(value, param){
				return value.length == 6 && isNumber(value);
			},  
			message: '날짜는 YYYYMM 형식으로 입력하세요.'  
		},
	    defaultDate: {  
	        validator: function(value, param){
	       	 return value.length == 8 && isNumber(value);
	        },  
	        message: '날짜는 YYYYMMDD 형식으로 입력하세요.'  
	    },
	    defaultDateTime: {  
	        validator: function(value, param){
	       	 return value.length == 12 && isNumber(value);
	        },  
	        message: '데이터를  YYYYMMDDHHMI 형식으로 입력하세요.'  
	    },
	    onlyNumber:{
	    	validator: function(value, param){
		       	 return isNumber(value);
		        },  
		        message: '숫자만 입력 가능합니다.'
	    },
	    isPrecent:{
	    	validator: function(value, param){
	    		return isNumber(value) && (value <=100);
	    	},  
	    	message: '% 는 숫자와 최대 100 까지 입력 할 수 있습니다\n값을 확인하여 주세요.'
	    },
	    maxLength: {  
	        validator: function(value, param){  
	            return value.length <= param[0];  
	        },  
	        message: '최대{0}까지 입력 가능 합니다.'  
	    },
	    minLength:{  
	        validator: function(value, param){  
	            return value.length >= param[0];  
	        },  
	        message: '최소{0}까지 입력 가능 합니다.'
	    },
	    defaultLength:{  
	        validator: function(value, param){  
	            return value.length == param[0];  
	        },  
	        message: '{0}까지 입력 하셔야 합니다.'
	    },
	    codeCheck:{  
	        validator: function(value, param){  
	            return (value.length == param[0] && isAlphaNum(value));  
	        },  
	        message: '{0}까지 입력 하셔야 합니다. 또한 영문자와 숫자만 사용 가능합니다.'
	    },
	    password:{  
	        validator: function(value){
	            return (value.length >= 8 && isAlphaNum(value));  
	        },  
	        message: '비밀 번호는 8자 이상, 영문과 숫자만 사용하실수 있습니다.'
	    }
	
	});
	/* DATE BOX 관련 */
	
	/* 금액 세자리 마다 ,  표시 */
	 function formatPrice(val,row){
		// 숫자를 변환..
		  if(isNaN(val)){return 0;}
		   var reg = /(^[+-]?\d+)(\d{3})/;   
		   val += '';
		   while (reg.test(val))
		     val = val.replace(reg, '$1' + ',' + '$2');
		   return val;
	 }
	 
	 function formatDate(val,row){
		  if(isNaN(val)){return 0;}
		  if(val.length > 8){
			  return val.substr(0, 4)+ "-" + val.substr(4, 2)+ "-" + val.substr(6, 2);
		  }
		  return val;
	 }
	 
	 function formatDateTime(val,row){
		 if(isNaN(val)){return 0;}
		 if(val.length > 12){
			 return val.substr(0, 4)+ "-" + val.substr(4, 2)+ "-" + val.substr(6, 2)+ " " + val.substr(8, 2)+ ":" + val.substr(10, 2);
		 }
		 return val;
	 }

	 
	 function checkComboBox(array){
		 for(var i=0; i<array.length; i++){
			 if(!$('#'+array[i]).combobox('getValue')){
				 $('#'+array[i]).combobox("clear");
				 return true;
			 } 
		 }
		 return false;
	 }
	/**
	 * 사용법 :  getForm2Json($('#ff').serializeArray());
	 * @param a
	 * @returns
	 */
	function getForm2Json(a){
		 var o = {};
	     $.each(a, function() {
	         if (o[this.name] !== undefined) {
	             if (!o[this.name].push) {
	                 o[this.name] = [o[this.name]];
	             }
	             //o[this.name].push(this.value || '');
	             o[this.name] = o[this.name]+","+this.value || '';
	         } else {
	             o[this.name] = this.value || '';
	         }
	     });
	     return (JSON.stringify(o));
	 }

	function getForm2JsonWithEncode(a){
		 var o = {};
	     $.each(a, function() {
	         if (o[this.name] !== undefined) {
	             if (!o[this.name].push) {
	                 o[this.name] = [o[this.name]];
	             }
	             //o[this.name].push(this.value || '');
	             o[this.name] = o[this.name]+","+this.value || '';
	         } else {
	             o[this.name] = this.value || '';
	         }
	     });
	     return encodeURIComponent(JSON.stringify(o));
	 }
	
	$.fn.datagrid.defaults.onLoadError =  function(XMLHttpRequest, textStatus, errorThrown){
		popLogin(errorThrown);
	};
	$.extend($.fn.datagrid.defaults.editors,{
		combobox: {
			init: function(container, options){
				var combo = $('<input type="text">').appendTo(container);
				combo.combobox(options || {});
				return combo;
			},
			destroy: function(target){
				$(target).combobox('destroy');
			},
			getValue: function(target){
				var opts = $(target).combobox('options');
				if (opts.multiple){
					if($(target).combobox('getValues') != "")
						return $(target).combobox('getValues').join(opts.separator);
					else
						return "";
				} else {
					return $(target).combobox('getValue');
				}
			},
			setValue: function(target, value){
				var opts = $(target).combobox('options');
				if (opts.multiple){
					if (value == '' || value == undefined){
						$(target).combobox('clear');
					} else {
						var val = (value+"").split(opts.separator);
						$(target).combobox('setValues', val);
					}
				} else {
					$(target).combobox('setValue', value);
				}
			},
			resize: function(target, width){
				$(target).combobox('resize', width)
			}
		}
	});

$(function(){
	$("#YEAR").val((new Date).getFullYear() );
});
