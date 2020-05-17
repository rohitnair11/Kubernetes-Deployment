pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e templates/*.html'
            }
         }

        // stage('Lint Python') {
        //     steps {
        //         sh 'pylint --disable=R,C,W1203 app.py'
        //     }
        // }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t rohitnair11/capstone .'
                sh 'docker image ls'
            }
        }

        stage('Upload image to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    sh "docker push $DOCKER_USERNAME/capstone" 
                }
            }
        }

        stage('Set kubectl context') {
            steps {
				withAWS(region:'us-east-2', credentials:'aws-static') {
                    // sh "kubectl config set-context arn:aws:eks:us-east-2:701235088001:cluster/capstone --user=arn:aws:eks:us-east-2:701235088001:cluster/capstone --cluster=arn:aws:eks:us-east-2:701235088001:cluster/capstone --namespace=arn:aws:eks:us-east-2:701235088001:cluster/capstone"
                    sh "kubectl config get-contexts"
					sh "kubectl config use-context arn:aws:eks:us-east-2:701235088001:cluster/capstone"
				}
			}
        }

        stage('Deploy Blue Container') {
			steps {
				withAWS(region:'us-east-2', credentials:'aws-static') {
                    sh "ls"
					sh "kubectl --kubeconfig='/home/ubuntu/.kube/config' apply -f ./blue-controller.json"
				}
			}
		}

		stage('Deploy Green Container') {
			steps {
				withAWS(region:'us-east-2', credentials:'aws-static') {
					sh "kubectl --kubeconfig='/home/ubuntu/.kube/config' apply -f ./green-controller.json"
				}
			}
		}

		stage('Create service and redirect to Blue') {
			steps {
				withAWS(region:'us-east-2', credentials:'aws-static') {
					sh "kubectl --kubeconfig='/home/ubuntu/.kube/config' apply -f ./blue-service.json"
				}
			}
		}
    }
}