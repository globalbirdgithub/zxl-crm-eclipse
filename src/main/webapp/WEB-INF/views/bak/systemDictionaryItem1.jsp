<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据字典明细管理</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var systemDictionaryItemDatagrid, systemDictionaryItemDialog, systemDictionaryItemForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		systemDictionaryItemDatagrid = $("#systemDictionaryItemDatagrid");
		systemDictionaryItemDialog = $("#systemDictionaryItemDialog");
		systemDictionaryItemForm = $("#systemDictionaryItemForm");
		// 3、初始化组件
		// 初始化添加表单
		systemDictionaryItemForm.form({
			url : "/systemDictionaryItem/save",
			onSubmit : function() { // 在表单‘提交前’，做验证
				return systemDictionaryItemForm.form("validate");
			},
			success : function(data) {//data是后台save方法返回的字符串
				// 把字符串转变成json对象
				data = jQuery.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					systemDictionaryItemDialog.dialog("close");
					jQuery.messager
							.alert("温馨提示", data.message, "info",
									function() {
										//调用重新加载数据的方法
										systemDictionaryItemDatagrid
												.datagrid("reload");
									});
				} else {
					jQuery.messager.alert('错误提示', data.message, 'error');
				}
			}
		});
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj2 = {
			create2 : function() {
				// 清空对话框里面的表单内容
				systemDictionaryItemForm.form("clear");
				// 打开对话框
				systemDictionaryItemDialog.dialog("open");
			},
			edit2 : function() {
				// 获取选中行数据
				var rowData = systemDictionaryItemDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				// 清空对话框里面的表单内容
				systemDictionaryItemForm.form("clear");
				// 加载数据：Easyui form的load方法，遵循一个“同名匹配”的原则
				systemDictionaryItemForm.form("load", rowData);
				if(rowData.parent){
					$('#SystemDictionaryCombobox').combobox('setValue',rowData.parent.id);
				}
				// 打开对话框
				systemDictionaryItemDialog.dialog("open");
			},
			remove2 : function() {
				// 获取选中行数据
				var rowData = systemDictionaryItemDatagrid
						.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				jQuery.get("/systemDictionaryItem/delete/" + rowData.id,
						function(data) {
							if (data.success) {//删除成功
								jQuery.messager.alert('消息提示', '删除成功!', 'info',
										function() {
											//调用重新加载数据的方法
											systemDictionaryItemDatagrid
													.datagrid("reload");
										});//消息							
							} else {
								jQuery.messager.alert('错误提示', data.message,
										'error');
							}
						}, 'json');
			},
			reload2 : function() {
				//调用重新加载数据的方法
				systemDictionaryItemDatagrid.datagrid("reload");
			},
			save2 : function() {
				//提交表单
				systemDictionaryItemForm.submit();
			},
			cancel2 : function() {
				//关闭对话框
				systemDictionaryItemDialog.dialog("close");
			},
			search2 : function() {//简单搜索：查询条件必须少
				systemDictionaryItemDatagrid.datagrid("load", $("#searchForm2")
						.serializeJson());
			}
		};
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").on("click", function() {
			// 获取对应按钮的cmd信息 
			//var cmd = $(this).attr("data-cmd");
			var cmd = $(this).data("cmd");
			// console.debug(cmd);
			if (cmdObj2[cmd]) {
				//组件的disabled禁用属性,无法控制事件.
				//判断按钮是否有禁用样式.
				if ($(this).hasClass("l-btn-disabled")) {
					return;
				}
				//动态的方法名称，就调用动态的方法
				cmdObj2[cmd]();
			}
		});
	});
</script>
</head>
<body>
	<!-- 1、数据表格 -->
	<table id="systemDictionaryItemDatagrid" class="easyui-datagrid" url="/systemDictionaryItem/list"
		title="数据字典明细管理" fit="true" border="false" fitColumns="true" singleSelect="true" pagination="true"
		rownumbers="true" toolbar="#datagridToolbar2">
		<thead>
			<tr>
				<th field="name" width="10">数据字典明细名称</th>
				<th data-options="field:'requence',width:10">序号</th>
				<th data-options="field:'intro',width:10">描述</th>
				<th data-options="field:'parent',width:10" formatter='domainNameFormatter'>所属目录</th>
			</tr>
		</thead>
	</table>
	<!-- 数据表格按钮 -->
	<div id="datagridToolbar2">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" data-cmd="create2">添加</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" data-cmd="edit2">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" data-cmd="remove2">删除</a> <a
			href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true" data-cmd="reload2">刷新</a>
		<div>
			<form id="searchForm2" method="post">
				关键字：<input name="q" size="10" /> 
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" data-cmd="search2">搜索</a>
			</form>
		</div>
	</div>
	<!-- 2、添加编辑对话框 -->
	<div id="systemDictionaryItemDialog" class="easyui-dialog" style="width: 360px; height: 260px; padding: 10px 20px"
		title="数据字典明细添加面板" buttons="#dialogButtons2" closed="true" modal="true">
		<form id="systemDictionaryItemForm" method="post">
			<input name="id" type="hidden" />
			<table align="center">
				<tr>
					<td>数据字典明细名称：</td>
					<td><input name="name" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>序号:</td>
					<td><input class='easyui-validatebox' type='text' name='requence'></input></td>
				</tr>
				<tr>
					<td>描述:</td>
					<td><input class='easyui-validatebox' type='text' name='intro'></input></td>
				</tr>
				<tr>
					<td>所属目录</td>
					<td>
						<select id="SystemDictionaryCombobox" class="easyui-combobox" name="parent.id" style="width:100%" 
							data-options="url:'/systemDictionary/all',valueField: 'id',textField: 'name'">
			            </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 对话框按钮 -->
	<div id="dialogButtons2">
		<a href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-ok" data-cmd="save2" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancel2" style="width: 90px">取消</a>
	</div>
</body>
</html>