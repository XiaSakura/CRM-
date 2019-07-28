<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title></title>
<link rel="stylesheet" href="./js/layui/css/layui.css" />
<link rel="stylesheet" href="css/index.css" />
<script>
			//iframe高度自适应
			function setIframeHeight(iframe) {
				if (iframe) {
					var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
					if (iframeWin.document.body) {
						iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
					}
				}
			};
		</script>
</head>
<body class="layui-layout-body" style="height: 1000px">
	<div class="layui-layout layui-layout-admin">
		<!--头部-->
		<div class="layui-header">
			<!--头部左侧导航-->
			<ul class="layui-nav layui-layout-left" lay-filter="leftmenu">
				<li class="layui-nav-item"><a href="javascript:;"
					class="hidetab" title="隐藏左侧菜单"><i
						class="layui-icon layui-icon-shrink-right"></i></a></li>
				<li class="layui-nav-item"><a href="./index.jsp" title="主页"><i
						class="layui-icon layui-icon-home"></i></a></li>
				<li class="layui-nav-item"><a
					href="javascript:window.location.reload();" title="刷新"><i
						class="layui-icon layui-icon-refresh-3"></i></a></li>
				<li class="layui-nav-item layui-hide-xs"><input
					class="layui-input layui-input-search" type="text" placeholder="搜索"
					autocomplete="off" /></li>
			</ul>
			<!--头部右侧导航-->
			<ul class="layui-nav layui-layout-right" lay-filter="rightmenu">
				<li class="layui-nav-item"><a href="javascript:;"><i id="user_name"
						class="layui-icon layui-icon-user" style="padding-right: 20px"></i><s:property value="#session.existUser.user_name"/>
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:;" lay-href="./userinfo.jsp"><i
								class="layui-icon layui-icon-form"></i>基本资料</a>
						</dd>
						<dd>
							<a href="javascript:;" lay-href="./changepassword.html"><i
								class="layui-icon layui-icon-password"></i>修改密码</a>
						</dd>
					</dl></li>
				
				<li class="layui-nav-item"><a href="./login.jsp">退出</a></li>
			</ul>
		</div>
		<!--左侧-->
		<div class="layui-side layui-side-menu">
		
			<!--带滚动条垂直导航-->
			<div class="layui-side-scroll layui-bg-black">
				<div class="layui-logo">CRM后台管理系统</div>
				<ul class="layui-nav layui-nav-tree" lay-filter="navtree">
					<!--默认展开-->
					<li class="layui-nav-item layui-nav-itemed"><a
						href="javascript:;" lay-href="./home.jsp" title="主页"><i
							class="layui-icon layui-icon-home"></i><cite>主页</cite></a></li>
					<li class="layui-nav-item"><a href="javascript:;" title="客户"><i
							class="layui-icon layui-icon-friends"></i><cite>客户</cite></a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" lay-href="./customer_saveUI.action">客户管理</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="javascript:;" title="联系人"><i
							class="layui-icon layui-icon-group"></i><cite>联系人</cite></a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" lay-href="./linkMan_saveUI.action">联系人管理</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="javascript:;" title="用户"><i
							class="layui-icon layui-icon-user"></i><cite>用户</cite></a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" lay-href="./user_saveUI.action">用户管理</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="javascript:;" title="跟进"><i
							class="layui-icon layui-icon-user"></i><cite>跟进记录</cite></a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" lay-href="./saleVisit_saveUI.action">跟进管理</a>
							</dd>
						</dl></li>
						<li class="layui-nav-item"><a href="javascript:;" title="合同"><i
							class="layui-icon layui-icon-user"></i><cite>合同</cite></a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" lay-href="./contract_saveUI.action">合同管理</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="javascript:;" title="设置"><i
							class="layui-icon layui-icon-set"></i><cite>设置</cite></a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" lay-href="./set.jsp">系统设置</a>
							</dd>
						</dl></li>
				</ul>
			</div>
		</div>
		<!--正文-->
		<div class="layui-body layui-bg-gray">
			<!--选项卡-->
			<div class="layui-admin-pagetabs">
				<div class="layui-tab layui-tab-brief" lay-allowClose="true"
					lay-filter="pagetabs">
					<!--选项卡上面的标题 需要对应左侧点击的-->
					<ul class="layui-tab-title layui-bg-white">
						<li class="layui-this" lay-id="./home.jsp"><i
							class="layui-icon layui-icon-home"></i></li>
					</ul>
					<div class="layui-tab-content">
						<div class="layui-tab-item layui-show">
							<iframe src="home.jsp" class="layui-admin-iframe" scrolling="no"
								frameborder="0" onload="setIframeHeight(this);"></iframe>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!--底部-->
		<div class="layui-footer">© 阿拉垃圾君</div>
	</div>
	<script src="./js/layui/layui.js"></script>
	<script>
			layui.use(['element','layer'],function(){
				//对页面上的element所有元素进行监控 layer监控了layui的所有层次
				var element = layui.element,layer = layui.layer,
				$ = layui.jquery; //导入jq layui内嵌了jq
				
				
				//隐藏tab主页关闭标签 tab栏上面的关闭标签
				$(".layui-tab-title li:first-child i:last-child").css("display","none");
				//tab点击监控 
				element.on('tab(pagetabs)',function(data){
					//tab切换时，左侧菜单对应选中  就是蓝色的那条 
					var url = $(this).attr("lay-id");
					$(".layui-nav-tree li dd").each(function(i,e){
						if($(this).find("a").attr("lay-href")==url){
							$(this).attr("class","layui-this");
						}else{
							$(this).attr("class","");
						}
					})
				});
				//顶部左侧菜单监控
				element.on('nav(leftmenu)',function(elem){
					//隐藏显示侧边菜单
					if(elem[0].className=="hidetab"){//隐藏 
						//侧边菜单伸缩
						$(".layui-side-menu").animate({width:$(".layui-side-menu").width()-144+"px"});
						//正文伸缩
						$(".layui-body").animate({left:$(".layui-body").position().left-144+"px"});
						//底部伸缩
						$(".layui-footer").animate({left:$(".layui-footer").position().left-144+"px"});
						$(this).attr("class","showtab");
						$(this).find("i").attr("class","layui-icon layui-icon-spread-left");
						//侧边菜单只显示图标
						$(".layui-nav-tree").find("li").each(function(em,ind){
							$(this).find("cite").css("display","none");
							$(this).find("dl").css("display","none");
						});
					}else if(elem[0].className=="showtab"){//显示  点击显示左侧菜单出现的动画
						$(".layui-side-menu").animate({width:$(".layui-side-menu").width()+144+"px"});
						$(".layui-body").animate({left:$(".layui-body").position().left+144+"px"});
						$(".layui-footer").animate({left:$(".layui-footer").position().left+144+"px"});
						$(this).attr("class","hidetab");
						$(this).find("i").attr("class","layui-icon layui-icon-shrink-right");
						$(".layui-nav-tree").find("li").each(function(em,ind){
							$(this).find("cite").css("display",""); //去掉none
							$(this).find("dl").css("display","");
						});
					}
				});
				//顶部右侧菜单监控
				/*element.on('nav(rightmenu)',function(elem){
					var url = $(this).attr("lay-href");
					if(url!=undefined){
						layer.open({
							title:elem[0].innerText,
							type: 2,
							content:url,
							area: ['600px', '500px']
						});
					}
					if(elem[0].innerText=="锁屏"){
						layer.open({
							title:"已锁屏"
							,content: '<input name="pass" class="layui-input" type="text" placeholder="请输入密码,默认123123" autocomplete="off"/>'
							,btnAlign: 'c'
							,anim: 1
							,btn: ['解锁']
							,yes: function(index, layero){
								var pass = layero.find('.layui-layer-content input').val();
								if(pass=="123123"){
						    		layer.close(index);
								}else{
									layer.title("密码不正确！", index);
								}
							}
							,cancel: function(){ 
						    	return false //开启该代码可禁止点击该按钮关闭
							}
						});
					}
				})*/
				//左侧垂直菜单监控
				element.on('nav(navtree)',function(elem){
					if($(".layui-side-menu").width()<200){
						$(".layui-side-menu").animate({width:$(".layui-side-menu").width()+144+"px"});
						$(".layui-body").animate({left:$(".layui-body").position().left+144+"px"});
						$(".layui-layout-left li:first-child").find("a").attr("class","hidetab");
						$(".layui-layout-left li:first-child").find("i").attr("class","layui-icon layui-icon-shrink-right");
						$(".layui-nav-tree").find("li").each(function(em,ind){
							$(this).find("cite").css("display","");
							$(this).find("dl").css("display","");
						});
					}else{
						if($(this).attr("lay-href")!=undefined){
							var  flag = true;
							//url
							var url = $(this).attr("lay-href");
							//判断选项卡中是否存在已打开的页面，如果有直接切换到打开页面
							$(".layui-tab-title li").each(function(i,e){
								if($(this).attr("lay-id")==url){
									//切换选项卡
									element.tabChange('pagetabs', url);
									flag = false;
								}
							})
							if(flag){
								//新增选项卡    在上面的pagetabs layui的添加选项卡内容 url是从lay-href 截取出来的
								//navtree 下的lay-href 修改这个就可以 打开新的iframe 利用tabAdd
								element.tabAdd('pagetabs', {
								  title: elem[0].innerText
								  ,content: '<iframe src="'+url+'" id="parentIframe" scrolling="no" frameborder="0" class="layui-admin-iframe "  onload="setIframeHeight(this);" ></iframe>'
								  ,id: url
								});
								//切换选项卡
								element.tabChange('pagetabs', url);
							}
						}
					}
				});
			});
		</script>
</body>
<script color="FF,99,5" opacity="1" count="99" zIndex="-2"
	src="https://cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.js"
	type="text/javascript" charset="utf-8"></script>
</html>
