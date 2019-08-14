package com.ssm.zshop.comm.constant;

/**
 * 返回结果状态常量
 */
public interface ResponseStatusConstant {

    /*
     * 响应状态码: 1.成功,2.失败,3.没有权限
     */
    public static final int RESPONSE_STATUS_SUCCESS = 1;

    public static final int RESPONSE_STATUS_FAIL = 2;

    public static final int RESPONSE_STATUS_NO_PERMISSION = 3;
}
