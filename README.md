# Udacity-Capstone
A Blue-Green deployment is performed on a simple flask application using AWS Elastic Kubernetes Service (EKS). A CI/CD pipeline is created using a Jenkins server on an EC2 instance. The flask application is first containerized using Docker and the Docker image is pushed to DockerHub. The deployment is done using this docker image.  

The `Jenkinsfile` inside the `eks-cluster` directory is used to create the kubernetes cluster on EKS.  
The `app.py`, `static` and `templates` folders contains the flask application that is to be deployed.  
The `Dockerfile` contains the instructions to build the Docker image.  
The `blue-controller.json`, `blue-service.json`, `green-controller.json` and `green-service.json` files are used to create a replication controller and services for the blue and green instances respectively.
