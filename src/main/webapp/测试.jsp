<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "hmainContentp://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta hmainContentp-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<title>EasyUI</title>
<script type="text/javascript">
	$(function(){
		$.ajax({
			type:'GET',
			dataType:'json',
			url:'menu.json',
			success:function(data){
				$.each(data,function(i,n){
					$('#menu').accordion('add',{
						title:n.text
					});
				});
			}
		});
	});
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'north'" style="height: 50px; background-color: #99CCFF">
			<h2>ACE后台管理系统</h2>
		</div>
		<div data-options="region:'south',split:true" style="height: 50px; text-align: center;">
			版权源代码教育所有<br />2009-2016<br />
		</div>
		<div data-options="region:'east',split:true" title="其他" style="width: 100px;">
			<b>欢迎${sessionScope.loginUser.username}</b><br />
			<a href="/login/loginOut">退出</a>
		</div>
		<!-- 西面：菜单栏 -->
		<div data-options="region:'west',split:true" title="导航菜单" style="width: 150px;">
			 <div id="menu" class="easyui-accordion" data-options="fit:true,border:false">
            </div>
		</div>
		<!-- 中间：内容 -->
		<div data-options="region:'center',title:'页面显示'">
			<div id="mainContent" class="easyui-tabs" fit="true">
				<div title="欢迎页面" style="padding: 10px"></div>
			</div>
		</div>
	</div>

	<!-- 选项卡右键菜单 -->
	<div id="rightClick" class="easyui-menu" style="width: 120px;">
		<div id="closeCurrent" name="closeCurrent"
			data-options="iconCls:'icon-no'">关闭当前</div>
		<div id="closeOthers" name="closeOthers"
			data-options="iconCls:'icon-no'">关闭其它</div>
		<div id="closeAll" name="closeAll"
			data-options="iconCls:'icon-cancel'">关闭所有</div>
	</div>


</body>
</html>