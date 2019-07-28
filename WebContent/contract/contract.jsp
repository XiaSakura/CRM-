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
</head>
<body>
	<div style="margin-left: 20px;">
	<form class="layui-form layui-card-body" lay-filter="serachForm"
					action="">
		<div class="layui-input-inline">
			<input type="text" id="search_contract_number" name="contract_number"
					placeholder="请输入合同编号:注意唯一" autocomplete="off" class="layui-input">
		</div>
			<div class="layui-input-inline layui-form">
			<select id="search_cust_id" name="cust.id">
				<option value="">-请选择客户-</option>
			</select>
		</div>
		<div class="layui-input-inline layui-form">
			<select id="search_user_id" name="user_id">
				<option value="">请选择负责人:</option>
			</select>
		</div>
		<div class="layui-input-inline">
			<a class="layui-btn layui-btn-blue" data-type="reload"
				id="searchBtn">搜索</a>
			<button type="reset" id="resetBtn"
				class="layui-btn layui-btn-primary">重置</button>
		</div>
		</form>
	</div>
	<table id="contractList" lay-filter="contractList"></table>
	<div class="layui-content" style="display: none" id="AddForm">
		<div class="layui-row">
			<div class="layui-card">
				<div class="layui-card-header">修改合同记录表</div>
				<form class="layui-form layui-card-body" lay-filter="Addform"
					action="">
					<div class="layui-form-item layui-hide">
						<div class="layui-input-block">
							<input type="text" name="contract_id" id="contract_id"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户姓名</label>
						<div class="layui-input-block">
							<select name="customer.cust_id" id="cust_id" lay-verify="required">
								<option value="">请选择客户姓名</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责人姓名</label>
						<div class="layui-input-block">
							<select name="user.user_id" id="user_id"
								lay-verify="required">
								<option value="">请选择负责人姓名</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">合同签约时间</label>
						<div class="layui-input-block">
							<input type="text" readonly="readonly" name="contract_time" lay-verify="required"
								id="contract_time" lay-verify="required" placeholder="请输入签约时间"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">合同编号</label>
						<div class="layui-input-block">
							<input type="text"  name="contract_number" lay-verify="required"
								id="contract_number" lay-verify="required" placeholder="请输入合同编号"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
					    <label class="layui-form-label">合同内容</label>
					    <div class="layui-input-block">
					      <textarea name="contract_context" id="contract_context" placeholder="请输入内容" lay-verify="required" class="layui-textarea"></textarea>
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
   	 <button class="layui-btn layui-btn-sm" lay-event="Addcontract">添加一个合同记录</button>
 	 </div>
		</script>
<!-- 数据表格右边的操作栏 -->
<script type="text/html" id="bar">
	<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
$.ajax({
	url:"${pageContext.request.contextPath }/customer_findCustomer.action",
	type: "POST",
	dataType: "json",
	success: function(data) {
		// 遍历json的数据:
			$(data).each(
				function(i, n) {
					$("#cust_id,#search_cust_id").append(
						"<option value='" + n.cust_id + "'>" +
						n.cust_name +
						"</option>");
				});
		layui.use('form', function() {
		    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
		    form.render('select');
		});
	}
});
/* 	$.ajax({
		url: "${pageContext.request.contextPath }/customer_findCustomer.action",
		type: "POST",
		dataType: "json",
		success: function(data) {
			// 遍历json的数据:
			$(data).each(
				function(i, n) {
					$("#cust_id,#search_cust_id").append(
						"<option value='" + n.cust_id + "'>" +
						n.cust_name +
						"</option>");
				});
		}
	}); */
	$.ajax({
		url:"${pageContext.request.contextPath }/user_findUser.action",
		type: "POST",
		dataType: "json",
		success: function(data) {
			// 遍历json的数据:
				$(data).each(
			function(i, n) {
				$("#user_id,#search_user_id").append(
					"<option value='" + n.user_id + "'>" +
					n.user_name +
					"</option>");
		});
			layui.use('form', function() {
			    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
			    form.render('select');
			});
		}
	});
/* $.ajax({
	url:"${pageContext.request.contextPath }/user_findUser.action",
	type: "POST",
	dataType: "json",
	success: function(data) {
		// 遍历json的数据:
		$(data).each(
			function(i, n) {
				$("#user_id,#search_user_id").append(
					"<option value='" + n.user_id + "'>" +
					n.user_name +
					"</option>");
		});
	}
}); */

