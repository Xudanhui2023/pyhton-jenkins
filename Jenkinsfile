pipeline {
    agent any

    stages {
        // 阶段1: 查看代码
        stage('查看代码') {
            steps {
                echo '检查代码文件...'
                sh 'cat app.py'
            }
        }

        // 阶段2: 运行测试
        stage('运行测试') {
            steps {
                script {
                    // 安装必要组件
                   sh '''
                    echo "安装 Python 依赖..."
                        pip3 install -r requirements.txt  # 直接使用容器内已有的 Python 环境安装依赖
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
                      '''

                    // 运行简单测试
                    sh '''
                    echo "运行应用测试..."
                    python3 -c "
try:
    from app import app
    print('✅ Flask 应用导入成功')
except Exception as e:
    print(f'❌ 导入失败: {e}')
    exit(1)
                    "
                    '''
                }
            }
        }
    }

    post {
        always {
            echo '✅ 流程完成'
        }
    }
}