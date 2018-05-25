<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common.jsp"%><!-- 绝对路径 -->
<script type="text/javascript">
	$(function(){
		var departmentDataGrid,departmentDialog,departmentForm,departmentComboTree,managerComboGrid,departmentAdvancedSearchDialog,departmentAdvancedSearchForm;
		departmentDataGrid = $('#departmentDataGrid');
		departmentDialog = $('#departmentDialog');
		departmentForm = $('#departmentForm');
		departmentComboTree = $('#departmentComboTree');
		managerComboGrid = $('#managerComboGrid');
		departmentAdvancedSearchDialog=$('#departmentAdvancedSearchDialog');
		departmentAdvancedSearchForm=$('#departmentAdvancedSearchForm');
		//精简分页条内容
		var managerGrid = managerComboGrid.combogrid('grid');
		var pager = managerGrid.datagrid('getPager');
		pager.pagination({
			showPageList:false,
			showRefresh:false,
			displayMsg:""
		});
		
		var cmdObject = {
			departmentAdd:function(){
				departmentDialog.dialog('open').dialog('center').dialog('setTitle','添加部门');
				departmentForm.form('clear');
	            $('#stateChecked').prop('checked',true);
	            departmentComboTree.combotree({    
	                url: '/department/departmentTree'
	            }); 
			},
			departmentEdit:function() {
	            var row = departmentDataGrid.datagrid('getSelected');
	            if(!row){
	            	$.messager.show({
	                    title:'提示信息',
	                    msg:'请选择要编辑的行'
	                });
	            }
	            if (row){
	            	departmentDialog.dialog('open').dialog('center').dialog('setTitle','编辑部门');
	            	departmentForm.form('load',row);
	            	departmentComboTree.combotree({    
	                    url: '/department/departmentTree'
	                }); 
	            	if(row.parent){
	            		departmentComboTree.combotree('setValue', row.parent.id)
					}
					if(row.manager){
						managerComboGrid.combogrid('setValue', row.manager.id)
					}
	            }
			},
			departmentSave:function(){
				departmentForm.form('submit',{
	                url: '/department/save',
	                onSubmit: function(){
	                    return $(this).form('validate');
	                },
	                success: function(result){
	                	try{
	                		 var result = JSON.parse(result);
	                         if (result.success){
	                        	 departmentDialog.dialog('close');
	                        	 departmentDataGrid.datagrid('reload');
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
	        },
			departmentDelete:function() {
				var row = departmentDataGrid.datagrid('getSelected');
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
	                        	departmentDataGrid.datagrid('reload');
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
			departmentCancel:function(){
	        	departmentDialog.dialog('close');
	        },
	        departmentSearch:function(){
	        	departmentDataGrid.datagrid('load',$('#departmentSearchForm').serializeJson());
	        },
	        departmentAdvancedSearch:function(){
	        	departmentAdvancedSearchDialog.dialog('open').dialog('center').dialog('setTitle','部门高级查询');
	        	departmentAdvancedSearchForm.form('clear');
	        	var managerGrid = $('#managerComboGrid1').combogrid('grid');
	    		var pager = managerGrid.datagrid('getPager');
	    		pager.pagination({
	    			showPageList:false,
	    			showRefresh:false,
	    			displayMsg:""
	    		});
	        	$('#departmentComboTree1').combotree({
	        		url:'/department/departmentTree'
	        	});
	        },
	        departmentAdvancedSearchCommit:function(){
	        	departmentDataGrid.datagrid('load',departmentAdvancedSearchForm.serializeJson());
	        	departmentAdvancedSearchDialog.dialog('close');
	        },
	        departmentAdvancedSearchReset:function(){
	        	departmentAdvancedSearchForm.form('clear');
	        },
	        departmentAdvancedSearchCancel:function(){
	        	departmentAdvancedSearchDialog.dialog('close');
	        }
		}
		$('a[data-cmd]').click(function(){
			var cmd = $(this).data('cmd');
			cmdObject[cmd]();
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
                <th field="id" width="50" sortable='true'>ID</th>
                <th field="name" width="50" sortable='true'>名称</th>
				<th field="sn" width="50" sortable='true'>编号</th>
				<th field="dirPath" width="50" sortable='true'>路径</th>
				<th field="manager" width="50" formatter='domainNameFormatter' sortable='true'>经理</th>
				<th field="parent" width="50" formatter='domainNameFormatter' sortable='true'>上级部门</th>
				<th field="state" width="50" formatter='departmentStatusFormatter' sortable='true'>状态</th>
			</tr>
        </thead>
    </table>
    <div id="departmentToolbar">
        <a data-cmd='departmentAdd' href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加部门</a>
        <a data-cmd="departmentEdit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑部门</a>
        <a data-cmd="departmentDelete" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">移除部门</a>
        <form method="post" id="departmentSearchForm">
        	关键字：<input type="text" name="q" style="width: 65px"/>
        	状态：<select name="state">
        			<option value="-2">--请选择--</option>
      				<option value="0">正常</option>
        			<option value="-1">禁用</option>
        	</select>
        	<a data-cmd="departmentSearch" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
        	<a data-cmd="departmentAdvancedSearch" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">高级查询</a>
        </form>
    </div>
    
    <div id="departmentDialog" class="easyui-dialog" style="width:350px" data-options="closed:true,modal:true,border:'thin',buttons:'#departmentDialog-buttons'">
        <form id="departmentForm" method="post" novalidate style="margin:0;padding:20px 50px">
        	<table>
        		<h3>部门信息</h3>
        		<input type="hidden" name="id"/>
        		<tr>
        			<td>名称：</td>
					<td><input type="text" name="name" class="easyui-textbox" required="true"/></td>
				</tr>
        		<tr>
        			<td>编号：</td>
					<td><input type="text" name="sn" class="easyui-textbox" required="true"/></td>
        		</tr>
        		<tr>
        			<td>路径：</td>
					<td><input type="text" name="dirPath" class="easyui-textbox" required="true"/></td>
        		</tr>
        		<tr>
        			<td>经理：</td>
					<td><!--idField提交后台，textField输入框显示 -->
					   <select id="managerComboGrid" class="easyui-combogrid" name="manager.id" style="width:100%" data-options="
			                    panelWidth: 360,
			                    idField: 'id',
			                    textField: 'realName',
			                    mode: 'remote',
			                    pagination:true,
			                    url: '/employee/list',
			                    columns: [[
			                        {field:'username',title:'用户名'},
			                        {field:'realName',title:'姓名'},
			                        {field:'tel',title:'电话'},
			                        {field:'email',title:'邮箱'}
			                    ]]
			                ">
			            </select>
					</td>
        		</tr>
        		<tr>
        			<td>上级部门：</td>
					<td>
						<select id='departmentComboTree' name="parent.id" style="width:145px"/>
					</td>
        		</tr>
        		<tr>
        			<td>状态：</td>
					<td>
						<input id="stateChecked" type="radio" name="state" value="0"/>正常
						<input type="radio" name="state" value="-1"/>禁用
					</td>
        		</tr>
        	</table>
        </form>
    </div>
    <div id="departmentDialog-buttons">
        <a data-cmd="departmentSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="departmentCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
    <!-- 高级查询 -->
    <div id="departmentAdvancedSearchDialog" class="easyui-dialog" style="width:350px" data-options="closed:true,modal:true,border:'thin',buttons:'#departmentDialog-buttons'">
        <form id="departmentAdvancedSearchForm" method="post" novalidate style="margin:0;padding:20px 50px">
        	<table>
        		<h3>查询信息</h3>
        		<tr>
        			<td>名称：</td>
					<td><input type="text" name="name" class="easyui-textbox"/></td>
				</tr>
        		<tr>
        			<td>编号：</td>
					<td><input type="text" name="sn" class="easyui-textbox"/></td>
        		</tr>
        		<tr>
        			<td>经理：</td>
					<td><!--idField提交后台，textField输入框显示 -->
					   <select id="managerComboGrid1" class="easyui-combogrid" name="managerId" style="width:100%" data-options="
			                    panelWidth: 360,
			                    idField: 'id',
			                    textField: 'realName',
			                    mode: 'remote',
			                    pagination:true,
			                    url: '/employee/list',
			                    columns: [[
			                        {field:'username',title:'用户名'},
			                        {field:'realName',title:'姓名'},
			                        {field:'tel',title:'电话'},
			                        {field:'email',title:'邮箱'}
			                    ]]
			                ">
			            </select>
					</td>
        		</tr>
        		<tr>
        			<td>上级部门：</td>
					<td>
						<select id='departmentComboTree1' name="parentId" style="width:145px"/>  
					</td>
        		</tr>
        		<tr>
        			<td>状态：</td>
        			<td>
        				<select name="state" class="easyui-combobox">
        					<option value="-2">--请选择--</option>
        					<option value="0">正常</option>
        					<option value="-1">禁用</option>
        				</select>
        			</td>
        		</tr>
        	</table>
        </form>
    </div>
    <div id="departmentDialog-buttons">
        <a data-cmd="departmentAdvancedSearchCommit" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">查询</a>
        <a data-cmd="departmentAdvancedSearchReset" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" style="width:90px">重置</a>
    	<a data-cmd="departmentAdvancedSearchCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
</body>
</html>