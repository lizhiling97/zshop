<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/3 0003
  Time: 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
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
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zshop.css"/>
</head>

<body>
<div class="panel panel-default" id="userSet">
    <div class="panel-heading">
        <h3 class="panel-title">商品类型管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品类型" class="btn btn-primary" id="doAddProTpye">
        <br>
        <br>
        <div class="show-list" style="text-align: center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">类型名称</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${pageInfo.list}" var="types">
                    <tr>
                        <td>${types.id}</td>
                        <td>${types.name}</td>
                        <td>
                            <c:if test="${types.status == 1}">
                                启用
                            </c:if>
                            <c:if test="${types.status == 0}">
                                禁用
                            </c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm doProTypeModify" value="修改"
                                   onclick="showProductType(${types.id})">
                            <input type="button" class="btn btn-warning btn-sm doProTypeDelete" value="删除"
                                   onclick="showProductTypeModal(${types.id})">
                            <c:if test="${types.status == 0}">
                                <input type="button" class="btn btn-success btn-sm doProTypeDisable" value="启用"
                                onclick="changeButtonStatus(${types.id},this)">
                            </c:if>
                            <c:if test="${types.status == 1}">
                                <input type="button" class="btn btn-danger btn-sm doProTypeDisable" value="禁用"
                                onclick="changeButtonStatus(${types.id},this)">
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <%--使用paginator分页插件--%>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 添加商品类型 start -->
<div class="modal fade" tabindex="-1" id="ProductType">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">添加商品类型</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="productTypeName" class="col-sm-4 control-label">类型名称：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="productTypeName">
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary addProductType" onclick="addProductType()">添加</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 添加商品类型 end -->

<!-- 修改商品类型 start -->
<div class="modal fade" tabindex="-1" id="myProductType">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">修改商品类型</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="proTypeNum" class="col-sm-4 control-label">编号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="proTypeNum" readonly>
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="proTypeName" class="col-sm-4 control-label">类型名称</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="proTypeName">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="updateProductType()">修改</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改商品类型 end -->

<!-- 删除商品类型 start -->
<div class="modal fade" tabindex="-1" id="myProductTypeDelete">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">删除商品类型</h4>
            </div>
            <div class="modal-body text-center">
               <p style="color: red;">确定删除该商品类型吗?</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="deleteProductTypeId">
                <button class="btn btn-primary updateProType" onclick="deleteProductType()" data-dismiss="modal">删除</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 删除商品类型 end -->

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
            //设置点击下一页
            pageUrl: function (type, page, current) {
                //回到页面
                return '${pageContext.request.contextPath}/backend/productType/findAll?pageNum=' + page;
            },
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

    /*添加商品类型*/
    function addProductType() {
        $.post(
            '${pageContext.request.contextPath}/backend/productType/add',
            {'name': $("#productTypeName").val()},
            function (result) {
                if (result.status == 1) {//判断状态
                    layer.msg(result.message, {
                        time: 3000,
                        skin: 'successMsg'
                    });
                } else {
                    layer.msg(result.message, {
                        time: 3000,
                        skin: 'errorMsg'
                    });
                }

            }
        )
    }

    /*显示商品类型*/
    function showProductType(id) {
        $.post(
            '${pageContext.request.contextPath}/backend/productType/findById',
            {'id': id},
            function (result) {
                if (result.status == 1) {
                    $("#proTypeNum").val(result.data.id);
                    $("#proTypeName").val(result.data.name);
                }
            }
        )
    }

    /*修改商品类型*/
    function updateProductType() {
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/backend/productType/updateProductType',
            data: {'id': $("#proTypeNum").val(), 'name': $("#proTypeName").val()},
            dataType: 'json',
            success: function (result) {
                if (result.status == 1) {
                    layer.msg(result.message, {
                            time: 1000,
                            skin: 'successMsg'
                        }, function () {
                            //重新刷新页面
                            location.href = '${pageContext.request.contextPath}/backend/productType/findAll?pageNum='+ ${pageInfo.pageNum};
                        }
                    )
                } else {
                    layer.msg(result.message, {
                            time: 1000,
                            skin: 'errorMsg'
                        }
                    );
                }
            }
        });
    }

    /*删除商品类型提示框*/
    function showProductTypeModal(id) {
        $("#deleteProductTypeId").val(id);
        $("#myProductTypeDelete").modal('show');
    }

    /*删除商品类型*/
    function deleteProductType() {
        $.ajax({
            type:'get',
            url: '${pageContext.request.contextPath}/backend/productType/deleteProductType',
            data:{'id':$("#deleteProductTypeId").val()},
            dataType: 'json',
            success: function (result) {
                layer.msg(result.message,{
                    time: 1000,
                    skin: 'successMsg'
                },function () {
                    location.href='${pageContext.request.contextPath}/backend/productType/findAll';
                })
            }
        });
    }

    //更改商品状态
    function changeButtonStatus(id,btn){
        $.ajax({
            type:'get',
            url: '${pageContext.request.contextPath}/backend/productType/changeStatus',
            data: {'id':id},
            dataType: 'json',
            success: function (result) {
                if(result.status == 1){
                    var $span = $(btn).parent().prev();
                    if($span.text().trim() == '启用'){
                        $span.text("禁用");
                        $(btn).val("启用").removeClass("btn-danger").addClass("btn-success");
                    }else{
                        $span.text("启用");
                        $(btn).val("禁用").removeClass("btn-success").addClass("btn-danger");;
                    }
                }
            }
        })
    }

</script>
</body>

</html>
