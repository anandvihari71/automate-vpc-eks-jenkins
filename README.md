# automate-vpc-eks-jenkins
#two vps are created 1 for EKS, 1 for Jenkins server
#
Cmd command to create a dynamo db table for state locking 

aws dynamodb create-table --table-name enable-state-locking-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST 