pipeline {
    agent {
        label 'windows-host'  // 确保在 Windows 节点运行
    }

    stages {


        stage('设置编码') {
            steps {
                bat '''
                rem 设置Windows命令行编码为UTF-8
                chcp 65001

                rem 设置环境变量
                set PYTHONIOENCODING=utf-8
                set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

                rem 测试中文
                echo 测试中文显示
                python -c "print('Python中文测试')"
                '''
            }
       }
        stage('查看代码') {
            steps {
                echo '检查代码文件...'
                bat '''
                echo ========================================
                echo      显示 app.py 内容
                echo ========================================
                echo.

                rem 检查文件是否存在
                if exist app.py (
                    echo 找到 app.py，内容如下：
                    echo ========================================
                    type app.py
                    echo ========================================
                ) else (
                    echo 错误：未找到 app.py！
                    dir
                )
                '''
            }
        }

        stage('运行简单测试') {
            steps {
                script {
                    echo '在 Windows 上运行测试...'

                    bat '''
                    echo ========================================
                    echo      Windows 环境测试
                    echo ========================================
                    echo.

                    rem 显示系统信息
                    echo 系统信息：
                    ver
                    echo.

                    rem 显示 Python 信息
                    echo Python 信息：
                    python --version 2>nul && (
                        echo Python 已安装
                        python --version
                    ) || (
                        echo Python 未安装
                    )
                    echo.

                    rem 检查 Flask
                    echo 检查 Flask：
                    python -c "import flask" 2>nul && (
                        echo Flask 已安装
                    ) || (
                        echo Flask 未安装
                    )
                    echo.

                    rem 创建简单的 Python 测试
                    echo 创建测试脚本...
                    echo print("Hello from Windows Jenkins!") > test.py
                    echo print("Build Number:", r"%BUILD_NUMBER%") >> test.py

                    echo 运行测试脚本：
                    python test.py

                    rem 清理
                    del test.py
                    '''
                }
            }
        }

        stage('运行 Flask 应用') {
            steps {
                bat '''
                echo ========================================
                echo      Flask 应用测试
                echo ========================================
                echo.

                rem 安装 Flask（如果需要）
                python -c "import flask" 2>nul || (
                    echo 安装 Flask...
                    pip install flask
                )

                rem 运行 Flask 应用
                echo 启动 Flask 应用（后台）...
                start /B python app.py

                rem 等待启动
                timeout /t 5 /nobreak >nul

                rem 测试应用
                echo 测试应用...
                curl http://localhost:5000/ 2>nul && (
                    echo ✅ Flask 应用运行成功！
                ) || (
                    echo ❌ Flask 应用启动失败
                )

                rem 停止应用
                taskkill /F /IM python.exe 2>nul
                '''
            }
        }
    }

    post {
        always {
            echo '清理工作...'
            bat '''
            rem 清理 Python 进程
            taskkill /F /IM python.exe 2>nul

            rem 清理临时文件
            del test.py 2>nul
            '''
        }
        success {
            echo '✅ 构建成功！'
        }
        failure {
            echo '❌ 构建失败'
        }
    }
}