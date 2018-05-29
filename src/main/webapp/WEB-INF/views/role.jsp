<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var roleDatagrid, roleDialog, roleForm,slectedPermissions,allPermissions;
		// 2、把页面的组件，缓存到上面声明的变量中
		roleDatagrid = $("#roleDatagrid");
		slectedPermissions = $("#slectedPermissions");
		allPermissions = $("#allPermissions");
		roleDialog = $("#roleDialog");
		roleForm = $("#roleForm");
		
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			create : function() {
				roleForm.form("clear");
				slectedPermissions.datagrid('loadData',{total:0,rows:[]});//清空编辑加载的数据
				roleDialog.dialog("open").dialog("center");
			},
			edit : function() {
				var rowData = roleDatagrid.datagrid("getSelected");
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				roleForm.form("clear");
				slectedPermissions.datagrid("loadData",{total:rowData.permissions.length,rows:rowData.permissions.slice(0,10)}); 
				//已有权限本地分页
				var spPaper = slectedPermissions.datagrid("getPager");
				var spOps = slectedPermissions.datagrid("options");
				spPaper.pagination({
					showPageList : false,
					showRefresh : false,
					onSelectPage:function(pageNumber,pageSize){
						var start = (pageNumber - 1) * pageSize; 
				        var end = start + pageSize; 
				        slectedPermissions.datagrid("loadData",rowData.permissions.slice(start,end)); 
				        spPaper.pagination('refresh',{ 
				        	total:rowData.permissions.length,
				            pageNumber:pageNumber
				        }); 
					}
				});
				roleForm.form("load",rowData);
				roleDialog.dialog("open").dialog("center");
			},
			remove : function() {
				var rowData = roleDatagrid.datagrid("getSelected");
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				$.get("/role/delete/"+rowData.id, function(data) {
					if (data.success) {
						roleDatagrid.datagrid("reload");
						$.messager.alert('消息提示', '删除成功!', 'info');
					} else {
						$.messager.alert('错误提示', data.message, 'error');
					}
				}, 'json');
			},
			reload : function() {
				roleDatagrid.datagrid("reload");
			},
			save : function(){
				roleForm.submit();
			},
			cancel : function() {
				roleDialog.dialog("close");
				
			},
			search : function() {
				roleDatagrid.datagrid("load", $("#searchForm").serializeJson());
			}
		};
		// 3、初始化组件
		//初始化角色管理表格
		roleDatagrid.datagrid({    
		    url:'/role/list',
		    title:'角色管理',
		    fit:true,
		    border:false,
		    fitColumns:true,
		    singleSelect:true,
		    pagination:true,
		    rownumbers:true,
		    toolbar: [{
					iconCls: 'icon-add',
					text:'添加',
					handler: cmdObj['create']
				},{
					iconCls: 'icon-edit',
					text:'编辑',
					handler: cmdObj['edit']
				},{
					iconCls: 'icon-remove',
					text:'删除',
					handler: cmdObj['remove']
				},"-"
				,{
					iconCls: 'icon-reload',
					text:'刷新',
					handler: cmdObj['reload']
				}],
		    columns:[[    
		        {field:'name',title:'角色名称',width:'20%'},
		        {field:'sn',title:'角色编号',width:'20%'},
		        {field:'permissions', title: '权限', width:'60%',formatter:itemsFormatter},
		    ]] 
		}); 
		//初始化权限已选择表格
		slectedPermissions.datagrid({    
 		    url:'',
		    title:'已有权限',
		    width:450,
		    height:350,
		    border:false,
		    fitColumns:true,
		    singleSelect:true,
		    pagination:true,
		    rownumbers:true,
		    onDblClickRow:function(index,row){
		    	slectedPermissions.datagrid('deleteRow',index);
		    },
		    columns:[[    
		        {field:'name',title:'名称',width:'50%'},    
		        {field:'resource',title:'资源地址',width:'50%'}
			]] 
		}); 
		
		//初始化所有权限表格
		allPermissions.datagrid({    
		    url:'/permission/list',
		    title:'所有权限',
		    width:450,
		    height:350,
		    border:false,
		    fitColumns:true,
		    singleSelect:true,
		    pagination:true,
		    rownumbers:true,
		    onDblClickRow:function(index,rowData){
		    	var rows = slectedPermissions.datagrid('getRows');//重复添加判断
		    	for (var i = 0; i < rows.length; i++) {
		    		var row = rows[i];
		    		if(rowData.id==row.id){
		    			$.messager.alert('提示','不能重复添加'); 
		    			return;
		    		}
				  }
		    	slectedPermissions.datagrid('appendRow',rowData);
		    },
		    columns:[[    
		        {field:'name',title:'名称',width:'50%'},    
		        {field:'resource',title:'资源地址',width:'50%'}   
		    ]] 
		}); 
		var apPaper = allPermissions.datagrid("getPager");
		apPaper.pagination({
			showPageList : false,
			showRefresh : false,
		});
		
		//初始化添加/编辑框
		roleDialog.dialog({    
		    title: '添加或编辑角色',    
		    width:  924,    
		    height: 500,    
 		    closed: true,    
		    modal: true, 
		    buttons:[{
				text:'保存',
				handler:cmdObj['save']
			},{
				text:'取消',
				handler:cmdObj['cancel']
			}]
		});
		
		// 初始化角色编辑/添加表单
		roleForm.form({
			url : "/role/save",
			onSubmit : function(param) { 
				var rows = slectedPermissions.datagrid('getRows');
				for (var i = 0; i < rows.length; i++) {
					param['permissions[' + i + '].id']=rows[i].id;
				}
				return roleForm.form("validate");// 在表单‘提交前’,做验证,返回boolean
			},
			success : function(data) {//data是后台save方法返回的字符串
				data = jQuery.parseJSON(data);
				if (data.success) {
					roleDialog.dialog("close");
					$.messager.alert("温馨提示", data.message, "info", function() {
						roleDatagrid.datagrid("reload");
					});
				} else {
					$.messager.alert('错误提示', data.message, 'error');
				}
			}
		});
	
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").on("click", function() {
			// 获取对应按钮的cmd信息 
			//var cmd = $(this).attr("data-cmd");
			var cmd = $(this).data("cmd");
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
	<table id="roleDatagrid"></table>
	<div id="roleDialog" style="background-color:#d4f1f7;">
		<form id="roleForm" method="post">
			<table align="center">
				<input name="id" type="hidden" />
				<tr style="height:50px;">
					<td >
						角色名称：<input name="name" class="easyui-validatebox" required="true"/>
						编号： <input name='sn' class='easyui-validatebox' required="true"/>
					</td>
				</tr>
				<tr>
					<td>
						<table id="slectedPermissions"></table>
					</td>
					<td>
						<table id="allPermissions"></table>
					</td>
				</tr>
			</table>
		</form>
		<div style="text-align: center;">
			操作提示：双击移除或选择权限
		</div>
	</div>
</body>
</html>