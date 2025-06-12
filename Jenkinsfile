pipeline {
    agent any

    tools {
        maven 'Maven-3.6.3'
    }

    environment {
        IMAGE_NAME = 'mullapudipruthvi/abc-tech-app'
        CONTAINER_NAME = 'abc-tech-container'
        HOST_PORT = '9090'
        CONTAINER_PORT = '8080'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
        K8S_NAMESPACE = 'abc-tech'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git(
                    url: 'https://github.com/Pruthvi56-Bobi/ABC-Tech--IGP-Project.git',
                    credentialsId: 'github-token',
                    branch: 'main'
                )
            }
        }

        stage('Code Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Code Packaging') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                sh 'ansible-playbook -i ansible-k8s-setup/hosts.ini ansible-k8s-setup/deploy_docker.yml -u ec2-user --become'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/abc-tech-deployment abc-tech=${IMAGE_NAME}:${BUILD_NUMBER} -n ${K8S_NAMESPACE}'
            }
        }
    }

    post {
        success {
            echo '✅ Build and Deployment Successful! Visit: http://<your-ec2-ip>:9090'
        }
        failure {
            echo '❌ Something went wrong. Check the pipeline logs.'
        }
    }
}
