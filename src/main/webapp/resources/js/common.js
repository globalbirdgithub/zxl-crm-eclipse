// 部门状态(当前行->value：字段值,row：行记录数据,index: 行索引)
function departmentStatusFormatter(v, r, i) {
	return v==0 ? "正常" : "<font style='color:red'>禁用</font>";
}
// 员工状态
function employeeStatusFormatter(v, r, i) {
	return v==1 ? "在职" : "<font style='color:red'>离职</font>";
}
// 名称 ,只要一个成立都可以显示，如果多个成立取第一个
function domainNameFormatter(v, r, i) {
	return v!=null ? v.name || v.username || v.realName || v.title : "";
}
//将form表单参数转换为数组对象
$.fn.serializeJson = function(){
	var paramArray = $(this).serializeArray();// 返回参数的json对象数组
	var param = {};
	for (var i = 0; i < paramArray.length; i++) {
		param[paramArray[i].name] = paramArray[i].value
	}
	return param;
}