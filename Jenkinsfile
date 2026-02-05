pipeline {
    agent {
        label 'windows-host'  // 指定在 Windows 宿主机运行
    }

    stages {
        // 阶段1: 查看代码
        stage('查看代码') {
            steps {
                echo '检查代码文件...'
                bat 'cat app.py'
            }
        }
 stage('Run on Windows') {
            steps {
                bat '''
                echo 正在 Windows 宿主机上运行！
                echo 计算机名: %COMPUTERNAME%
                echo 用户名: %USERNAME%

                rem 检查 Docker
                docker version
                docker ps

                rem 创建测试文件
                echo Hello from Jenkins at %DATE% %TIME% > test.txt
                dir
                type test.txt
                '''
            }
        }
        // 阶段2: 运行测试
        stage('运行测试') {
            steps {
                script {
                    // 安装必要组件
                   bat '''
                echo "=== 当前 Agent 信息 ==="
                echo "节点名称: $NODE_NAME"
                echo "节点标签: $NODE_LABELS"
                echo "工作空间: $WORKSPACE"
                echo "主机名: $(hostname)"
                echo "容器ID: $(cat /etc/hostname 2>/dev/null || hostname)"
                echo "当前目录: $(pwd)"
                echo "用户: $(whoami)"
                echo "进程:"
                ps aux
                        pip3 install -r requirements.txt  # 直接使用容器内已有的 Python 环境安装依赖

                      '''

                    // 运行简单测试
                    bat '''
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