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
                    echo "1. 查找 pip 命令:"
                    which pip || echo "pip 命令未找到"
                    which pip3 || echo "pip3 命令未找到"
                        pip3 install -r requirements.txt  # 直接使用容器内已有的 Python 环境安装依赖

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