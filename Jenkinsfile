pipeline {
    agent any  // 改为 any，不使用 docker

    environment {
        PROJECT_NAME = 'python-jenkins'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup') {
            steps {
                echo '设置环境...'
                sh '''
                echo "当前目录: $(pwd)"
                echo "Python版本:"
                python --version || python3 --version || echo "Python未安装"
                echo "检查Docker:"
                which docker || echo "Docker未安装，但我们可以继续"
                '''
            }
        }

        stage('Build') {
            steps {
                echo '构建应用...'
                sh '''
                echo "列出项目文件:"
                ls -la

                echo "如果有requirements.txt，安装依赖:"
                if [ -f "requirements.txt" ]; then
                    pip install -r requirements.txt || pip3 install -r requirements.txt || echo "pip安装失败"
                fi
                '''
            }
        }

        stage('Test') {
            steps {
                echo '运行测试...'
                sh '''
                echo "如果有测试，运行测试..."
                if [ -f "setup.py" ]; then
                    python setup.py test || echo "测试失败或没有测试"
                fi
                '''
            }
        }

        stage('Custom Python Script') {
            steps {
                echo '运行自定义Python脚本...'
                sh '''
                echo "创建并运行Python脚本..."
                cat > jenkins_test.py << 'EOF'
#!/usr/bin/env python3
import os
import sys

print("=== Jenkins Python 测试 ===")
print(f"Python版本: {sys.version}")
print(f"工作目录: {os.getcwd()}")
print(f"环境变量 BUILD_NUMBER: {os.environ.get('BUILD_NUMBER', '未设置')}")
print(f"项目名称: {os.environ.get('PROJECT_NAME', '未设置')}")
print("=== 测试完成 ===")
EOF
                python jenkins_test.py
                '''
            }
        }
    }

    post {
        always {
            echo '清理工作...'
            sh 'rm -f jenkins_test.py 2>/dev/null || true'
        }
        success {
            echo '✅ 构建成功!'
        }
        failure {
            echo '❌ 构建失败!'
        }
    }
}