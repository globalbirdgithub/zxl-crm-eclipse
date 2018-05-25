<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "hmainContentp://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta hmainContentp-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<title>登录页面</title>
<script type="text/javascript">
	//登录
	function submitForm(){
		$('#loginForm').form({
			url:"/login",
			success:function(data){
				var data = JSON.parse(data);
				if(data.success){
					location.href="/main/index";
				}else{
					$.messager.alert('温馨提示',data.message,'error');
				}
			}
		});
		$('#loginForm').submit();
	}
	//重置
	function resetForm(){
		$('#loginForm').form('clear');
	}
	//回车监听
	$(document.documentElement).on("keyup",function(event){
		var keyCode = event.keyCode;
		if(keyCode===13){
			submitForm();
		}
	});
	//检查自己是否是顶级页面(session过期)
	if(top!=window){
		window.top.location.href = window.location.href;
	}
</script>
</head>
<body>
	<div align="center" style="margin-top: 100px;">
		<div class="easyui-panel" title="CRM用户登陆" style="width: 350px; height: 190px;">
			<form id="loginForm" class="easyui-form" method="post">
				<table align="center" style="margin-top: 15px;">
					<tr height="20">
						<td>用户名:</td>
					</tr>
					<tr height="10">
						<td><input name="username" class="easyui-validatebox" required="true" value="admin" /></td>
					</tr>
					<tr height="20">
						<td>密&emsp;码:</td>
					</tr>
					<tr height="10">
						<td><input name="password" type="password" class="easyui-validatebox" required="true" value="0" /></td>
					</tr>
					<tr height="40">
						<td align="center">
							<a href="javascript:;" class="easyui-linkbutton" onclick="submitForm();">登陆</a> 
							<a href="javascript:;" class="easyui-linkbutton" onclick="resetForm();">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>