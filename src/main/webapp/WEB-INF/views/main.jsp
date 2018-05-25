<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "hmainContentp://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta hmainContentp-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<script type="text/javascript">
$(function(){
	$('#menus').tree({
		url:"/menu.json",
		onClick:function(node){
			var url = node.url;
			if(url){
				var text = node.text;
				var tab = $('#mainContent').tabs('getTab',text);
				if(tab){
					$('#mainContent').tabs('select',text);
				}else{
					$('#mainContent').tabs('add',{
						title:text,
						content:'<iframe src="'+url+'" frameboder="0" style="width:100%;height:100%"></iframe>',
						closable:true
					});
				}
				
			}
		}
	});
	//对选项卡绑定上下文菜单事件
	$('#mainContent').tabs({
		onContextMenu : function(e, title, index) {
			//阻止浏览器默认右键菜单
			e.preventDefault();
			//选中标签
			$('#mainContent').tabs('select', index);
			//显示右键菜单
			$('#rightClick').menu('show', {
				left : e.pageX,
				top : e.pageY
			});
		}
	});
	//为每个菜单绑定点击事件
	//关闭选中的标签
	$("#closeCurrent").click(function() {
		//获取选中的标签索引
		var tab = $('#mainContent').tabs('getSelected');
		var index = $('#mainContent').tabs('getTabIndex', tab);
		$("#mainContent").tabs("close", index);
	});
	//关闭选中标签之外的标签
	$("#closeOthers").click(function() {
		//获取所有标签
		var tabs = $("#mainContent").tabs("tabs");
		var length = tabs.length;
		//获取选中标签的索引
		var tab = $('#mainContent').tabs('getSelected');
		var index = $('#mainContent').tabs('getTabIndex', tab);
		//关闭选中标签之前的标签
		for (var i = 0; i < index; i++) {
			$("#mainContent").tabs("close", 0);
		}
		//关闭选中标签之后的标签
		for (var i = 0; i < length - index - 1; i++) {
			$("#mainContent").tabs("close", 1);
		}
	});
	//关闭所有标签
	$("#closeAll").click(function() {
		var tabs = $("#mainContent").tabs("tabs");
		var length = tabs.length;
		for (var i = 0; i < length; i++) {
			$("#mainContent").tabs("close", 0);
		}
	});
});
</script>
<title>EasyUI</title>
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
		<div data-options="region:'west',split:true" title="菜单" style="width: 150px;">
			<ul id="menus"></ul>
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