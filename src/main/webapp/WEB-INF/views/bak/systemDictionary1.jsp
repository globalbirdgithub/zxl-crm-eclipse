<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据字典目录管理</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var systemDictionaryDatagrid, systemDictionaryDialog, systemDictionaryForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		systemDictionaryDatagrid = $("#systemDictionaryDatagrid");
		systemDictionaryDialog = $("#systemDictionaryDialog");
		systemDictionaryForm = $("#systemDictionaryForm");
		// 3、初始化组件
		// 初始化添加表单
		systemDictionaryForm.form({
			url : "/systemDictionary/save",
			onSubmit : function() { // 在表单‘提交前’，做验证
				return systemDictionaryForm.form("validate");
			},
			success : function(data) {//data是后台save方法返回的字符串
				// 把字符串转变成json对象
				data = jQuery.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					systemDictionaryDialog.dialog("close");
					jQuery.messager.alert("温馨提示", data.message, "info", function() {
						//调用重新加载数据的方法
						systemDictionaryDatagrid.datagrid("reload");
					});
				} else {
					jQuery.messager.alert('错误提示', data.message, 'error');
				}
			}
		});
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			create : function() {
				// 清空对话框里面的表单内容
				systemDictionaryForm.form("clear");
				// 打开对话框
				systemDictionaryDialog.dialog("open");
			},
			edit : function() {
				// 获取选中行数据
				var rowData = systemDictionaryDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				// 清空对话框里面的表单内容
				systemDictionaryForm.form("clear");
				// 加载数据：Easyui form的load方法，遵循一个“同名匹配”的原则
				systemDictionaryForm.form("load", rowData);
				// 打开对话框
				systemDictionaryDialog.dialog("open");
			},
			remove : function() {
				// 获取选中行数据
				var rowData = systemDictionaryDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				jQuery.get("/systemDictionary/delete/"+rowData.id, function(data) {
					if (data.success) {//删除成功
						jQuery.messager.alert('消息提示', '删除成功!', 'info',
								function() {
									//调用重新加载数据的方法
									systemDictionaryDatagrid.datagrid("reload");
								});//消息							
					} else {
						jQuery.messager.alert('错误提示', data.message, 'error');
					}
				}, 'json');
			},
			reload : function() {
				//调用重新加载数据的方法
				systemDictionaryDatagrid.datagrid("reload");
			},
			save : function() {
				//提交表单
				systemDictionaryForm.submit();
			},
			cancel : function() {
				//关闭对话框
				systemDictionaryDialog.dialog("close");
			},
			search : function() {//简单搜索：查询条件必须少
				systemDictionaryDatagrid.datagrid("load", $("#searchForm").serializeJson());
			}
		};
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").on("click", function() {
			// 获取对应按钮的cmd信息 
			//var cmd = $(this).attr("data-cmd");
			var cmd = $(this).data("cmd");
			// console.debug(cmd);
			if (cmdObj[cmd]) {
				//组件的disabled禁用属性,无法控制事件.
				//判断按钮是否有禁用样式.
				if ($(this).hasClass("l-btn-disabled")) {
					return;
				}
				//动态的方法名称，就调用动态的方法
				cmdObj[cmd]();
			}
		});
	});
</script>
</head>
<body>
	<!-- 1、数据表格 -->
	<table id="systemDictionaryDatagrid" class="easyui-datagrid" url="/systemDictionary/list"
		title="数据字典目录管理" fit="true" border="false" fitColumns="true" singleSelect="true" pagination="true"
		rownumbers="true" toolbar="#datagridToolbar">
		<thead>
			<tr>
				<th field="name" width="10">数据字典目录名称</th> 
				<th data-options="field:'sn',width:10">编号</th>
				<th data-options="field:'intro',width:10">描述</th>
				<th data-options="field:'state',width:10">状态</th>
			</tr>
		</thead>
	</table>
	<!-- 数据表格按钮 -->
	<div id="datagridToolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" data-cmd="create">添加</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" data-cmd="edit">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" data-cmd="remove">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true" data-cmd="reload">刷新</a>
		<div>
			<form id="searchForm" method="post">
				关键字：<input name="q" size="10" /> 
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" data-cmd="search">搜索</a>
			</form>
		</div>
	</div>
	<!-- 2、添加编辑对话框 -->
	<div id="systemDictionaryDialog" class="easyui-dialog" style="width: 360px; height: 260px; padding: 10px 20px"
		title="数据字典目录添加面板" buttons="#dialogButtons" closed="true" modal="true">
		<form id="systemDictionaryForm" method="post">
			<input name="id" type="hidden" />
			<table align="center">
				<tr>
					<td>数据字典目录名称：</td>
					<td><input name="name" style="width: 150px" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>编号:</td>
					<td><input class='easyui-validatebox' type='text' name='sn'></input></td>
				</tr>
				<tr>
					<td>描述:</td>
					<td><input class='easyui-validatebox' type='text' name='intro'></input></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td><input class='easyui-validatebox' type='text' name='state'></input></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 对话框按钮 -->
	<div id="dialogButtons">
		<a href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-ok" data-cmd="save" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>