FROM node:22.3.0

# 安装 Python3、pip 和 git
RUN apt-get update && \
    apt-get install -y python3 python3-pip git && \
    ln -s /usr/bin/python3 /usr/bin/python

# 安装 pnpm
RUN npm install -g pnpm
# 安装 SWE-agent 兼容的 swerex
RUN pip install git+https://github.com/SWE-agent/SWE-ReX.git --break-system-packages

# 设置工作目录
WORKDIR /app

# 复制代码
COPY . .

RUN pnpm install

# SWE-agent 兼容：软链接
RUN mkdir -p /root/repos && ln -s /app /root/repos/app

# Default command
CMD ["pnpm", "run", "dev"]