pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                cleanWs()
                sh 'echo Current directory: $(pwd)'
                sh '[ -d my_python_project ] || git clone https://github.com/HafsaZareen/my_python_project.git'
                echo 'Repository cloned successfully!'
            }
        }

        stage('Verify Clone') {
            steps {
                sh 'cd my_python_project && ls -la && git status'
                echo 'Repository cloned successfully to workspace!'
            }
        }

        stage('Build & Test') {
            steps {
                sh '''
                cd my_python_project
                python -m venv venv
                source venv/bin/activate
                pip install -r requirements.txt
                python -m unittest discover tests
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd my_python_project
                docker build -t my_python_project .
                '''
            }
        }
    }
    post {
        success {
            echo 'Build & Tests Successful!'
        }
        failure {
            echo 'Build or Tests Failed!'
        }
    }
}
