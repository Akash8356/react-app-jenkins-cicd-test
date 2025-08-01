pipeline {
  agent any

  environment {
    IMAGE_NAME = "vite-react-app"
    CONTAINER_NAME = "vite-react-container"
    PORT = "3000"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/YOUR_USERNAME/YOUR_REPO.git', branch: 'main'
      }
    }

    stage('Build & Deploy') {
      steps {
        sh '''
        docker-compose down || true
        docker-compose build
        docker-compose up -d
        '''
      }
    }
  }

  post {
    success {
      echo "✅ App deployed at http://localhost:${PORT}"
    }
    failure {
      echo "❌ Build or deploy failed"
    }
  }
}
