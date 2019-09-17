<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="./static/layui/css/layui.css" media="all">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Today</title>
</head>
<body>
<script type="text/javascript"  src="./static/layui/layui.js"></script>
<script type="text/html" id="personBar">
  <a class="layui-btn layui-btn-xs "  lay-event="edit"><i class="layui-icon">&#xe642;</i> 编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe640;</i> 删除</a>
</script>


<!--新增搜索按钮  -->
	<div class="demoTable">
		搜索ID：
		<div class="layui-inline">
			<input class="layui-input" name="id" id="demoReload"
				autocomplete="off">
		</div>
		<button class="layui-btn"  type="button"  id="serachper">
		<i class="layui-icon">&#xe615;</i>搜索
		</button>
		<button class="layui-btn"  type="button"  id="refreshperson">
		<i class="layui-icon">&#xe669;</i>刷新
		</button>
		<button id="addBtn" class="layui-btn" type="button">
			<i class="layui-icon">&#xe654;</i>新增
		</button>
	</div>

	<table id="perTable"  lay-filter="persoTable"></table>
	
<script>
	/* 表格数据渲染 */
		layui.use('table', function() {
			var  personTable= layui.table;
			personTable.render({
				elem : '#perTable',
				height : 485,
				url : './person/findAllParam',
				method : 'GET',
                page:true,
                limit: 10,
                limits:[10,20,30],
                loading:false,
                
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
					width: 170, 
					align : 'center',
					toolbar:"#personBar"
				} 
				] ]
				
				});
		});
	
	/* 对用名进行模糊搜搜 */
	layui.use(['jquery','table'],function(){
		var $ = layui.jquery;
		var tableper = layui.table;
		$("#serachper").on('click',function(){
			//获取输入框的数据
			var inputper = $("#demoReload");
			
			//执行重载
			tableper.reload('perTable',{
				 url:'./person/selectPerName',
				 where:{
					 pername:inputper.val()
				 }
			});
			//搜索后清空输入框内容
			document.getElementById("demoReload").value = "";
		})
		
		/*刷新这个数据表格 refreshperson  */
		$("#refreshperson").on('click',function(){
			window.parent.location.reload();
		})
		
	});
	
	
	
	
	
	/* 用户表新增功能 */
	layui.use(['layer','jquery'], function(){
         var perLayer = layui.layer;
         var $ = layui.jquery;
         $("#addBtn").on('click',function(){
        	 perLayer.open({
           	  type: 2,
           	  title: '新增页面',
           	  shadeClose: false,
           	  shade: 0.3,
           	  area : [ '600px', '350px' ],
           	  content: './person/personAdd' 
           	}); 
        	 
         });
});    

	/* 编辑数据 */
	layui.use(['layer','table','jquery'],function(){
		var perlayer = layui.layer,
		 pertable =layui.table,$ = layui.jquery;
		
		pertable.on('tool(persoTable)', function(obj){ 
			//perdata: { id: 11, name: "朱红189流", age: 1556, city: "海" }
			var perdata = obj.data;
            var layevent = obj.event;  
             //进行修改和删除
			if (layevent === 'edit') {
				layer.open({
					  type: 2,
					  title: '修改页面',
					  shadeClose: false,
					  shade: 0.8,
					  area: ['600px', '350px'],
					  content: './person/personUpdate',
					  success: function(layero, index){
					    var body = layer.getChildFrame('body', index);
					    //得到iframe页的窗口对象，
					    var iframeWin = window[layero.find('iframe')[0]['name']]; 
					    body.find('#updId').val(perdata.id);
					    body.find('#updName').val(perdata.name);
					    body.find('#updAge').val(perdata.age);
					    body.find('#updCity').val(perdata.city);
					   
					    
						  }
					}); 
			} else {
				
				perlayer.confirm('真的删除ID为 ' + perdata.id +' 么?' , function(index){
					$.ajax({
						url:'./person/deleteId',
						type:'get',
						data:{"id":perdata.id},
						success:function(data){
							perlayer.msg("删除成功",{icon: 6,time: 850});
							  //刷新当前页20190611。 有个问题待解决：删除页面只有一条的数据后且刷新了但没有数据显示了
							//layui.table.reload('perTable',{page:{curr:$(".layui-laypage-em").next().html()}});
							//刷新整个表格
							window.parent.location.reload(); 
						}
					})
			        obj.del(); 
					perlayer.close(index);
				})
			}
		})
	})
	
		
	</script>
</body>
</html>