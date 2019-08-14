package com.ssm.zshop.comm.util;

import com.ssm.zshop.comm.constant.ResponseStatusConstant;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseResult {

    //状态码
    private int status;

    //返回消息
    private String message;

    //返回数据
    private Object data;

    public ResponseResult() {
    }

    public ResponseResult(int status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    /**
     * 成功方法
     */
    public static ResponseResult success(Object data){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS,"success",data);
    }

    public static ResponseResult success(){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS,"success",null);
    }

    public static ResponseResult success(String message){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS,message,null);
    }

    /**
     * 失败
     */
    public static ResponseResult fail(Object data){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_FAIL,"fail",data);
    }

    public static ResponseResult fail(){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_FAIL,"success",null);
    }

    public static ResponseResult fail(String message){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_FAIL,message,null);
    }
}
