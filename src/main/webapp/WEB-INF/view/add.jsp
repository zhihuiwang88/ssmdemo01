<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="../static/layui/css/layui.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript" src="../static/layui/layui.js"></script>
	<h2>添加页面</h2>


<form class="layui-form"  style="margin:20px">
		<div class="layui-form-item">
			<label class="layui-form-label">姓名：</label>
			<div class="layui-input-block">
				<input type="text" name="persoName"  lay-verify="required" 
				 placeholder="请输入姓名" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">年龄：</label>
			<div class="layui-input-inline">
				<input type="text" name="personAge"  lay-verify="number"
				 placeholder="请输入年龄" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">城市：</label>
			<div class="layui-input-inline">
				<input type="text" name="personCity"  lay-verify="required" 
				placeholder="请输入城市" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				<button class="layui-btn" lay-submit lay-filter="perForm">立即添加</button>
			</div>
		</div>
	</form>

	<script type="text/javascript">
		layui.use(['form','jquery','layer','table'], function() {
			var perForm = layui.form;
			var $ = layui.jquery;
			var layer = layui.layer;
			var personTable = layui.table;
			//监听提交
		perForm.on('submit(perForm)', function(data) {
				$.ajax({
					url : './insertParam',
					type : 'post',
					data : data.field,
					success : function(res) {
						if (res.code == 200) {
							var index = parent.layer.getFrameIndex(window.name);
							parent.layer.msg(res.msg, {icon: 6,time:1100});
							parent.layer.close(index);
							//刷新整个表格
							window.parent.location.reload();
						} else {
							parent.layer.msg(res.msg, {icon: 5,time:1100});
						}
						
					}})
					return false;
				})
				
		});
	</script>
















</body>
</html>