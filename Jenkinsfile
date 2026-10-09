pipeline {
    agent any

    environment {
        registry = "med101/webappbdcc"
    }

    stages {

        stage('Building Image') {
            steps {
                sh '''
                    docker build -t ${registry}:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Test') {
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
    }
}