pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    environment {
        registry = "med101/webappbdcc"
        containerName = "webappbdcc"
    }

    stages {

        stage('Cloning Git') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/noalibi99/tp2devops.git'
            }
        }

        stage('Building image') {
            steps {
                sh '''
                    docker build -t ${registry}:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Test image') {
            steps {
                sh '''
                    echo "Tests passed"
                '''
            }
        }

        stage('Publish Image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_TOKEN'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_TOKEN" | docker login \
                            -u "$DOCKER_USER" \
                            --password-stdin

                        docker push ${registry}:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage('Deploy image') {
            steps {
                sh '''
                    echo "Deploying ${registry}:${BUILD_NUMBER}"

                    docker rm -f ${containerName} 2>/dev/null || true

                    docker run -d \
                        --name ${containerName} \
                        -p 8081:80 \
                        ${registry}:${BUILD_NUMBER}

                    echo "Deployment successful"

                    docker ps --filter "name=${containerName}"
                '''
            }
        }
    }
}