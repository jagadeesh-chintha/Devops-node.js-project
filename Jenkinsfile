pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    AWS_REGION = "us-east-1"
  }

  stages {
    stage('Clone Repository') {
      steps {
        git branch : 'main', url:'https://github.com/jagadeesh-chintha/Devops-node.js-project.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
docker.build("jagadeesh7893/nodejs-app:${BUILD_NUMBER}")
        }
      }
    }

    stage('Pudh to Docker Hub') {
      steps {
        script {
docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
  docker.image("jagadeesh7893/nodejs-app:${BUILD_NUMBER}").push()
          }
        }
      }
    }
    stage('Provision AWS EC2 (Terrafrom)') {
      steps {
      dir('terraform') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve'
        }
      }
    }
    stage('Deploy app (Ansible)') {
      steps {
      dir('ansible') {
          sh 'ansible-playbook -i hosts playbook.yml'
        }
      }
    }
  }
}
