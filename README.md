Architecture Ref.Card 02 - React Application (Serverless)
=========================================================

For a complete project overview, visit:[Project Overview](https://gitlab.com/bbwrl/m346-ref-card-overview)

Prerequisites
-------------

### Tools Needed

*   **Node.js and npm**Required to build and run the app. It's recommended to install the LTS version.[Download Node.js](https://nodejs.org/en/download/)
    
*   **Note:** Node.js must not be installed prior to using nvm.[Install nvm](https://learn2torials.com/a/how-to-install-nvm)
    

Local Setup
-----------

### Clone the Project

git clone git@gitlab.com:bbwrl/m346-ref-card-02.git  cd architecture-refcard-02   

### Build and Run the Project

1.  npm install
2.  This will install all dependencies and store them in the node\_modules folder.
    
3.  npm start
4.  The app will be available in your browser at:[http://localhost:3000](http://localhost:3000)
    

Running with Docker
-------------------

### 1\. Create a Dockerfile

FROM node:18-alpine  WORKDIR /app  COPY package*.json ./  RUN npm install  COPY . .  EXPOSE 3000  CMD ["npm", "start"]   `

### 2\. Build and Push Docker Image

docker build -t grasi-code/m346-ref-card-02 .  docker push grasi-code/m346-ref-card-02   `

Setting up GitHub Actions
-------------------------

### 1\. Create a .github/workflows/ci.yml File

name: CI  on:    push:      branches: [ main ]  jobs:    build:      runs-on: ubuntu-latest      steps:      - uses: actions/checkout@v3      - name: Build the Docker image        run: docker build -t grasi-code/m346-ref-card-02 .      - name: Log in to Docker Hub        run: docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD      - name: Push the Docker image        run: docker push grasi-code/m346-ref-card-02   `

### 2\. Add Docker Hub Credentials as GitHub Secrets

*   Go to your GitHub repository settings and add the following secrets:
    
    *   DOCKER\_USERNAME
        
    *   DOCKER\_PASSWORD
        

Building and Deploying Docker to AWS
------------------------------------

This repository contains a GitHub Actions workflow to automate building and deploying a Docker image to Amazon Elastic Container Registry (ECR) and ECS.

### Workflow Overview

Triggered by a push to the main branch, this workflow has two main jobs: **build** and **deploy**.

### 1\. Build Job

*   **Environment**: ubuntu-latest
    
*   **Steps**:
    
    1.  Checkout the repository.
        
    2.  Set up AWS credentials from GitHub secrets.
        
    3.  Log in to Amazon ECR.
        
    4.  Build the Docker image.
        
    5.  Tag and push the Docker image to ECR.
        

### 2\. Create an ECS Cluster

After setting up the AWS ECS cluster, you should see it listed in your AWS Management Console.

### 3\. Create an ECS Task Definition

Configure environment variables and add details as needed. A production task definition JSON file can be found [here](./.github/aws/task-definition-prod.json).

### 4\. Create an ECS Service

Create a service for your task in ECS.

Once the service is running, verify that your application is accessible.

### 5\. Deploy Job

*   **Job Dependency**: The deploy job depends on the completion of the build job.
    
*   **Environment**: ubuntu-latest
    
*   **Steps**:
    
    1.  Set up AWS credentials.
        
    2. aws ecs update-service --cluster ref-card --service ref-card-service --task-defi
        

Prerequisites
-------------

*   **AWS Account**: Ensure you have access to ECR and ECS.
    
*   **GitHub Secrets**: Set up the following secrets in your repository:
    
    *   AWS\_ACCESS\_KEY\_ID
        
    *   AWS\_SECRET\_ACCESS\_KEY
        
    *   AWS\_SESSION\_TOKEN (if required)
        
    *   AWS\_REGION
        
    *   ECR\_REPOSITORY
        
    *   EC2\_SSH\_PRIVATE\_KEY
        

Deployment Instructions
-----------------------

1.  Push your changes to the main branch.
    
2.  The workflow will automatically build the Docker image and deploy it to ECS.
    

Important Notes
---------------

*   Ensure your EC2 instance is running and accessible.
    
*   Modify the EC2\_INSTANCE\_DNS variable in the deploy job with your instance's DNS name.
    
*   The workflow assumes the app is running on port 80. Update port mapping as needed.
    

Troubleshooting
---------------

*   Check the Actions tab in GitHub for logs and errors.
    
*   Ensure your AWS IAM roles have appropriate permissions for ECR and ECS.
