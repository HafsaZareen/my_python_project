pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-python-project:latest'
        VENV_PATH = 'envv'
    }

    stages {
        stage('Checkout') {
            steps {
                dir("${env.WORKSPACE}") {  
                    git branch: 'main', url: 'https://github.com/HafsaZareen/my_python_project.git'
                }
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                sh '''
                python3 -m venv $VENV_PATH
                bash -c "source $VENV_PATH/bin/activate && pip install --upgrade pip"
                '''
            }
        }

        stage('Build Python Package') {
            steps {
                sh '''
                bash -c "source $VENV_PATH/bin/activate && pip install build setuptools wheel"
                python -m build --wheel
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                if [ -d "tests" ]; then
                    bash -c "source $VENV_PATH/bin/activate && pip install pytest && pytest tests/"
                else
                    echo "No tests found"
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Deploy & Run Container') {
            steps {
                sh '''
                docker stop my-python-container || true
                docker rm my-python-container || true
                docker run -d -p 5000:5000 --name my-python-container $DOCKER_IMAGE
                sleep 3
                docker logs my-python-container
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed! Check logs.'
        }
    }
}
