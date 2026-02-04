# 1.基础镜像
FROM python:3.12

# 2.维护者标签
LABEL maintainer = "xdh"

# 3.设置工作目录
WORKDIR /app

# 4. 复制依赖文件：先把 requirements.txt 拷贝进去
#    这样做的好处是利用 Docker 的缓存机制，只要依赖不变，安装依赖这一步就不会重新执行
COPY requirements.txt .
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建软链接（可选）
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

# 验证安装
RUN python --version && pip --version

# 5. 安装依赖：在容器内运行 pip 安装命令

RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 暴漏端口
COPY . .

EXPOSE 5000

# 启动命令
CMD ["python","app.py"]