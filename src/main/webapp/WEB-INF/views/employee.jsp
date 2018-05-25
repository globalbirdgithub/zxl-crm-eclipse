<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<script type="text/javascript">
$(function(){
	//1声明组件
	var employeeDataGrid,employeeDialog,employeeForm,departmentComboGrid,employeeSearchForm,employeeAdvancedSearchDialog,employeeAdvancedSearchForm;
	//2将组件缓存到变量中
	employeeDataGrid=$('#employeeDataGrid');
	employeeDialog=$('#employeeDialog');
	employeeForm=$('#employeeForm');
	departmentComboGrid=$('#departmentComboGrid');
	employeeSearchForm=$("#employeeSearchForm");
	employeeAdvancedSearchDialog=$('#employeeAdvancedSearchDialog');
	employeeAdvancedSearchForm=$('#employeeAdvancedSearchForm');
	//3初始化组件
	//4将当前模块功能打包到命令对象
	var cmdObject = {
		employeeAdd:function(){
			employeeDialog.dialog('open').dialog('center').dialog('setTitle','添加员工');
			employeeForm.form('clear');
			$('#stateChecked').prop('checked',true);
			departmentComboGrid.combotree({    
                url: '/department/departmentTree'
            }); 
		},
	    employeeEdit:function(){
		    var row = employeeDataGrid.datagrid('getSelected');
		    if(!row){
		    	$.messager.show({
		            title:'提示信息',
		            msg:'请选择要编辑的行'
		        });
		    }
		    if (row){
		    	employeeDialog.dialog('open').dialog('center').dialog('setTitle','编辑员工');
		    	employeeForm.form('clear');
		    	employeeForm.form('load',row);
		    	departmentComboGrid.combotree({    
	                url: '/department/departmentTree'
	            });
		    	if(row.department){
            		departmentComboGrid.combotree('setValue', row.department.id)
				}
		    }
		},
		employeeDel:function(){
		     var row = employeeDataGrid.datagrid('getSelected');
		     if(!row){
		         $.messager.show({
		             title:'提示信息',
		             msg:'请选择要删除的行'
		         });
		     }
		     if (row){
		         $.messager.confirm('提示信息','你确定删除这一行吗?',function(r){
		             if (r){
		                 $.post('/employee/delete',{id:row.id},function(result){
		                	 employeeDataGrid.datagrid('reload');//重载行。等同于'load'方法，但是它将保持在当前页。
		                     if (result.success){
		                         $.messager.show({
		                             title:'提示信息',
		                             msg:'删除成功！'
		                         });
		                     } else {
		                         $.messager.show({
		                             title: '错误提示',
		                             msg: result.message
		                         });
		                     }
		                 },'json');
		             }
		         });
		     }
		},
	    employeeSave:function(){
	    	employeeForm.form('submit',{
			        url: '/employee/save',
			        onSubmit: function(){
			            return $(this).form('validate');
			        },
			        success: function(result){
			        	try{
			        		var result = JSON.parse(result);//后台报500 400错误，返回的就不是Json格式，解析失败
			        		if(result.success){
			        			employeeDialog.dialog('close');
			        			employeeDataGrid.datagrid('reload');
			        			$.messager.show({
			                     title: '提示信息',
			                     msg: result.message
			                 });
			        		}else{
			        			$.messager.show({
			                     title: '提示信息',
			                     msg: result.message
			                 });
			        		}
			        	}catch(e){
			        		$.messager.show({
			                    title: '提示信息',
			                    msg: '解析失败！'+e
			                });
			        	}
			        }
			    });
	    },
		employeeCancel:function(){
			employeeDialog.dialog('close');
   		},
   		employeeSearch:function(){
   			employeeDataGrid.datagrid('load',employeeSearchForm.serializeJson());
   		},
   		employeeAdvancedSearch:function(){
   			employeeAdvancedSearchDialog.dialog('open').dialog('center').dialog('setTitle','员工高级查询');
   			employeeAdvancedSearchForm.form('clear');
   			$('#departmentComboGrid1').combotree({    
                url: '/department/departmentTree'
            }); 
   		},
   		employeeAdvancedSearchCommit:function(){
   			employeeDataGrid.datagrid('load',employeeAdvancedSearchForm.serializeJson());
   			employeeAdvancedSearchDialog.dialog('close');
   		},
   		employeeAdvancedSearchReset:function(){
   			employeeAdvancedSearchForm.form('clear');
   		},
   		employeeAdvancedSearchCancel:function(){
   			employeeAdvancedSearchDialog.dialog('close');
   		}
	}
	//5对所有页面按钮统一监听
	$('a[data-cmd]').click(function(){
		var cmd = $(this).data('cmd');
		cmdObject[cmd]();
	});
});
</script>
<title>员工管理</title>
</head>
<body>
	<!-- 列表显示 -->
    <table id="employeeDataGrid" title="员工列表" class="easyui-datagrid" fit="true"
            url="/employee/list" toolbar="#employeeToolbar" pagination="true"
            rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="id" width="50" sortable='true'>ID</th>
                <th field="realName" width="50" sortable='true'>姓名</th>
                <th field="username" width="50" sortable='true'>用户名</th>
                <th field="password" width="50" sortable='true'>密码</th>
                <th field="tel" width="50" sortable='true'>电话</th>
                <th field="email" width="50" sortable='true'>邮箱</th>
                <th field="inputTime" width="50" sortable='true'>录入时间</th>
                <th field="department" width="50" formatter='domainNameFormatter' sortable='true'>部门</th>
                <th field="state" width="50" formatter='employeeStatusFormatter' sortable='true'>状态</th>
            </tr>
        </thead>
    </table>
    <div id="employeeToolbar">
       	<a data-cmd="employeeAdd" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add">新建员工</a>
        <a data-cmd="employeeEdit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit">编辑员工</a>
        <a data-cmd="employeeDel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove">移除员工</a>
       	<form method="post" id="employeeSearchForm">
        	关键字<input type="text" name="q" style="width: 65px" class="easyui-textbox"/>
        	状态<select name="state" class="easyui-combobox"><!-- 状态（1：正常，0：离职） -->
	        		<option value="-1">--请选择--</option>
	        		<option value="1">在职</option>
	        		<option value="0">离职</option>
        	</select>
        	入职时间从<input class="easyui-datebox" name="beginDate" size="10" style="width: 100px"/>
        	到<input class="easyui-datebox" name="endDate" size="10" style="width: 100px"/>
        	<a data-cmd="employeeSearch" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        	<a data-cmd="employeeAdvancedSearch" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search">高级查询</a>
       	</form>
    </div>
    <!-- 修改/添加 -->
     <div id="employeeDialog" class="easyui-dialog" style="width:350px" data-options="closed:true,modal:true,border:'thin',buttons:'#employeeDialog-buttons'">
        <form id="employeeForm" method="post" novalidate style="margin:0;padding:20px 50px">
			<table>
        		<h3>员工信息</h3>
        		<input type="hidden" name="id"/>
        		<tr>
        			<td>姓名：</td>
					<td><input type="text" name="realName" class="easyui-textbox" required="true"/></td>
				</tr>
        		<tr>
        			<td>用户名：</td>
					<td><input type="text" name="username" class="easyui-textbox" required="true"/></td>
        		</tr>
        		<tr>
        			<td>密码：</td>
					<td><input type="text" name="password" class="easyui-textbox" required="true"/></td>
        		</tr>
        		<tr>
        			<td>电话：</td>
					<td><input type="text" name="tel" class="easyui-textbox" required="true"/></td>
        		</tr>
        		<tr>
        			<td>邮箱：</td>
					<td><input type="text" name="email" class="easyui-textbox"/></td>
        		</tr>
        		<tr>
        			<td>部门：</td>
					<td>
						<select id="departmentComboGrid" name="department.id" style="width:145px"/>  
					</td>
        		</tr>
        		<tr>
        			<td>状态：</td>
					<td>
						<input id="stateChecked" type="radio" name="state" value="1"/>在职
						<input type="radio" name="state" value="0"/>离职
					</td>
        		</tr>
        	</table>            
        </form>
    </div>
    <div id="employeeDialog-buttons">
        <a data-cmd="employeeSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="employeeCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
    <!-- 高级查询 -->
     <div id="employeeAdvancedSearchDialog" class="easyui-dialog" style="width:350px" data-options="closed:true,modal:true,border:'thin',buttons:'#employeeAdvancedSearchDialog-buttons'">
        <form id="employeeAdvancedSearchForm" method="post" novalidate style="margin:0;padding:20px 50px">
			<table>
        		<h3>查询信息</h3>
        		<tr>
        			<td>姓名：</td>
					<td><input type="text" name="realName" class="easyui-textbox"/></td>
				</tr>
        		<tr>
        			<td>用户名：</td>
					<td><input type="text" name="username" class="easyui-textbox"/></td>
        		</tr>
        		<tr>
        			<td>电话：</td>
					<td><input type="text" name="tel" class="easyui-textbox"/></td>
        		</tr>
        		<tr>
        			<td>邮箱：</td>
					<td><input type="text" name="email" class="easyui-textbox"/></td>
        		</tr>
        		<tr>
        			<td>部门：</td>
					<td>
						<select id="departmentComboGrid1" name="departmentId" style="width:145px"/>  
					</td>
        		</tr>
        		<tr>
        			<td>状态：</td>
					<td>
						<select name="state" class="easyui-combobox">
							<option value="-1">--请选择--</option>
							<option value="1">在职</option>
							<option value="0">离职</option>
						</select>
					</td>
        		</tr>
        	</table>            
        </form>
    </div>
    <div id="employeeAdvancedSearchDialog-buttons">
        <a data-cmd="employeeAdvancedSearchCommit" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">查询</a>
        <a data-cmd="employeeAdvancedSearchReset" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:90px">重置</a>
        <a data-cmd="employeeAdvancedSearchCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">关闭</a>
    </div>
</body>
</html>