<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/4 0004
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>backend</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zshop.css"/>

    <script>
        $(function () {
            <%--让分页显示到页面--%>
            $("#pagination").bootstrapPaginator({
                //分页插件版本
                bootstrapMajorVersion: 3,
                //第几页
                currentPage:${pageInfo.pageNum},
                //共几页
                totalPages:${pageInfo.pages},

                onPageClicked: function (event, originalEvent, type, page) {
                    $('#pageNum').val(page);
                    $('#frmSearch').submit();
                },
                /*pageUrl: function (type, page, current) {
                    //回到页面
                    return '${pageContext.request.contextPath}/backend/sysuser/findAll?pageNum=' + page;
                },*/
                //设置点击下一页
                itemTexts: function (type, page, current) {
                    switch (type) {
                        case 'first':
                            return '首页';
                        case 'prev':
                            return "上一页";
                        case 'next':
                            return "下一页";
                        case 'last':
                            return "尾页";
                        case 'page':
                            return page;
                    }
                }
            });
        });

        //添加系统用户
        function addSysuser() {
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/add',
                $('#frmAddSysuser').serialize(),
                function (result) {
                    if (result.status == 1) {
                        layer.msg('添加成功', {
                            time: 2000,
                            skin: 'successMsg'
                        }, function () {
                            location.href = '${pageContext.request.contextPath}/backend/sysuser/findAll?pageNum=' +${pageInfo.pageNum};
                        })
                    }

                }
            );
        }

        //添加显示
        function showSysuser(id) {
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/findById',
                {'id': id},
                function (result) {
                    if (result.status == 1) {
                        $("#MargerStaffId").val(result.data.id);
                        $("#MargerStaffname").val(result.data.name);
                        $("#MargerLoginName").val(result.data.loginName);
                        $("#MargerPhone").val(result.data.phone);
                        $("#MargerAdrees").val(result.data.email);
                    }
                }
            )
        }

        //修改系统用户状态
        function changeSysuserStatus(id, btn) {
            $.ajax({
                type: 'get',
                url: '${pageContext.request.contextPath}/backend/sysuser/changeStatus',
                data: {'id': id},
                dataType: 'json',
                success: function (result) {
                    if (result.status == 1) {
                        var $td = $(btn).parent().parent().children().eq(5);
                        if ($td.text().trim() == '有效') {
                            $td.text('无效');
                            $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');
                        } else {
                            $td.text('有效');
                            $(btn).val('禁用').removeClass('btn-success').addClass('btn-danger');
                        }
                    }
                }
            })
        }


    </script>
</head>

<body>
<!-- 系统用户管理 -->
<div class="panel panel-default" id="adminSet">
    <div class="panel-heading">
        <h3 class="panel-title">系统用户管理</h3>
    </div>
    <div class="panel-body">
        <div class="showmargersearch">
            <form class="form-inline" action="${pageContext.request.contextPath}/backend/sysuser/findByParam"
                  method="post" id="frmSearch">
                <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum">
                <div class="form-group">
                    <label for="userName">姓名:</label>
                    <input type="text" class="form-control" id="userName" placeholder="请输入姓名" name="name"
                           value="${sysuserParam.name}">
                </div>
                <div class="form-group">
                    <label for="loginName">帐号:</label>
                    <input type="text" class="form-control" id="loginName" placeholder="请输入帐号" name="loginName"
                           value="${sysuserParam.loginName}">
                </div>
                <div class="form-group">
                    <label for="phone">电话:</label>
                    <input type="text" class="form-control" id="phone" placeholder="请输入电话" name="phone"
                           value="${sysuserParam.phone}">
                </div>
                <div class="form-group">
                    <label for="role">角色</label>
                    <select class="form-control" name="roleId" id="role">
                        <option value="-1">--请选择--</option>
                        <c:forEach items="${roles}" var="role">
                            <option value="${role.id}"
                                    <c:if test="${role.id==sysuserParam.roleId}">selected</c:if>>${role.roleName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status">状态</label>
                    <select class="form-control" name="isValid" id="status">
                        <option value="-1">全部</option>
                        <option value="1" <c:if test="${sysuserParam.isValid==1}">selected</c:if>>---有效---</option>
                        <option value="0" <c:if test="${sysuserParam.isValid==0}">selected</c:if>>---无效---</option>
                    </select>
                </div>
                <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
            </form>
        </div>
        <br>
        <input type="button" value="添加系统用户" class="btn btn-primary" id="doAddManger">
        <div class="show-list" style="position: relative; top: 10px;text-align: center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">序号</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">帐号</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">邮箱</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">注册时间</th>
                    <th class="text-center">角色</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${pageInfo.list}" var="sysuser">
                    <tr>
                        <td>${sysuser.id}</td>
                        <td>${sysuser.name}</td>
                        <td>${sysuser.loginName}</td>
                        <td>${sysuser.phone}</td>
                        <td>${sysuser.email}</td>
                        <td>
                            <c:if test="${sysuser.isValid == 1}">有效</c:if>
                            <c:if test="${sysuser.isValid == 0}">无效</c:if>
                        </td>
                        <td>
                            <fmt:formatDate value="${sysuser.createDate}" type="both"/>
                        </td>
                        <td>${sysuser.role.roleName}</td>

                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改"
                                   onclick="showSysuser(${sysuser.id})">
                            <c:if test="${sysuser.isValid == 1}">
                                <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用"
                                       onclick="changeSysuserStatus(${sysuser.id},this)">
                            </c:if>
                            <c:if test="${sysuser.isValid == 0}">
                                <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用"
                                       onclick="changeSysuserStatus(${sysuser.id},this)">
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 添加系统用户 start -->
<div class="modal fade" tabindex="-1" id="myMangerUser">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <form id="frmAddSysuser">
            <%--页码回显--%>
            <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加系统用户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="name" id="marger-username">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="loginName" id="marger-loginName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" name="password" id="marger-password">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="phone" id="marger-phone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="marger-adrees" class="col-sm-4 control-label">联系邮箱：</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" name="email" id="marger-email">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="role"
                               class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" name="roleId">
                                <option>请选择</option>
                                <c:forEach items="${roles}" var="role">
                                    <option value="${role.id}">${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary add-Manger" type="button" onclick="addSysuser()">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal" type="button">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加系统用户 end -->

<!-- 修改系统用户 start -->
<div class="modal fade" tabindex="-1" id="myModal-Manger">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <form id="modifyform" method="post" action="${pageContext.request.contextPath}/backend/sysuser/modify"
              enctype="multipart/form-data">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">系统用户修改</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="MargerUsername" class="col-sm-4 control-label">用户编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="id" id="MargerStaffId" readonly="readonly">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerUsername" class="col-sm-4 control-label">用户姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="name" id="MargerStaffname">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerLoginName" class="col-sm-4 control-label">登录帐号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerLoginName" readonly="readonly">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerPhone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="phone" id="MargerPhone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerAdrees" class="col-sm-4 control-label">联系邮箱：</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" name="email" id="MargerAdrees">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerRole" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" id="MargerRole" name="roleId">
                                <option>请选择</option>
                                <c:forEach items="${roles}" var="role">
                                    <option value="${role.id}" selected>${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary doMargerModal" type="submit">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改系统用户 end -->

</body>

</html>