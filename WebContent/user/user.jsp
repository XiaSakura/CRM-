<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>用户</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="../assets/css/layui.css" media="all">
<script type="text/javascript" src="../js/jquery.min.js"></script>
</head>
<body>
	<div style="margin-left: 20px;">
		
			<div class="layui-input-inline">
				<input type="text" id="search_user_name" name="user_name"
					placeholder="请输入用户名称:" autocomplete="off" class="layui-input">
			</div>
			<%-- <div class="layui-input-inline layui-form">
				<select id="search_customer">
					<option value="">请选择用户所属用户</option>
				</select>
			</div> --%>
			<div class="layui-input-inline">
				<input type="text" id="search_user_phone" name="user_phone"
					placeholder="请输入用户手机号:" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-input-inline layui-form">
				<select name="search_user_right" id="search_user_right">
								<option value="">请选择权限级别</option>
								<option value="1">普通员工</option>
								<option value="2">经理</option>
								<option value="3">管理员</option>
							</select>
			</div>
			<div class="layui-input-inline">
				<a class="layui-btn layui-btn-blue" data-type="reload"
					id="searchBtn">搜索</a>
				<button data-type="reset" id="resetBtn"
					class="layui-btn layui-btn-primary">重置</button>
			</div>
		
	</div>
	<table id="userList" lay-filter="userList"></table>
	<div class="layui-content" style="display: none" id="AddForm">
		<div class="layui-row">
			<div class="layui-card">
				<div class="layui-card-header">用户</div>
				<form class="layui-form layui-card-body" lay-filter="Addform"
					action="">
					<div class="layui-form-item layui-hide">
						<div class="layui-input-block">
							<input type="text" name="user_id" id="user_id"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">用户姓名</label>
						<div class="layui-input-block">
							<input type="text" name="user_name" id="user_name"
								lay-verify="required" placeholder="请输入姓名" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">用户电话</label>
						<div class="layui-input-block">
							<input type="text" name="user_phone" lay-verify="required"
								id="user_phone" lay-verify="required" placeholder="请输入电话"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">用户性别</label>
						<div class="layui-input-block">
							<input type="radio" name="user_gender" value="男" title="男">
							<input type="radio" name="user_gender" value="女" title="女"
								checked>
						</div>
					</div>
					<%-- <div class="layui-form-item">
							<label class="layui-form-label">用户性别</label>
							<div class="layui-input-block">
								<select name="user_position" id="user_position" lay-verify="required">
									<option value="">请选择</option>
								</select>
								<input type="text" name="user_position" lay-verify="required" id="user_position" lay-verify="required" placeholder="请输入用户职位" autocomplete="off" class="layui-input">
							</div>
						</div> --%>
					<div class="layui-form-item">
						<label class="layui-form-label">用户QQ</label>
						<div class="layui-input-block">
							<input type="text" name="user_qq" lay-verify="required"
								id="user_qq" lay-verify="required" placeholder="请输入用户职位"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">用户权限</label>
						<div class="layui-input-block">
							<select name="user_right" id="user_right"
								lay-verify="required">
								<option value="">请选择</option>
								<option value="1">普通员工</option>
								<option value="2">经理</option>
								<option value="3">管理员</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">用户邮箱</label>
						<div class="layui-input-block">
							<input type="text" name="user_email" lay-verify="email"
								id="user_email" lay-verify="required" placeholder="请输入用户职位"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<a class="layui-btn layui-btn-blue" lay-submit
								lay-filter="formDemo">立即提交</a>
							<button type="reset" class="layui-btn layui-btn-primary"
								id="reset">重置</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script src="../assets/layui.js"></script>
<!-- 数据表格上方的工具栏 -->
<script type="text/html" id="toolbar">
 	<div class="layui-btn-container">
   	 <button class="layui-btn layui-btn-sm" lay-event="Adduser">添加一个用户</button>
 	 </div>
		</script>
<!-- 数据表格右边的操作栏 -->
<script type="text/html" id="bar">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>
	<script>
