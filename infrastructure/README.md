# Infrastructure

There are 4 cloudformation templates which build the infrastructure:
- vpc-network.yml
- portal.yml
- hardware.yml
- rds.yml

### VPC-Network.yml
Resources created:
- 2 Public subnets with route tables
- 2 Private subnets with route tables to Nat instance
- 1 internet gateway
- 1 web security group
- 1 databasae security group
- 1 NAT instance (for accessing instances in private subnets)
- 1 Nat instance security group
- Network ACLs

### Portal.yml
Resources created:
- Portal Server Security Group
- Portal Loadbalancer Security Group
- Portal Loadbalancer
- Portal scaling policy
- Portal Launch configuration
- Portal AutoScaling Group

### Hardware.yml
Resources created:
- Hardware Server Security Group
- Hardware Loadbalancer Security Group
- Hardware Loadbalancer
- Hardware scaling policy
- Hardware Launch configuration
- Hardware AutoScaling Group

### Rds.yml
Resources created:
- Random password in Secret Manager
- RDS instance
- RDS Subnet Group

After the above templates have been deployed successfully in cloudformation, the following steps will have to be taken:
1. Create an Application in AWS Codedeploy
2. Create two deployment groups in the Application called `Portal` and `Hardware`
3. Create two pipelines in AWS Codepipeline called `Portal` and `Hardware` and connect them to your github repository and the respective Portal and Hardware Deployment groups created in AWS Codedeploy (skip the build stage). This will trigger a new deployment.
4. Visit your application using the DNS of the PortalALB (Portal Application Loadbalancer)
