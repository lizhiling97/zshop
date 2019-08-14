<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>在线商城-后台管理系统</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zshop.css"/>
</head>
<body>
<!-- 使用自定义css样式 div-signin 完成元素居中-->
<div class="container div-signin">
    <div class="panel panel-primary div-shadow">
        <!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
        <div class="panel-heading">
            <h3>在线商城系统 3.0</h3>
            <span>ZSHOP Manager System</span>
        </div>
        <div class="panel-body">
            <!-- login form start -->
            <form action="${pageContext.request.contextPath}/backend/sysuser/login" id="frmAddProduct"
                  class="form-horizontal"
                  method="post">
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名：</label>
                    <div class="col-sm-9">
                        <input class="form-control" type="text" name="loginName" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                    <div class="col-sm-9">
                        <input class="form-control" type="password" name="password" placeholder="请输入密码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">验证码：</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="code" placeholder="验证码">
                    </div>
                    <div class="col-sm-2">
                        <!-- 验证码 -->
                        <img onClick="change(this)" title="换一张试试" id="randImage"
                             src="${pageContext.request.contextPath}/code/image.jsp" width="100"
                             height="34" border="1" align="absmiddle">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-9 padding-left-0">
                        <div class="col-sm-4">
                            <button type="submit" class="btn btn-primary btn-block">登&nbsp;&nbsp;陆</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-link btn-block">忘记密码？</button>
                        </div>
                    </div>
                </div>
            </form>
            <!-- login form end -->
        </div>
    </div>
</div>
<!-- 页尾 版权声明 -->
<div class="container">
    <div class="col-sm-12 foot-css">
        <p class="text-muted credit">
            Copyright 南京网博 版权所有
        </p>
    </div>
</div>

<script>

    //点击切换验证码
    function change(code) {
        code.src = "${pageContext.request.contextPath}/code/image.jsp?t=" + new Date().getTime();
    }

    $(function () {
        //使用bootstrap validator插件进行登录数据校验
        $('#frmAddProduct').bootstrapValidator({
            feedbackIcons: {//返回图标
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                loginName: {
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        remote: {
                            type: 'post',
                            //校验商品名称是否存在
                            url: '${pageContext.request.contextPath}/backend/product/checkName'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }

                    }
                },
                code: {
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        remote: {
                            //校验商品名称是否存在
                            url: '${pageContext.request.contextPath}/backend/code/checkCode',
                            message: '验证码错误!'
                        }
                    }
                }
            }
        });

        //服务端提示消息
        var errorMsg = "${errorMsg}";
        if (errorMsg != "") {
            layer.msg(errorMsg,{
                time: 2000,
                skin: 'errorMsg'
            });
        }

    });

</script>
</body>
</html>
