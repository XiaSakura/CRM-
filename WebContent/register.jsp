<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="js/layui/css/layui.css" />
</head>
<body class="layui-layout-body">
	<div class="layui-fluid">
		<form class="layui-form layui-card-body" lay-filter="Aform" action="">
			<div class="layui-form-item">
				<label class="layui-form-label"><i
					class="layui-icon layui-icon-username"></i></label>
				<div class="layui-input-block">
					<input name="user_code" class="layui-input" type="text"
						placeholder="请输入账号" autocomplete="off" />
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><i
					class="layui-icon layui-icon-password"></i></label>
				<div class="layui-input-block">
					<input name="user_password" class="layui-input" type="password"
						placeholder="请输入密码" autocomplete="off" />
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
					<input type="radio" name="user_gender" value="女" title="女" checked>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">用户QQ</label>
				<div class="layui-input-block">
					<input type="text" name="user_qq" lay-verify="required"
						id="user_qq" lay-verify="required" placeholder="请输入用户QQ"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">用户邮箱</label>
				<div class="layui-input-block">
					<input type="text" name="user_email" lay-verify="email"
						id="user_email" lay-verify="required" placeholder="请输入用户邮箱"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<a class="layui-btn layui-btn-blue" lay-submit
						lay-filter="regist">注册</a>
					<button type="reset" class="layui-btn layui-btn-primary" id="reset">重置</button>
				</div>
			</div>
		</form>
	</div>
	<script src="./js/layui/layui.js"></script>
	<script>
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form, $ = layui.jquery;
			//监控表单提交
			form.on('submit(regist)', function(data) {
				var obj = data.field;
				$.ajax({
					url : "user_regist.action",
					type : "post",
					dataType : "json",
					data : obj,
					success : function(data) {
						if (data.msg == "1") {
							layer.msg("注册成功", {
								icon : 6
							});
							
							setInterval(function() {
								parent.layer.closeAll();
							}, "1000");
						} else {
							layer.msg("注册失败,账号重复", {
								icon : 5
							});
						}
					}
				});
				return false;
			});
		})
		//登陆按钮绑定回车
		function onEnter() {
			if (window.event.keyCode == 13) {
				document.getElementsByTagName("button")[0].click();
			}
		}
	</script>
</body>
</html>
