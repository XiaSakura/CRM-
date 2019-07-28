<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>用户</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="../assets/css/layui.css" media="all">
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body >
	<div style="margin-left: 20px;">
		<form class="layui-form layui-card-body" lay-filter="serachForm"
					action="">
		<div class="layui-input-inline">
			<input type="text" id="search_cust_name" name="user_name"
				placeholder="请输入客户名称:" autocomplete="off" class="layui-input">
		</div>
		<div class="layui-input-inline layui-form">
			<select id="search_cust_level">
				<option value="">请选择客户级别</option>
				
			</select>
		</div>
		<div class="layui-input-inline layui-form">
			<select id="search_cust_source" name="baseDictSource.dict_id">
				<option value="">-请选择客户来源-</option>
			</select>
		</div>
		<div class="layui-input-inline layui-form">
			<select id="search_cust_industry" name="baseDictIndustry.dict_id">
				<option value="">-请选择客户行业-</option>
			</select>
		</div>
		<div class="layui-input-inline">
			<a class="layui-btn layui-btn-blue" data-type="reload"
				id="searchBtn">搜索</a>
			<a type="reset" id="resetBtn"
				class="layui-btn layui-btn-primary">重置</a>
		</div>
		</form>
	</div>
	<table id="customerList" lay-filter="customerList"></table>
	<div class="layui-content" style="display: none" id="AddForm">
		<div class="layui-row">
			<div class="layui-card">
				<div class="layui-card-header">修改客户</div>
				<form class="layui-form layui-card-body" lay-filter="Addform"
					action="">
					<div class="layui-form-item layui-hide">
						<div class="layui-input-block">
							<input type="text" name="cust_id" id="cust_id"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户姓名</label>
						<div class="layui-input-block">
							<input type="text" name="cust_name" id="cust_name"
								lay-verify="required" placeholder="请输入姓名" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户电话</label>
						<div class="layui-input-block">
							<input type="text" name="cust_phone" lay-verify="required"
								id="cust_phone" lay-verify="required" placeholder="请输入电话"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户信息来源</label>
						<div class="layui-input-block">
							<select name="baseDictSource.dict_id" id="baseDictSource"
								lay-verify="required">
								<option value="">请选择客户信息来源</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户等级</label>
						<div class="layui-input-block">
							<select name="baseDictLevel.dict_id" id="baseDictLevel"
								lay-verify="required">
								<option value="">请选择客户等级</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户所属行业</label>
						<div class="layui-input-block">
							<select name="baseDictIndustry.dict_id" id="baseDictIndustry"
								lay-verify="required">
								<option value="">请选择客户所属行业</option>
							</select>
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
   	 <button class="layui-btn layui-btn-sm" lay-event="AddCustomer">添加一个客户</button>
 	 </div>
		</script>
<!-- 数据表格右边的操作栏 -->
<script type="text/html" id="bar">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">
$(function(){
	$.ajax({
		url:"${pageContext.request.contextPath }/baseDict_findByTypeCode.action",
		type: "POST",
		dataType: "json",
		data:{"dict_type_code": "002"},
		success: function(data) {
			// 遍历json的数据:
			$(data).each(
					function(i, n) {
						$("#baseDictSource,#search_cust_source").append(
							"<option value='" + n.dict_id + "'>" +
							n.dict_item_name +
							"</option>");
					});
			layui.use('form', function() {
			    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
			    form.render('select');
			});
		}
	});
				$.ajax({
					url:"${pageContext.request.contextPath }/baseDict_findByTypeCode.action",
					type: "POST",
					dataType: "json",
					data:{"dict_type_code": "006"},
					success: function(data) {
						// 遍历json的数据:
							$(data).each(
					function(i, n) {
						$("#baseDictLevel,#search_cust_level").append(
							"<option value='" + n.dict_id + "'>" +
							n.dict_item_name +
							"</option>");
					});
						layui.use('form', function() {
						    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
						    form.render('select');
						});
					}
				});
			$.ajax({
				url:"${pageContext.request.contextPath }/baseDict_findByTypeCode.action",
				type: "POST",
				dataType: "json",
				data:{"dict_type_code": "001"},
				success: function(data) {
					// 遍历json的数据:
						$(data).each(
				function(i, n) {
					$("#baseDictIndustry,#search_cust_industry").append(
						"<option value='" + n.dict_id + "'>" +
						n.dict_item_name +
						"</option>");
				});
					layui.use('form', function() {
					    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
					    form.render('select');
					});
				}
			});
		
})

