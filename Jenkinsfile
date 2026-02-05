pipeline {
    agent {
        label 'windows-host'
    }

    stages {
        stage('测试 Windows 命令') {
            steps {
                bat '''
                echo ========================================
                echo      基本的 Windows 命令测试
                echo ========================================
                echo.
                echo 当前目录：
                cd
                echo.
                echo 文件列表：
                dir
                echo.
                echo 显示 app.py 内容：
                if exist app.py (
                    type app.py
                ) else (
                    echo 没有找到 app.py
                )
                '''
            }
        }
    }
}