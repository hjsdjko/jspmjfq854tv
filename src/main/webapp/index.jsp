<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="jsp/static/head.jsp"%>
</head>
<style>
	#home-container {
				padding: 30px;
				background: url(http://codegen.caihongy.cn/20221215/1429d19bfd9b4b97b01069020f735ae3.png) no-repeat center 50px,linear-gradient(0deg, rgba(255,255,255,1) 0%, rgba(255,255,255,.96) 100%);
				min-height: 100vh;
			}
	
	#home-container div.home-container-title {
				margin: 50px auto;
				transform: rotate(360deg);
				color: #333;
				background: url() no-repeat center center;
				font-weight: bold;
				display: none;
				width: 665px;
				font-size: 32px;
				line-height: 60px;
				transition: all 0.3s ease-in-out 0s;
				text-align: center;
				height: 60px;
			}
	
	#home-container .cards {
				margin: 180px 0 20px 0;
				display: flex;
				justify-content: center;
				align-items: center;
			}
	
	#home-container .cards .item {
				border: 1px solid #eee;
				border-radius: 0px;
				box-shadow: 0 0px 0px rgba(0,0,0,.3);
				margin: 0 10px;
				display: flex;
			}
	
	#home-container .cards .item .link {
				background: url(http://codegen.caihongy.cn/20221215/2d0194302b9347c9ab6966f0b85e5f20.png) no-repeat center top / 100% 100%,#fff;
				width: 80px;
				height: 80px;
			}
	
	#home-container .cards .item .item-body {
				flex-direction: column;
				display: flex;
				width: 160px;
				justify-content: center;
				align-items: center;
			}
	
	#home-container .cards .item .item-body .num {
				margin: 5px 0;
				color: #333;
				font-weight: bold;
				font-size: 20px;
				line-height: 24px;
				height: 24px;
			}
	
	#home-container .cards .item .item-body .name {
				margin: 5px 0;
				color: #666;
				font-size: 16px;
				line-height: 24px;
				height: 24px;
			}
	
    .homeCharts{
        display: flex;
        width: 100%;
        align-items: center;
        height: auto;
        box-shadow: 0 4px 10px rgba(0,0,0,.3);
        border-radius: 10px;
        margin-bottom: 20px;
    }
