<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
</head>
<body>
<script type="text/javascript"  src="../static/layui/layui.js"></script>

<!-- 搜索添加 -->
	<div class="serachTable">
		搜索姓名：
		<div class="layui-inline">
			<input id="inputName" name="names" 
				placeholder="请输入姓名" class="layui-input" autocomplete="off">
		</div>
		<button  id="serachName" type="button" class="layui-btn">
		   <i class="layui-icon">&#xe615;</i>搜索
		</button>
		<button id="refreshper" type="button" class="layui-btn">
		   <i class="layui-icon">&#xe669;</i>刷新
		</button>
		<button id="addBtn" type="button" class="layui-btn">
			<i class="layui-icon"></i>添加
		</button>
	</div>

	<!-- 编辑和删除 -->
<script type="text/html" id="personBtn">
<a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
</script>

<table id="perTable"  lay-filter="perSelectRow"></table>

	<script>
	/* 表格数据渲染 */
		layui.use('table', function() {
			var  personTable= layui.table;
		var tableIns = personTable.render({
				elem : '#perTable',
				height : 485,
				url : './findAllParam',
				method : 'GET',
				page:true,
				limit : 10,
				limits : [ 10, 15, 20 ],
				loading : false,
				skin:'line',
				cols : [ [ {
					type : 'checkbox',
					align : 'center',
					width : 100
				}, {
					field : 'id',
					title : 'ID',
					align : 'center',
					width : 100
				}, {
					field : 'name',
					title : '用户名',
					align : 'center',
					width : 100
				}, {
					field : 'age',
					title : '年龄',
					align : 'center',
					width : 100
				}, {
					field : 'city',
					title : '城市',
					align : 'center',
					width : 100
				}, {
					title : '操作',
					width: 150, 
					align : 'center',
					toolbar:"#personBtn"
				} 
				] ],
				});
		
			
	      /* 搜索姓名
	      */
		     var $ = layui.$;
				$('#serachName').on('click', function() {
				var inpName = $('#inputName');
				//执行重载
				personTable.reload('perTable', {
					where : {
						personName : inpName.val()
					}
				});
				//搜索后清空输入框内容
				document.getElementById("inputName").value = "";
			});
				
			/*刷新表格 */
			 $("#refreshper").on('click',function(){
				 //刷新整个表格
				 window.parent.location.reload();
			});	 
	});
		
		 
        
	
	/* layui弹出层,添加用户信息  */
	
		layui.use('jquery', function() {
			var $ = layui.$;
			$("#addBtn").on('click', function() {
				layui.use([ 'layer', 'form' ], function() {
					var addPopups = layui.layer;
					addPopups.open({
						type : 2,
						title : '添加信息',
						content : 'addPerson',
						area : [ '500px', '350px' ]
					});
				});
			});
		});
	
	/* 编辑用户信息   */
	layui.use(['table','layer','jquery'],function(){
		var tabper = layui.table;
		var layer = layui.layer;
		var $ = layui.jquery;
		tabper.on('tool(perSelectRow)',function(obj){

		//dataper:{"id":6,"name":"刘八","age":14,"city":"杭州"}
		var dataper = obj.data;  
	    var layEvent = obj.event;  //del
		if(layEvent === 'edit'){
			layer.open({
				type : 2,
				title : '修改信息',
				content : 'updatePerson',
				area : [ '500px', '350px' ],
				//获取body中的input输入框的内容
				success:function(layero,index){
				//获取body内容
				var perbody = layer.getChildFrame('body',index);
				//得到ifrmae的窗口对象
				var iframeWin = window[layero.find('iframe')[0]['name']];
				//执行iframe方法
				perbody.find('#pesId').val(dataper.id);
				perbody.find('#pesName').val(dataper.name);
				perbody.find('#pesAge').val(dataper.age);
				perbody.find('#pesCity').val(dataper.city);
				
				}
			});
		} else {
		
			layer.confirm('真的删除ID为'+dataper.id+'的用户么',function(index){
               $.ajax({
            	url:'deleteById',
            	type:'GET',
            	data:{'id':dataper.id},   
            	success:function(data){
            		if (data.code == 200) {
            			layer.msg(data.msg,{icon:6,time:900});
            			//刷新当前页20190611。 有个问题待解决：删除页面只有一条的数据后且刷新了但没有数据显示了
            			layui.table.reload('perTable',{page:{curr:$(".layui-laypage-em").next().html()}});
            			 //刷新整个表格
    				    window.parent.location.reload();
            		} else {
            			layer.msg(data.msg,{icon:6,time:900});
            		}
            	}
               })
				obj.del();
				layer.close(index);
			})
		}
		});
		
	});
	
	
	
	
	</script>
</body>
</html>