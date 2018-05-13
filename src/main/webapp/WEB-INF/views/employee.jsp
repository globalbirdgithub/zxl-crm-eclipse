<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<script type="text/javascript">
	$(function(){
		$('#employeeAdd').click(function(){
            $('#employeeDialog').dialog('open').dialog('center').dialog('setTitle','添加员工');
            $('#employeeForm').form('clear');
		});
		$('#employeeEdit').click(function(){
            var row = $('#employeeDataGrid').datagrid('getSelected');
            if(!row){
            	$.messager.show({
                    title:'提示信息',
                    msg:'请选择要编辑的行'
                });
            }
            if (row){
                $('#employeeDialog').dialog('open').dialog('center').dialog('setTitle','编辑员工');
                $('#employeeForm').form('load',row);
            }		
		});
		$('#employeeSave').click(function(){
	       	 $('#employeeForm').form('submit',{
	                url: '/employee/save',
	                onSubmit: function(){
	                    return $(this).form('validate');
	                },
	                success: function(result){
	                	try{
	                		var result = JSON.parse(result);//后台报500 400错误，返回的就不是Json格式，解析失败
	                		if(result.success){
	                			$('#employeeDialog').dialog('close');
	                			$('#employeeDataGrid').datagrid('reload');
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
	        });
		$('#employeeDel').click(function(){
            var row = $('#employeeDataGrid').datagrid('getSelected');
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
                        	$('#employeeDataGrid').datagrid('reload');
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
		});
		$('#employeeCancel').click(function(){
        	$('#employeeDialog').dialog('close');
        });
	});
</script>
<title>员工管理</title>
</head>
<body>
    <table id="employeeDataGrid" title="员工列表" class="easyui-datagrid" fit="true"
            url="/employee/list" toolbar="#employeeToolbar" pagination="true"
            rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="id" width="50">ID</th>
                <th field="realName" width="50">姓名</th>
                <th field="username" width="50">用户名</th>
                <th field="password" width="50">密码</th>
                <th field="tel" width="50">电话</th>
            </tr>
        </thead>
    </table>
    <div id="employeeToolbar">
        <a id="employeeAdd" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">新建员工</a>
        <a id="employeeEdit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑员工</a>
        <a id="employeeDel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">移除员工</a>
    </div>
    
     <div id="employeeDialog" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#employeeDialog-buttons'">
        <form id="employeeForm" method="post" novalidate style="margin:0;padding:20px 50px">
			<table>
        		<h3>部门信息</h3>
        		<input type="hidden" name="id"/>
        		<tr>
        			<td>姓名：</td>
					<td><input type="text" name="realName"/></td>
				</tr>
        		<tr>
        			<td>用户名：</td>
					<td><input type="text" name="username"/></td>
        		</tr>
        		<tr>
        			<td>密码：</td>
					<td><input type="text" name="password"/></td>
        		</tr>
        		<tr>
        			<td>电话：</td>
					<td><input type="text" name="tel"/></td>
        		</tr>
        	</table>            
        </form>
    </div>
    <div id="employeeDialog-buttons">
        <a id="employeeSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a id="employeeCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
</body>
</html>