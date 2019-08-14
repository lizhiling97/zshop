package com.ssm.zshop.comm.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class RenameUtil {

    public static String renameFile(String fileName){
        int lastIndexOf = fileName.lastIndexOf(".");
        String suffix = fileName.substring(lastIndexOf);
        return new SimpleDateFormat("yyyyMMddHHmmss")
                .format(new Date())+new Random().nextInt(100)+suffix;

    }
}
