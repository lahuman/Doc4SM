<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EVENT-RELATION</title>
<script type="text/javascript">
		
	 $(function(){
				$("#dg").datagrid({
					title:"연관 이벤트 관리"
						, width:780
						, height:500
						, url:"/user/milestone/reationList.json?MILESTONE_ID=<%=request.getParameter("MILESTONE_ID")%>"
						, iconCls: 'icon-edit'
						, toolbar: '#tb'
						, singleSelect: true
						, columns:[[
									{field:'EVENT_CODE',title:"EVENT_CODE",hidden:true}
						            , {field:'EVENT_TYPE',title:"타입", width:50,align:'center'}
						            , {field:'EVENT_CONTENTS' ,title:"이벤트 내역",width:450,align:'center'}
						            , {field:'',title:"상세보기", width:100,align:'center', formatter:formatDetail}
						            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
						            , {field:'MODIFY_DT',title:"변경일", width:80,align:'center', formatter:formatDate}
						            
						   ]]
					});
			 });
	 function formatDetail(value,row){
		 	var href = '';	
		 	if(row.EVENT_TYPE == "업무"){
		 		href = '/user/event/pop/processEvent.do?REQ_CODE='+row.EVENT_CODE;
		 	}else if(row.EVENT_TYPE == "단순"){
		 		href = '/user/call.do?ID='+row.EVENT_CODE;
		 	}else if(row.EVENT_TYPE == "외부"){
		 		href = '/user/external.do?ID='+row.EVENT_CODE;
		 	}
			return '<a target="_blank" href="' + href + '">상세보기</a>';
		}
</script>

</head>
<body>
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<table id="dg"></table>
				<div id="tb" style="height:auto;">
				</div>
			</div>
		</div>
	</div>
</body>
</html>