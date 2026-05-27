#!/bin/bash
############################
#Description:  create a VPC in AWS
#-create a VPC
#-Create a subnet
#-Verify if the user has AWS installed, user might be using windows, Mac or linux.
#-verify if the AWS CLI is configure.
############################


#Variables
VPC_CIDR="10.0.0.0/16"
SUBNET_CIDR="10.0.1.0/24"
Region="us-east-1"
VPC_NAME="MyVPC"
SUBNET_NAME="MySubnet"

#Check if AWS CLI is installed
if ! command -v aws &> /dev/null
then
    echo "AWS CLI could not be found. Please install AWS CLI to proceed."
    exit
fi      
#Check if AWS CLI is configured
if ! aws sts get-caller-identity &> /dev/null
then
    echo "AWS CLI is not configured. Please configure AWS CLI to proceed."
    exit
fi  

#Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR --region $Region --query 'Vpc.VpcId' --output text)
echo "VPC created with ID: $VPC_ID"     

#Create Subnet
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --

cidr-block $SUBNET_CIDR --region $Region --query 'Subnet.SubnetId' --output text)
echo "Subnet created with ID: $SUBNET_ID"       

