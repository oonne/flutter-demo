#!/bin/bash

# 获取当前目录的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 获取本机IP地址
IP_ADDRESS=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)

# 检查是否成功获取到IP
if [ -z "$IP_ADDRESS" ]; then
    echo "错误：无法获取IP地址"
    exit 1
fi

# 更新.env.dev文件
ENV_FILE="$PROJECT_ROOT/.env.dev"
if [ -f "$ENV_FILE" ]; then
    # 使用sed替换API_URL的值
    sed -i '' "s|API_URL='http://[^:]*:|API_URL='http://${IP_ADDRESS}:|" "$ENV_FILE"
    echo "成功更新.env.dev文件中的IP地址为: ${IP_ADDRESS}"
else
    echo "错误：找不到.env.dev文件"
    exit 1
fi 