</style> 
<body>
	<div id="main-container">
		<!-- Top Navigation -->
		<%@ include file="jsp/static/topNav.jsp"%>
		
		<!-- Menu -->
		<div id="menu-container" class="navbar">
			<ul class="navbar-nav navbar-horizontal" id="navUl">
				
			</ul>
		</div>
		<!-- /Menu -->
			
		<!-- Breadcrumb -->
		<div id="breadcrumb-container">
			<h3 class="breadcrumb-title">主页</h3>
			<ol class="breadcrumb-list">
				<li class="breadcrumb-item-home">
					<a href="#">
						<span class="ti-home"></span>
					</a>
				</li>
			</ol>
		</div>
		<!-- /Breadcrumb -->
			
		<!-- Main Content -->
		<div id="home-container">
			<div class="home-container-title">欢迎使用&nbsp;基于JSP高校研招信息共享系统的设计与实现</div>
			
			<div class="cards" :style='{"margin":"180px 0 20px 0","alignItems":"center","justifyContent":"center","display":"flex"}'>
				<div class="item" :style='{"border":"1px solid #eee","boxShadow":"0 0px 0px rgba(0,0,0,.3)","margin":"0 10px","borderRadius":"0px","display":"flex"}' v-if="crossBtnControl2('zhaoshengxinxi','首页总数')">
					<div class="link" :style='{"width":"80px","background":"url(http://codegen.caihongy.cn/20221215/2d0194302b9347c9ab6966f0b85e5f20.png) no-repeat center top / 100% 100%,#fff","height":"80px"}'></div>
					<div class="item-body" :style='{"width":"160px","alignItems":"center","flexDirection":"column","justifyContent":"center","display":"flex"}'>
						<div class="num" :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"20px","color":"#333","fontWeight":"bold","height":"24px"}'>{{zhaoshengxinxiCount}}</div>
						<div class="name" :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"16px","color":"#666","height":"24px"}'>招生信息总数</div>
					</div>
				</div>
			</div>
			
			<div class="homeCharts">
				<div id="zhaoshengxinxiMain1" v-if="crossBtnControl2('zhaoshengxinxi','首页统计')" class="graph" style="width: 100%;height:300px;"></div>
			</div>
		</div>
		<!-- /Main Content -->
	</div>
	
	<!-- Back to Top -->
	<a id="back-to-top" href="#" class="back-to-top">Top</a>
	<!-- /Back to Top -->
	
	<%@ include file="jsp/static/foot.jsp"%>
    <script src="${pageContext.request.contextPath}/resources/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/vue.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/echarts/theme/carp.js"></script>

	<script>
		<%@ include file="jsp/utils/menu.jsp"%>
		<%@ include file="jsp/static/setMenu.js"%>
		<%@ include file="jsp/utils/baseUrl.jsp"%>
        <%@ include file="jsp/static/crossBtnControl.js"%>
		// 用户登出
        <%@ include file="jsp/static/logout.jsp"%>
        var vm = new Vue({
            el: '#home-container',
            data: {
            zhaoshengxinxiCount: 0,
            }
        });
        function getzhaoshengxinxiCount() {
                $.ajax({
                    type: "GET",
                    url: baseUrl+`zhaoshengxinxi/count`,
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("token", window.sessionStorage.getItem('token'));
                    },
                    success: function(data){
                        if(data.code == 0){
                            vm.zhaoshengxinxiCount = data.data;
                        }else if(data.code == 401){
                            <%@ include file="jsp/static/toLogin.jsp"%>
                        }else{
                            alert(data.msg);
                        }
                    },
                });
        }

                function zhaoshengxinxichartDialog1(){

                    $.ajax({
                        type: "GET",
                        url: baseUrl+`zhaoshengxinxi/value/xuexiaomingcheng/baomingrenshu`,
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader("token", window.sessionStorage.getItem('token'));
                        },
                        success: function(data){
                            if(data.code == 0){
                                if(data.data != null){
                                    let res = data.data;
                                    let xAxis = [];
                                    let yAxis = [];
                                    let pArray = []
                                    for(let i=0;i<res.length;i++){
                                        xAxis.push(res[i].xuexiaomingcheng);
                                        yAxis.push(parseFloat((res[i].total)));
                                        pArray.push({
                                            value: parseFloat((res[i].total)),
                                            name: res[i].xuexiaomingcheng
                                        })
                                    }

                                    var myChart = echarts.init(document.getElementById('zhaoshengxinxiMain1'),'carp');
                                    var option = {};
                                    option = {
                                        title: {
                                            text: '报名统计',
                                            left: 'center'
                                        },
                                        tooltip: {
                                          trigger: 'item',
                                          formatter: '{b} : {c}'
                                        },
                                        xAxis: {
                                            type: 'category',
                                            data: xAxis
                                        },
                                        yAxis: {
                                            type: 'value'
                                        },
                                        series: [{
                                            data: yAxis,
                                            type: 'bar'
                                        }]
                                    };

                                    // 使用刚指定的配置项和数据显示图表。
                                    myChart.setOption(option);
                                }
                            }else if(data.code == 401){
                                <%@ include file="jsp/static/toLogin.jsp"%>
                            }else{
                                alert(data.msg);
                            }
                        },
                    });
                }







		$(document).ready(function() {
		//我的后台,session信息转移
		if(window.localStorage.getItem("Token") != null && window.localStorage.getItem("Token") != 'null'){
			  if(window.sessionStorage.getItem("token") == null || window.sessionStorage.getItem("token") == 'null'){
				  window.sessionStorage.setItem("token",window.localStorage.getItem("Token"));
				  window.sessionStorage.setItem("role",window.localStorage.getItem("role"));
				  window.sessionStorage.setItem("accountTableName",window.localStorage.getItem("sessionTable"));
				  window.sessionStorage.setItem("username",window.localStorage.getItem("adminName"));
			  }
		  }			
          $('.dropdown-menu h5').html(window.sessionStorage.getItem('username')+'('+window.sessionStorage.getItem('role')+')')
		  $('.sidebar-header h3 a').html(projectName)
		  var token = window.sessionStorage.getItem("token");
		  if(token == "null" || token == null){
		  	alert("请登录后再操作");
		  	window.location.href = ("jsp/login.jsp");
		  }
			setMenu();
			<%@ include file="jsp/static/myInfo.js"%>
            getzhaoshengxinxiCount();
            zhaoshengxinxichartDialog1()
		});
	</script>
</body>

</html>