//使用table模块
layui.use(('table'), function() {
	var table = layui.table;
	//渲染数据表格 并初始化
	table.render({
		elem: '#userList',
		url: '${pageContext.request.contextPath}/user_findAll.action' //数据接口
			,
		page: true //开启分页
			,
		toolbar: '#toolbar',
		minWidth: 100,
		limits:[5,10,15,20,25,30],
		id: 'listReload',
		cols: [
			[ //表头
				{
					field: 'user_name',
					title: '用户姓名',
					sort: true
				}, {
					field: 'user_phone',
					title: '用户电话'
				}, {
					field: 'user_createTime',
					title: '用户创建日期', 
					templet: function(d) {  
						var year=d.user_createTime.year+1900;
						var month=d.user_createTime.month+1;
						var date=d.user_createTime.date;
						return year+"年"+month+"月"+date+"日";
					}
				}, {
					field: 'user_gender',
					title: '用户性别',
				},  {
					field: 'user_email',
					title: '用户邮箱',
					},
				{
					field: 'user_qq',
					title: '用户QQ',
				},
				{
					field: 'user_right',
					title: '用户权限',
					templet: function(d) {  
						var right=d.user_right;
						if (right==1) {
							return "普通员工";
						}else if(right==2){
							return "经理";
						}
						else if(right==3){
							return "管理员";
						}
					}
				},
				{
					fixed: 'right',
					width: 150,
					align: 'center',
					toolbar: '#bar'
				} //这里的toolbar值是模板元素的选择器
			]
		]

	});
	
	 //头工具栏事件   toolbar(userList) 第二参数是table的id
	 table.on('toolbar(userList)', function(obj){
	    switch(obj.event){
	      case 'Adduser':
	    	layer.open({
				title: '注册用户',
				skin: 'layui-layer-rim', //加上边框
				area: ['40%', '60%'], //宽高
				type: 2, //['http://sentsin.com', 'no']
				content: ['../register.jsp'],
				shadeClose: true, //点击遮罩关闭
				//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
			});
	    	$('#reset').click(); //重新渲染表单
	      break;
	    };
	  });
	
	//监听工具条
	table.on('tool(userList)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		var data = obj.data; //获得当前行数据
		var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if(layEvent === 'del') { //删除
			layer.confirm('真的删除行么', function(index) {
				obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
				layer.close(index);
				//向服务端发送删除指令
				$.ajax({
					url: "${pageContext.request.contextPath}/user_delete.action",
					type: "POST",
					data: {
						"user_id": data.user_id
					},
					dataType: "json",
					success: function(data) {
						if(data.msg == "1") {
							obj.del();
							layer.msg("删除成功", {
								icon: 6
							});
						} else {
							layer.msg("删除失败", {
								icon: 5
							});
						}
					}
				});
			});
		} else if(layEvent === 'edit') {
			$('#reset').click(); //重新渲染表单 这里用于如果是添加用户 清空表单
			//下面用于数据的回显 
			$("#user_id").val(data.user_id);
			$("#user_name").val(data.user_name);
			$("#user_phone").val(data.user_phone);
			$("#user_qq").val(data.user_qq);
			$("#user_email").val(data.user_email);
			$("#user_right").val(data.user_right);
			layer.open({
				title: '修改用户',
				skin: 'layui-layer-rim', //加上边框
				area: ['40%', '60%'], //宽高
				type: 1, //['http://sentsin.com', 'no']
				content: $('#AddForm'),
				shadeClose: true, //点击遮罩关闭
				//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
			});
		}
	});
	
	//先得到 $ layui内置的jQuery
	var $ = layui.$,
		active = {
			reload: function() {
				var search_user_name = $('#search_user_name');
				//执行重载 重新加载数据表格 用于搜索
				table.reload('listReload', {
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: { //search_customer
						"user_name": $('#search_user_name').val(),
						"user_phone": $('#search_user_phone').val(),
						"search_user_right":$('#search_user_right').val()
					}
				});
			}
		};
	//监听 搜索按钮按下的事件
	$('#searchBtn').on('click', function() {
		var type = $(this).data('type');
		//执行上面的active 重载事件
		active[type] ? active[type].call(this) : ''; 
	});
	$('#resetBtn').on('click', function() {
		window.location.reload();
	});

});

layui.use('form', function() {
	var form = layui.form //获取form模块
	//监听提交按钮 更新或者提交用户
	form.on('submit(formDemo)', function(data) {
		$.ajax({
			url: "${pageContext.request.contextPath}/user_saveOrUpdate.action",
			type: "post",
			dataType: "json",
			data: data.field,
			success: function(data) {
				if(data.msg == "1") {
					layer.msg("成功,1秒后关闭", {
						icon: 6
					});
					setInterval(function(){
						window.location.reload();
					},"1000")
				} else {
					layer.msg("失败", {
						icon: 5
					});
					setInterval(function(){
						window.location.reload();
					},"1000")
				}
			}
		});
	});

	//发送ajax
	/*  return false; */ //阻止表单跳转。如果需要表单跳转，去掉这段即可。  
});
</script>
<script color="FF,99,5" opacity="1" count="99" zIndex="-2"
	src="https://cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.js"
	type="text/javascript" charset="utf-8"></script>


</html>