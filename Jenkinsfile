pipeline {
    agent any  // Runs the pipeline on any available agent

    environment {
        DOCKER_IMAGE = 'my-python-project:latest'  // Docker image name
        VENV_PATH = 'envv'  // Virtual environment name
    }

    stages {
        stage('Checkout') {
            steps {
                dir('/home/user/my_python_project') {  
                    git branch: 'main', url: 'file:///home/user/my_python_project'  // Clone the repo
                }
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                sh '''
                python3 -m venv $VENV_PATH  # Create virtual environment if not exists
                source $VENV_PATH/bin/activate  # Activate virtual environment
                pip install --upgrade pip  # Upgrade pip
                '''
            }
        }

        stage('Build Python Package') {
            steps {
                sh '''
                source $VENV_PATH/bin/activate
                pip install build  # Install build package
                python -m build --wheel  # Create a wheel file (distributable package)
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                source $VENV_PATH/bin/activate
                pip install pytest  # Install test framework
                pytest tests/  # Run tests from the 'tests/' directory
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'  // Build Docker image from Dockerfile
            }
        }

        stage('Deploy & Run Container') {
            steps {
                sh '''
                docker stop my-python-container || true  # Stop old container if running
                docker rm my-python-container || true  # Remove old container
                docker run -d --name my-python-container $DOCKER_IMAGE  # Run new container
                sleep 3  # Wait for container to start
                docker logs my-python-container  # Print container logs to Jenkins console
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
