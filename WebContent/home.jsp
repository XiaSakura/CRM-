<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="js/layui/css/layui.css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
</head>
<body class="layui-layout-body">
	<div class="layui-fluid">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md6">
				<div class="layui-card">
					<div class="layui-card-header">客户访问量</div>
					<div class="layui-card-body">
						<div id="chart1" style="width: 100%; height: 670px;"></div>
					</div>
				</div>
				<!-- <div class="layui-card">
					<div class="layui-card-header">客户总数</div>
					<div class="layui-card-body">
						<div id="chart2" style="width: 100%; height: 300px;"></div>
					</div>
				</div> -->
			</div>
			<div class="layui-col-md6">
				<div class="layui-card">
					<div class="layui-card-header">用户访问来源</div>
					<div class="layui-card-body">
						<div id="chart3" style="width: 100%;height: 670px;"></div>
					</div>
				</div>
				<!-- <div class="layui-card">
					<div class="layui-card-header">卡片面板4</div>
					<div class="layui-card-body">
						<div id="chart4" style="width: 100%; height: 300px;"></div>
					</div>
				</div> -->
			</div>
		</div>
	</div>
	<script src="./js/layui/layui.js"></script>
	<script type="text/javascript" src="js/echarts4/echarts.min.js"></script>
	<script>
			layui.use(['element','layer'],function(){
				var element = layui.element
				,layer = layui.layer
				,$ = layui.jquery;	
			});
			
			// 基于准备好的dom，初始化echarts实例
	        var myChart1 = echarts.init(document.getElementById('chart1'));
	     /*    var myChart2 = echarts.init(document.getElementById('chart2')); */
	        var myChart3 = echarts.init(document.getElementById('chart3'));
	     /*    var myChart4 = echarts.init(document.getElementById('chart4')); */
	        // 指定图表的配置项和数据 
	        $.get('js/echarts4/map/json/visit.json').done(function (data) {
	        	 var jsonData=eval(data);
	        	 console.log(jsonData);
	             // 填入数据
	             myChart1.setOption({
	            	  title : {
	  			        text: '本网站的访问量',
	  			        subtext: '纯属虚构'
	  			    },
	  			    tooltip : {
	  			        trigger: 'axis'
	  			    },
	  			    legend: {
	  			        data:['用户访问量']
	  			    },
	  			    toolbox: {
	  			        show : true,
	  			        feature : {
	  			            dataView : {show: true, readOnly: false},
	  			            magicType : {show: true, type: ['line', 'bar']},
	  			            restore : {show: true},
	  			            saveAsImage : {show: true}
	  			        }
	  			    },
	  			    calculable : true,
	  			    xAxis : [
	  			        {
	  			            type : 'category',
	  			            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
	  			        }
	  			    ],
	  			    yAxis : [  
	  			        {
	  			            type : 'value'
	  			        }
	  			    ],	 
	                 series : [
	 			        { 
	 			            name:'用户访问量',
	 			            type:'bar',
	 			            data:[jsonData.visit[0], jsonData.visit[1], jsonData.visit[2], jsonData.visit[3]
	 			            , jsonData.visit[4], jsonData.visit[5], jsonData.visit[6], jsonData.visit[7],
	 			           jsonData.visit[8], jsonData.visit[9], jsonData.visit[10], jsonData.visit[11]],
	 			            markPoint : {
	 			                data : [
	 			                    {name : '年最高', value : jsonData.max[0], xAxis: 7, yAxis: 183},
	 			                    {name : '年最低', value : jsonData.min[0], xAxis: 11, yAxis: 3}
	 			                ]
	 			            },
	 			            markLine : {
	 			                data : [
	 			                    {type : 'average', name : '平均值'}
	 			                ]
	 			            }
	 			        }
	 			    ]
	           });
	        });
	    /*     var option2 = {
			    xAxis: {
			        type: 'category',
			        boundaryGap: false,
			        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
			    },
			    yAxis: {
			        type: 'value'
			    },
			    series: [{
			        data: [820, 932, 901, 934, 1290, 1330, 1320],
			        type: 'line',
			        areaStyle: {}
			    }]
			};
	         */
	        /*  myChart2.setOption({
	        	    title: {
	        	        text: '客户总数'
	        	    },
	        	    tooltip: {},
	        	    legend: {
	        	    	 data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
	        	    },
	        	    xAxis: {
	        	        data: []
	        	    },
	        	    yAxis: {},
	        	    series: [{
	        	        name: '销量',
	        	        type: 'bar',
	        	        data: []
	        	    }]
	        }); */
	     	 // 异步加载数据
	      /*    $.get('customer_findCustomer.action').done(function (data) {
	        	 var jsonData=eval(data);
	        	 console.log(jsonData[1].cust_id);
	             // 填入数据
	             myChart2.setOption({
	                 xAxis: {
	                     data: [jsonData[0].cust_id,jsonData[1].cust_id,jsonData[2].cust_id]
	                 },
	                 series: [{
	                     // 根据名字对应到相应的系列
	                     name: '销量',
	                     data:  [jsonData[0].cust_id,jsonData[1].cust_id,jsonData[2].cust_id]
	                 }]
	             });
	         }); */
	        

	         myChart3.setOption({
	             tooltip: {
	                 trigger: 'item',
	                 formatter: "{a} <br/>{b}: {c} ({d}%)"
	             },
	             legend: {
	                 orient: 'vertical',
	                 x: 'left',
	                 data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他']
	             },
	             series: [
	                 {
	                     name:'访问来源',
	                     type:'pie',
	                     selectedMode: 'single',
	                     radius: [0, '30%'],

	                     label: {
	                         normal: {
	                             position: 'inner'
	                         }
	                     },
	                     labelLine: {
	                         normal: {
	                             show: false
	                         }
	                     },
	                     data:[
	                         {value:335, name:'直达', selected:true},
	                         {value:679, name:'营销广告'},
	                         {value:1548, name:'搜索引擎'}
	                     ]
	                 },
	                 {
	                     name:'访问来源',
	                     type:'pie',
	                     radius: ['40%', '55%'],
	                     label: {
	                         normal: {
	                             formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
	                             backgroundColor: '#eee',
	                             borderColor: '#aaa',
	                             borderWidth: 1,
	                             borderRadius: 4,
	                             // shadowBlur:3,
	                             // shadowOffsetX: 2,
	                             // shadowOffsetY: 2,
	                             // shadowColor: '#999',
	                             // padding: [0, 7],
	                             rich: {
	                                 a: {
	                                     color: '#999',
	                                     lineHeight: 22,
	                                     align: 'center'
	                                 },
	                                 // abg: {
	                                 //     backgroundColor: '#333',
	                                 //     width: '100%',
	                                 //     align: 'right',
	                                 //     height: 22,
	                                 //     borderRadius: [4, 4, 0, 0]
	                                 // },
	                                 hr: {
	                                     borderColor: '#aaa',
	                                     width: '100%',
	                                     borderWidth: 0.5,
	                                     height: 0
	                                 },
	                                 b: {
	                                     fontSize: 16,
	                                     lineHeight: 33
	                                 },
	                                 per: {
	                                     color: '#eee',
	                                     backgroundColor: '#334455',
	                                     padding: [2, 4],
	                                     borderRadius: 2
	                                 }
	                             }
	                         }
	                     },
	                     data:[
	                         {value:335, name:'直达'},
	                         {value:310, name:'邮件营销'},
	                         {value:234, name:'联盟广告'},
	                         {value:135, name:'视频广告'},
	                         {value:1048, name:'百度'},
	                         {value:251, name:'谷歌'},
	                         {value:147, name:'必应'},
	                         {value:102, name:'其他'}
	                     ]
	                 }
	             ]
	         });
	        
			/* $.get('js/echarts4/map/json/gsq.json', function (geoJson) {
			    echarts.registerMap('gsq', geoJson);
			
			   var option3 = {
			        title: {
			            text: '拱墅区人口密度 （2011）',
			            subtext: '人口密度数据来自瑞成系统',
			            sublink: ''
			        },
			        tooltip: {
			            trigger: 'item',
			            formatter: '{b}<br/>{c} (p / km2)'
			        },
			        toolbox: {
			            show: true,
			            orient: 'vertical',
			            left: 'right',
			            top: 'center',
			            feature: {
			                dataView: {readOnly: false},
			                restore: {},
			                saveAsImage: {}
			            }
			        },
			        visualMap: {
			            min: 800,
			            max: 50000,
			            text:['High','Low'],
			            realtime: false,
			            calculable: true,
			            inRange: {
			                color: ['lightskyblue','yellow', 'orangered']
			            }
			        },
			        series: [
			            {
			                name: '拱墅区人口密度',
			                type: 'map',
			                mapType: 'gsq', // 自定义扩展图表类型
			                itemStyle:{
			                    normal:{label:{show:true}},
			                    emphasis:{label:{show:true}}
			                },
			                data:[
			                    {name: '米市巷街道', value: 20057.34},
			                    {name: '小河街道', value: 15477.48},
			                    {name: '上塘街道', value: 31686.1},
			                    {name: '湖墅街道', value: 6992.6},
			                    {name: '康桥街道', value: 44045.49},
			                    {name: '半山街道', value: 40689.64},
			                    {name: '和睦街道', value: 37659.78},
			                    {name: '拱宸桥街道', value: 45180.97},
			                    {name: '祥符街道', value: 55204.26},
			                    {name: '大关街道', value: 21900.9}
			                ],
			                // 自定义名称映射
			                nameMap: {
			                    'msx': '米市巷街道',
			                    'xh': '小河街道',
			                    'st': '上塘街道',
			                    'hs': '湖墅街道',
			                    'kq': '康桥街道',
			                    'bs': '半山街道',
			                    'hm': '和睦街道',
			                    'gcq': '拱宸桥街道',
			                    'xf': '祥符街道',
			                    'dg': '大关街道'
			                }
			            }
			        ]
			    };
			   
			   
			    myChart3.setOption(option3);
			}); */
			/* var option4 = {
			    title: {
			        text: '未来一周气温变化',
			        subtext: '纯属虚构'
			    },
			    tooltip: {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['最高气温','最低气温']
			    },
			    toolbox: {
			        show: true,
			        feature: {
			            dataZoom: {
			                yAxisIndex: 'none'
			            },
			            dataView: {readOnly: false},
			            magicType: {type: ['line', 'bar']},
			            restore: {},
			            saveAsImage: {}
			        }
			    },
			    xAxis:  {
			        type: 'category',
			        boundaryGap: false,
			        data: ['周一','周二','周三','周四','周五','周六','周日']
			    },
			    yAxis: {
			        type: 'value',
			        axisLabel: {
			            formatter: '{value} °C'
			        }
			    },
			    series: [
			        {
			            name:'最高气温',
			            type:'line',
			            data:[11, 11, 15, 13, 12, 13, 10],
			            markPoint: {
			                data: [
			                    {type: 'max', name: '最大值'},
			                    {type: 'min', name: '最小值'}
			                ]
			            },
			            markLine: {
			                data: [
			                    {type: 'average', name: '平均值'}
			                ]
			            }
			        },
			        {
			            name:'最低气温',
			            type:'line',
			            data:[1, -2, 2, 5, 3, 2, 0],
			            markPoint: {
			                data: [
			                    {name: '周最低', value: -2, xAxis: 1, yAxis: -1.5}
			                ]
			            },
			            markLine: {
			                data: [
			                    {type: 'average', name: '平均值'},
			                    [{
			                        symbol: 'none',
			                        x: '90%',
			                        yAxis: 'max'
			                    }, {
			                        symbol: 'circle',
			                        label: {
			                            normal: {
			                                position: 'start',
			                                formatter: '最大值'
			                            }
			                        },
			                        type: 'max',
			                        name: '最高点'
			                    }]
			                ]
			            }
			        }
			    ]
			}; */
	        // 使用刚指定的配置项和数据显示图表。
	        
	     /*    myChart2.setOption(option2); */
	        /* myChart3.setOption(option3);
	        myChart4.setOption(option4); */
		</script>
</body>
</html>