</script>
<script>
//使用table模块
layui.use((['table','form']), function() {
	var table = layui.table;
	var form=layui.form;
	var $ = layui.$;
	
	/* form.render(null, 'Serachform'); //更新 lay-filter="test1" 所在容器内的全部表单状态 */
	
	
	//渲染数据表格 并初始化
	table.render({
		elem: '#contractList',
		url: '${pageContext.request.contextPath}/contract_findAll.action' //数据接口
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
					field: 'contract_number',
					title: '合同编号',
					sort: true
				}, {
					field: 'customer.cust_id',
					title: '客户姓名',    
					templet: function(d) {
						return d.customer.cust_name;  
					}
				},
				{
					field: 'user.user_id',
					title: '负责人姓名(用户姓名)',    
					templet: function(d) {
						return d.user.user_name;  
					}
				}, {
					field: 'contract_time',
					title: '合同签约时间',
					templet: function(d) {
						var year=d.contract_time.year+1900;
						var month=d.contract_time.month+1;
						var date=d.contract_time.date;
						return year+"年"+month+"月"+date+"日";
					}
				}, {
					field: 'contract_context',
					title: '合同内容'
				}
				, {
					fixed: 'right',
					align: 'center',
					toolbar: '#bar'
				} //这里的toolbar值是模板元素的选择器
			]
		]

	});
	
	 //头工具栏事件   toolbar(contractList) 第二参数是table的id
	 table.on('toolbar(contractList)', function(obj){
	    switch(obj.event){
	      case 'Addcontract':
	    	layer.open({
				title: '修改合同',
				skin: 'layui-layer-rim', //加上边框
				area: ['50%', '70%'], //宽高
				type: 1, //['http://sentsin.com', 'no']
				content: $('#AddForm'),
				shadeClose: true, //点击遮罩关闭
				//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
			});
	    	$('#reset').click(); //重新渲染表单 这里是为了清空表单 添加事件
	      break;
	    };
	  });
	
	//监听工具条
	table.on('tool(contractList)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		var data = obj.data; //获得当前行数据
		var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		 if(obj.event === 'detail'){
			$('#reset').click(); //重新渲染表单 这里用于如果是添加客户 清空表单
			//回显数据
		  	$("#contract_id").val(data.contract_id);
			$("#cust_id").val(data.customer.cust_id);
			$("#user_id").val(data.user.user_id);
			$("#contract_time").val(data.contract_time);
			$("#contract_number").val(data.contract_number);
			$("#contract_context").val(data.contract_context);
			layer.open({
				title: '查看客户',
				skin: 'layui-layer-rim', //加上边框
				area: ['50%', '70%'], //宽高
				type: 1, //['http://sentsin.com', 'no']
				content: $('#AddForm'),
				shadeClose: true, //点击遮罩关闭
				//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
			});
		 }
		
		if(layEvent === 'del') { //删除
			layer.confirm('真的删除行么', function(index) {
				obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
				layer.close(index);
				//向服务端发送删除指令
				$.ajax({
					url: "${pageContext.request.contextPath}/contract_delete.action",
					type: "POST",
					data: {
						"contract_id": data.contract_id
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
			$("#contract_id").val(data.contract_id);
			$("#cust_id").val(data.customer.cust_id);
			$("#user_id").val(data.user.user_id);
			$("#contract_time").val(data.contract_time);
			$("#contract_number").val(data.contract_number);
			$("#contract_context").val(data.contract_context);
			layer.open({
				title: '修改客户',
				skin: 'layui-layer-rim', //加上边框
				area: ['50%', '70%'], //宽高
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
	//重载table 搜索内容
	//先得到 $ layui内置的jQuery  
	var $ = layui.$,
		active = {
			reload: function() {
				//执行重载 重新加载数据表格 用于搜索
				table.reload('listReload', {
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						"customer.cust_id": $('#search_cust_id').val(),
						"user.user_id": $('#search_user_id').val(),
						"contract_number":$("#search_contract_number").val()
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

//添加时间控件 
layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#contract_time'
	    //指定元素
	  });
	});

layui.use('form', function() {
	var form = layui.form //获取form模块
	form.render();
	//监听提交按钮 更新或者提交客户
	form.on('submit(formDemo)', function(data) {
		$.ajax({
			url: "${pageContext.request.contextPath}/contract_saveOrUpdate.action",
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
					layer.msg("失败,注意合同编号要唯一", {
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