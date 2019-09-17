<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../static/layui/css/layui.css" media="all">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript"  src="../static/layui/layui.js"></script>
<h4>欢迎你来到新增页面</h4>



<form class="layui-form" action=""  style="margin:10px">
  <div class="layui-form-item">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-block">
      <input type="text" name="perName"  autocomplete="off" lay-verify="required" placeholder="请输入姓名" class="layui-input">
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label">年龄</label>
    <div class="layui-input-block">
      <input type="text" name="perAge"   autocomplete="off" lay-verify="number" placeholder="请输入年龄" class="layui-input">
    </div>
  </div>
      <div class="layui-form-item">
    <label class="layui-form-label">城市</label>
    <div class="layui-input-block">
      <input type="text" name="perCity"   autocomplete="off" lay-verify="required" placeholder="请输入城市" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item">
    <div class="layui-input-block">
     <button type="reset" class="layui-btn layui-btn-primary">重置</button>
      <button class="layui-btn" lay-submit="" lay-filter="sumPer">立即提交</button>
    </div>
  </div>
  
</form>

<script type="text/javascript">

layui.use(['jquery','form'],function(){
	var $ = layui.jquery;
	var perForm = layui.form;
	perForm.on('submit(sumPer)',function(data){
		//var str = JSON.stringify(data.field); 
        $.ajax({
        	url:'./insertALLParam',
        	type:'post',
        	data:data.field,
        	success:function(result){
        		 
				var index = parent.layer.getFrameIndex(window.name); 
				parent.layer.msg("添加成功", {icon: 6,time:1050});
				parent.layer.close(index); 
				//刷新整个表格
				window.parent.location.reload();
        	}
        });
		return false;
	});
	
});


</script>





</body>
</html>