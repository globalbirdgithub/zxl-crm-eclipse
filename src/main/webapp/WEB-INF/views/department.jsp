<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<script type="text/javascript">
	$(function(){
		$('#departmentAdd').click(function(){
            $('#departmentDialog').dialog('open').dialog('center').dialog('setTitle','添加部门');
            $('#departmentForm').form('clear');
		});
		$('#departmentEdit').click(function() {
            var row = $('#departmentDataGrid').datagrid('getSelected');
            if(!row){
            	$.messager.show({
                    title:'提示信息',
                    msg:'请选择要编辑的行'
                });
            }
            if (row){
                $('#departmentDialog').dialog('open').dialog('center').dialog('setTitle','编辑部门');
                $('#departmentForm').form('load',row);
            }
		});
		$('#departmentSave').click(function(){
       		$('#departmentForm').form('submit',{
                url: '/department/save',
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	try{
                		 var result = JSON.parse(result);
                         if (result.success){
                        	 $('#departmentDialog').dialog('close');
                        	 $('#departmentDataGrid').datagrid('reload');
                             $.messager.show({
                                 title: '提示信息',
                                 msg: result.message
                             });
                         } else {
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
		$('#departmentDelete').click(function() {
			var row = $('#departmentDataGrid').datagrid('getSelected');
            if(!row){
                $.messager.show({
                    title:'提示信息',
                    msg:'请选择要删除的行'
                });
            }
            if (row){
                $.messager.confirm('提示信息','你确定删除这一行吗?',function(r){
                    if (r){
                        $.post('/department/delete',{id:row.id},function(result){
                        	$('#departmentDataGrid').datagrid('reload');
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
        $('#departmentCancel').click(function(){
        	$('#departmentDialog').dialog('close');
        });
	});
</script>
<title>部门管理</title>
</head>
<body>
    <table id="departmentDataGrid" title="部门列表" class="easyui-datagrid" fit="true"
            url="/department/list" toolbar="#departmentToolbar" pagination="true"
            rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="id" width="50">ID</th>
                <th field="name" width="50">名称</th>
				<th field="sn" width="50">编号</th>
				<th field="dirPath" width="50">路径</th>
			</tr>
        </thead>
    </table>
    <div id="departmentToolbar">
        <a id="departmentAdd" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加部门</a>
        <a id="departmentEdit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑部门</a>
        <a id="departmentDelete" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">移除部门</a>
    </div>
    
    <div id="departmentDialog" class="easyui-dialog" style="width:350px" data-options="closed:true,modal:true,border:'thin',buttons:'#departmentDialog-buttons'">
        <form id="departmentForm" method="post" novalidate style="margin:0;padding:20px 50px">
        	<table>
        		<h3>部门信息</h3>
        		<input type="hidden" name="id"/>
        		<tr>
        			<td>名称：</td>
					<td><input type="text" name="name"/></td>
				</tr>
        		<tr>
        			<td>编号：</td>
					<td><input type="text" name="sn"/></td>
        		</tr>
        		<tr>
        			<td>路径：</td>
					<td><input type="text" name="dirPath"/></td>
        		</tr>
        	</table>
        </form>
    </div>
    <div id="departmentDialog-buttons">
        <a id="departmentSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a id="departmentCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
</body>
</html>