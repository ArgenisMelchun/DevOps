### Description of Files and Directories

- **README.md**: This file, providing an overview of the project.
- **main.yaml**: The root stack that orchestrates the deployment of all other stacks.

#### Parameters
- **parameters/ssm-parameters.yaml**: SSM parameters for the infrastructure.

#### Network
- **network/vpc.yaml**: VPC configuration.
- **network/subnets.yaml**: Subnet configuration.
- **network/endpoints.yaml**: VPC endpoints configuration.
- **network/sg.yaml**: Security groups configuration.

#### Compute
- **compute/ecs-cluster.yaml**: ECS cluster configuration.
- **compute/ecs-service.yaml**: ECS service configuration.
- **compute/ecs-taskdefinition.yaml**: ECS task definitions.
- **compute/alb.yaml**: Application Load Balancer configuration.

#### Database
- **database/rds.yaml**: RDS instance configuration.

#### Services
- **services/backend/**: Backend service configuration.
  - **backend-main.yaml**: Main stack for the backend service.
  - **ecs-back-taskdefinition.yaml**: ECS task definition for the backend.
- **services/frontend/**: Frontend service configuration.
  - **frontend-main.yaml**: Main stack for the frontend service.
  - **ecs-front-taskdefinition.yaml**: ECS task definition for the frontend.
- **services/ml/**: Machine learning service configuration.
  - **ml-main.yaml**: Main stack for the ML service.
  - **ecs-ml-taskdefinition.yaml**: ECS task definition for the ML service.
- **services/healthcheck/**: Health check service configuration.
  - **eventbridge.yaml**: EventBridge rule and task definition for health checks.

#### IAM
- **iam/roles.yaml**: IAM roles required for ECS tasks and EventBridge.

#### Logging
- **logging/cloudwatch-log-group.yaml**: CloudWatch log group configuration.

## Deployment
# TODO

## Open Questions
# 1.-Are we going to create an script to create the initial bucket? and wich configuration is needed?
# 2.-Are we going to create an script to create the stacks?
# 3.-Stack policy for RDS is needed or the parameters can manage the lifecycle?
# 4.-How the initial script in the database will be manage?
# 5.-Stack configuration?
#   Permissions
#   Policies
#   Termination Protection
#   Logging and Monitoring
#   DeletionPolicy: Retain resource level
#   Notifications