<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>backend</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/file.css"/>
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
            //上传图像预览
            $('#product-image').on('change', function () {
                $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
            });
            $('#pro-image').on('change', function () {
                $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
            });

            //服务端提示消息
            var successMsg = '${successMsg}';
            var errorMsg = '${errorMsg}';
            if (successMsg != '') {
                layer.msg(successMsg, {
                    time: 2000,
                    skin: 'successMsg'
                })
            }
            if (errorMsg != '') {
                layer.msg(errorMsg, {
                    time: 2000,
                    skin: 'errorMsg'
                })
            }

            //使用bootstrap validator插件进行客户端数据校验
            $('#frmAddProduct').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    name: {
                        validators: {
                            notEmpty: {
                                message: '商品名称不能为空'
                            },
                            remote: {
                                type: 'post',
                                //校验商品名称是否存在
                                url: '${pageContext.request.contextPath}/backend/product/checkName'
                            }
                        }
                    },
                    price: {
                        validators: {
                            notEmpty: {
                                message: '商品价格不能为空'
                            },
                            regexp: {
                                regexp: /^\d+(\.\d+)?$/,
                                message: '商品价格格式不正确'
                            }
                        }
                    },
                    file: {
                        validators: {
                            notEmpty: {
                                message: '请选择图片'
                            }
                        }
                    },
                    productTypeId: {
                        validators: {
                            notEmpty: {
                                message: '请选择商品类型'
                            }
                        }
                    }
                }
            });

            //分页
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion: 3,
                currentPage: ${productPageInfo.pageNum},
                totalPages: ${productPageInfo.pages},
                pageUrl: function (type, page, curren) {
                    return '${pageContext.request.contextPath}/backend/product/findAll?pageNum=' + page;
                },
                itemTexts: function (type, page, curren) {
                    switch (type) {
                        case 'first' :
                            return '首页';
                        case 'prev' :
                            return '上一页';
                        case 'next' :
                            return '下一页';
                        case 'last' :
                            return '尾页';
                        case 'page' :
                            return page;
                    }
                }
            });
        });

        //展示修改商品
        function showProduct(id) {
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/backend/product/findById',
                data: {'id': id},
                dataType: 'json',
                success: function (result) {
                    if (result.status == 1) {
                        $('#pro-num').val(result.data.id);
                        $('#pro-name').val(result.data.name);
                        $('#pro-price').val(result.data.price);
                        $('#pro-productId').val(result.data.productType.id);
                        $('#img2').attr('src', '${pageContext.request.contextPath}/backend/product/getImage?path=' + result.data.image)
                    }
                }
            })
        }

        /* //修改商品
         function modifyProduct() {
             $.ajax({
                 type: 'post',
                 url: '${pageContext.request.contextPath}/backend/product/modify',
                data: {
                    'id': $('#pro-num').val(), 'name': $('#pro-name').val(),
                    'price': $('#pro-price').val(),'image':$('#pro-image').val(),
                    'productTypeId': $('#pro-productId').val()
                },
                dataType: 'json',
                success: function (result) {
                    if (result.status == 1) {
                        layer.msg(result.message, {
                                time: 1000,
                                skin: 'successMsg'
                            }, function () {
                                //重新刷新页面
                                location.href = '${pageContext.request.contextPath}/backend/product/findAll?pageNum='+ ${productPageInfo.pageNum};
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
            })
        }*/

        //显示删除模态框
        function showDeleteModal(id) {
            $('#deleteProductId').val(id);
            $('#deleteProductModal').modal('show');
        }

        //删除商品
        function deleteProduct() {
            $.post(
                '${pageContext.request.contextPath}/backend/product/delete',
                {'id': $('#deleteProductId').val()},
                function (result) {
                    if (result.status == 1) {
                        layer.msg(result.message, {
                                time: 2000,
                                skin: 'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/product/findAll';
                            }
                        )
                    }
                }
            )
        }


    </script>
</head>

<body>
<div class="panel panel-default" id="userPic">
    <div class="panel-heading">
        <h3 class="panel-title">商品管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品" class="btn btn-primary" id="doAddPro">
        <br>
        <br>
        <div class="show-list" style="text-align: center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">商品</th>
                    <th class="text-center">价格</th>
                    <th class="text-center">产品类型</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${productPageInfo.list}" var="product">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.productType.name}</td>
                        <td>
                            <c:if test="${product.productType.status == 1}">
                                有效商品
                            </c:if>
                            <c:if test="${product.productType.status == 0}">
                                无效商品
                            </c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm doProModify" value="修改"
                                   onclick="showProduct(${product.id})">
                            <input type="button" class="btn btn-warning btn-sm doProDelete" value="删除"
                                   onclick="showDeleteModal(${product.id})">

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>

<!-- 添加商品 start -->
<div class="modal fade" tabindex="-1" id="Product">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/product/add" class="form-horizontal" method="post"
              enctype="multipart/form-data" id="frmAddProduct">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加商品</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="product-name" class="col-sm-4 control-label">商品名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="name" id="product-name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-price" class="col-sm-4 control-label">商品价格：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="price" id="product-price">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-image" class="col-sm-4 control-label">商品图片：</label>
                            <div class="col-sm-8">
                                <a href="javascript:;" class="file">选择文件
                                    <input type="file" name="file" id="product-image">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
                            <div class="col-sm-8">
                                <select class="form-control" name="productTypeId">
                                    <option value="">请选择</option>
                                    <c:forEach items="${productTypes}" var="productType">
                                        <option value="${productType.id}">${productType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="img">
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加商品 end -->

<!-- 修改商品 start -->
<div class="modal fade" tabindex="-1" id="myProduct">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/product/modify" class="form-horizontal" method="post"
              enctype="multipart/form-data">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改商品</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="pro-num" class="col-sm-4 control-label">商品编号：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="id" id="pro-num" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-name" class="col-sm-4 control-label">商品名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="name" id="pro-name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-price" class="col-sm-4 control-label">商品价格：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="price" id="pro-price">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-image" class="col-sm-4 control-label">商品图片：</label>
                            <div class="col-sm-8">
                                <a class="file">
                                    选择文件 <input type="file" name="file" id="pro-image">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="pro-productId" name="productTypeId">
                                    <option>请选择</option>
                                    <c:forEach items="${productTypes}" var="productType">
                                        <option value="${productType.id}">${productType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="img2">
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="pageNum" value="${productPageInfo.pageNum}">
                    <button class="btn btn-primary updatePro" type="submit">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改商品 end -->

<!-- 确认删除 start -->
<div class="modal fade" tabindex="-1" id="deleteProductModal">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">提示消息</h4>
            </div>
            <div class="modal-body text-center row">
                <h4 style="color: red">确认要删除该商品吗</h4>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="deleteProductId">
                <button class="btn btn-primary updatePro" data-dimiss="modal" onclick="deleteProduct()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认删除 end -->
</body>
</html>