</script>
<script>
//使用table模块
layui.use(('table'), function() {
	var table = layui.table;
	//渲染数据表格 并初始化
	table.render({
		elem: '#customerList',
		url: '${pageContext.request.contextPath}/customer_findAll.action' //数据接口
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
					field: 'cust_name',
					title: '客户姓名',
					sort: true
				}, {
					field: 'cust_phone',
					title: '客户电话'
				}, {
					field: 'baseDictSource',
					title: '客户信息来源',
					templet: function(d) {
						return d.baseDictSource.dict_item_name;
					}
				}, {
					field: 'baseDictLevel',
					title: '客户等级',
					templet: function(d) {
						return d.baseDictLevel.dict_item_name;
					}
				}, {
					field: 'baseDictIndustry',
					title: '客户所属行业',
					templet: function(d) {
						return d.baseDictIndustry.dict_item_name;
					}
				}, {
					fixed: 'right',
					width: 150,
					align: 'center',
					toolbar: '#bar'
				} //这里的toolbar值是模板元素的选择器
			]
		]

	});
	
	 //头工具栏事件   toolbar(customerList) 第二参数是table的id
	 table.on('toolbar(customerList)', function(obj){
	    switch(obj.event){
	      case 'AddCustomer':
	    	layer.open({
				title: '修改客户',
				skin: 'layui-layer-rim', //加上边框
				area: ['40%', '60%'], //宽高
				type: 1, //['http://sentsin.com', 'no']
				content: $('#AddForm'),
				shadeClose: true, //点击遮罩关闭
				//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
			});
	    	$('#reset').click(); //重新渲染表单
	      break;
	    };
	  });
	
	//监听工具条
	table.on('tool(customerList)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		var data = obj.data; //获得当前行数据
		var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if(layEvent === 'del') { //删除
			layer.confirm('真的删除行么', function(index) {
				obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
				layer.close(index);
				//向服务端发送删除指令
				$.ajax({
					url: "${pageContext.request.contextPath}/customer_delete.action",
					type: "POST",
					data: {
						"cust_id": data.cust_id
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
			$('#reset').click(); //重新渲染表单 这里用于如果是添加客户 清空表单
			//下面用于数据的回显 
			$("#cust_id").val(data.cust_id);
			$("#cust_name").val(data.cust_name);
			$("#cust_phone").val(data.cust_phone);
			$("#baseDictSource").val(data.baseDictSource.dict_id);
			$("#baseDictLevel").val(data.baseDictLevel.dict_id);
			$("#baseDictIndustry").val(data.baseDictIndustry.dict_id);
			layer.open({
				title: '修改客户',
				skin: 'layui-layer-rim', //加上边框
				area: ['40%', '60%'], //宽高
				type: 1, //['http://sentsin.com', 'no']
				content: $('#AddForm'),
				shadeClose: true, //点击遮罩关闭
				//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
			});
			//Ajax获取
			/*  obj.update({
			   username: '123'
			   ,title: 'xxx'
			 }); */
		}
	});
	
	//先得到 $ layui内置的jQuery
	var $ = layui.$,
		active = {
			reload: function() {
				var search_cust_name = $('#search_cust_name');
				
				//执行重载 重新加载数据表格 用于搜索
				table.reload('listReload', {
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						"cust_name": $('#search_cust_name').val(),
						"baseDictLevel.dict_id": $('#search_cust_level').val(),
						"baseDictIndustry.dict_id": $('#search_cust_industry').val(),
						"baseDictSource.dict_id": $('#search_cust_source').val()
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
		location.reload();
	});

});

layui.use('form', function() {
	var form = layui.form //获取form模块
	//监听提交按钮 更新或者提交客户
	form.on('submit(formDemo)', function(data) {
		$.ajax({
			url: "${pageContext.request.contextPath}/customer_saveOrUpdate.action",
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