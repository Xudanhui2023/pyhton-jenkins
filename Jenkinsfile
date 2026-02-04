pipeline {
    // 关键配置：告诉 Jenkins 去 Docker Hub 拉取 python:3.9-slim 镜像来运行任务
    agent {
        docker {
            image 'python:3.12'
        }
    }
    stages {
        stage('检出代码') {
            steps {
                checkout scm
            }
        }
        stage('查看代码') {
            steps {
                sh 'cat app.py'
            }
        }
        stage('安装依赖') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('运行测试') {
            steps {
                sh 'python app.py'
            }
        }
    }
}