pipeline {
    agent any // 表示可以在任何可用的 Jenkins 节点上运行

    stages {
        // 阶段 1: 拉取代码
        stage('Checkout') {
            steps {
                echo '🔽 正在拉取代码...'
                // Jenkins 会自动根据任务配置的 Git 地址拉取代码
            }
        }

        // 阶段 2: 安装依赖并运行测试
        stage('Test') {
            steps {
                echo '🧪 开始运行 Python 测试...'
                sh '''
                    # 这里的三引号允许写多行 Shell 命令

                    # 1. 检查 Python 版本
                    python3 --version

                    # 2. 安装依赖
                    pip3 install -r requirements.txt

                    # 3. 运行单元测试 (假设你有一个 test_app.py)
                    # python3 -m pytest test_app.py
                    # 或者简单的语法检查
                    python3 -m py_compile app.py
                '''
            }
        }

        // 阶段 3: 构建 Docker 镜像 (如果你有 Dockerfile)
        stage('Build Image') {
            steps {
                script {
                    echo '🐳 开始构建 Docker 镜像...'
                    // 使用环境变量或构建号作为镜像标签
                    def imageTag = "my-python-app:latest"

                    // 执行构建命令
                    sh "docker build -t ${imageTag} ."
                }
            }
        }
    }

    post {
        success {
            echo '✅ 构建成功！'
            // 这里可以添加发送通知的命令
        }
        failure {
            echo '❌ 构建失败！'
            // 这里可以添加失败告警
        }
    }
}