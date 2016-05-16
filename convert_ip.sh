#! /bin/bash

#
#@brief 网络字节序的IP整数转成主机字节序的点分式
#网络字节序是大端字节序
#@return 点分式IP字符串
#
function num2ip()
{
    if [ $# != 1 ];then
        echo "no ip input"
    fi
    #echo "the ip $1 to be converted from number to ip\n"

    ## 将整数与特定的16进制数按位与运算，再进行右移运算
    H1=$(( $1 & 0x000000ff ))
    H2=$(( ($1 & 0x0000ff00) >> 8 ))
    L1=$(( ($1 & 0x00ff0000) >> 16 ))
    L2=$(( ($1 & 0xff000000) >> 24 ))

    # 将每个点分位上的数值作结合
    echo "$H1.$H2.$L1.$L2"
}

#
#@brief 主机字节序的IP整数转成主机字节序的点分式
#主机字节序是小端字节序
#@return 点分式IP字符串
#
function num2ip_2()
{
    if [ $# != 1 ];then
        echo "no ip input"
    fi
    #echo "the ip $1 to be converted from number to ip\n"

    ## 将整数与特定的16进制数按位与运算，再进行右移运算
    H1=$(( $1 & 0x000000ff ))
    H2=$(( ($1 & 0x0000ff00) >> 8 ))
    L1=$(( ($1 & 0x00ff0000) >> 16 ))
    L2=$(( ($1 & 0xff000000) >> 24 ))

    # 将每个点分位上的数值作结合
    echo -e "$L2.$L1.$H2.$H1\r"
}

#
#@brief 将点分式IP字符串转成主机字节序的整数IP
#@param string 字符串
#@return int 主机字节序的整数IP
#
function ip2num1()
{
    if [ $# != 1 ];then
        echo "no ip input"
    fi
    #echo "the ip $1 to be converted from ip to number\n"
    IP_ADDR=$1

    ## 判断字符串是否符合IP规范
    #if [[ "$IP_ADDR" =~ "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" ]];then
        #echo "ip format correct!"
    #else
        #echo "ip format error."
        #exit 1;
    #fi


    ## 把点号替换成空格
    IP_LIST=${IP_ADDR//./ };
    #echo $IP_LIST

    ## 把点分十进制地址拆成数组
    read -a IP_ARRAY <<< ${IP_LIST};
    x=$(( ${IP_ARRAY[0]}<<24 | ${IP_ARRAY[1]}<<16 | ${IP_ARRAY[2]}<<8 | ${IP_ARRAY[3]} ));
    echo $x;
}


#
#@brief 将点分式IP字符串转成主机字节序的整数IP
#@param int 高位1数值
#@param int 高位2数值
#@param int 低位1数值
#@param int 低位2数值
#
#@return int 主机字节序的整数IP
#
function ip2num2()
{
    if [ $# != 1 ];then
        echo "no ip input"
    fi
    #echo "the ip $1.$2.$3.$4 to be converted from ip to number\n"

    ### 把每一部分做完左移运算后进行按位运算
    x=$(( $1<<24 | $2<<16 | $3<<8 | $4 ))
    echo $x
}


#ip2num1 116.228.240.106
#num2ip 1961160810
#num2ip_2 1961160810
