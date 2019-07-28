<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="js/layui/css/layui.css" />
<link rel="stylesheet" href="css/login.css" />
</head>
<body class="layui-layout-body" onkeydown="onEnter();">
	<div class="layui-fluid" style="padding: 0px;">
		<canvas id="particle"></canvas>
		
			<div class="layui-form layui-form-pane layui-admin-login">
				<div class="layui-admin-login-header">
				<h1>后台登陆</h1>
				<p>BY xia</p>
				<p ><s:actionerror style="color: white;"/></p>
				<p style="color: white;"><s:fielderror/></p>
			</div>
		
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
				<input type="checkbox" pane name="remember" title="记住密码"
					lay-skin="primary"> <a href="javascript:;"
					style="margin-top: 10px; float: right; color: #009688;">忘记密码?</a>
			</div>
			<div class="layui-form-item">
				<div class="layui-btn-container">
					<button class="layui-btn layui-btn-fluid" lay-submit
						lay-filter="login">
						<i class="layui-icon layui-icon-ok-circle"></i>登陆
					</button>
				</div>
			</div>
			<div class="layui-form-item">
			<div class="layui-btn-container">
					<button class="layui-btn layui-btn-fluid" lay-submit
						lay-filter="register">
						<i class="layui-icon layui-icon-add-circle"></i>注册
					</button>
				</div>
			</div>
			<!--底部-->
			<div class="layui-footer">© BY xia</div>
		</div>
	</div>
	<script src="./js/layui/layui.js"></script>
	<script type="text/javascript" src="js/particle.min.js"></script>
	<script>
			layui.use(['layer','form'],function(){
				var layer = layui.layer
				,form = layui.form
				,$ = layui.jquery;
				//监控表单提交
				form.on('submit(login)', function(data) {
					$.ajax({
					url: "user_login.action",
							type: "post",
							dataType: "json",
							data: {
								"user_code": data.field.user_code,
								"user_password": data.field.user_password
							},
							success: function(data) {
								if(data.msg == "1") {
									layer.msg("登录成功", {
										icon: 6
									});
									setInterval(function(){
										parent.document.location.href="./index.jsp";
									},"1000");
								} else {
									layer.msg("登录失败,请检查账号密码", {
										icon: 5
									});
								}
							}
						});
					return false;
					});
				/* form.on('submit(login)', function(data){
					var obj = data.field;
					$.ajax({
						url: "/user_login.action",
						type: "POST",
						data: {
							"user_name": data.user_name,
							"user_password": data.user_password
						},
						dataType: "json",
						success: function(data) {
							if(data.msg == "1") {
								layer.msg("登录成功", {
									icon: 6
								});
								setInterval(function(){
									window.location.href="./index.html";
								},"1000");
							} else {
								layer.msg("登录失败", {
									icon: 5
								});
							}
						}
					});
					/* if(obj.username=="admin"&&obj.userpassword=="123456"){
						window.location.href="./index.html";
					}else{
						layer.msg('账号或密码不正确', {icon: 5});
					} */
				
				//监控注册
				form.on('submit(register)', function(data){
					layer.open({
						title:"用户注册",
						type: 2,
						content:"./register.jsp",
						area: ['40%', '60%']
					});
				});
			})
			//登陆按钮绑定回车
			function onEnter(){
				if(window.event.keyCode == 13){
					document.getElementsByTagName("button")[0].click();
				}
			}
			var particle = new Particle('#particle', {
				effect: 'line'
			});
		</script>
</body>
</html>
