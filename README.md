# OpenShift Cluster Event and ACS Violation Reporting

This repo includes OpenShift cronjobs for reporting cluster events and Advanced Cluster Security (ACS) violations. These cronjobs capture specific events and violations and report them for analysis.

## CronJobs

1. **aiops-gatherer-events**
   - **Purpose**: Captures all cluster events with an event type of Warning across all namespaces. This can be tailored to focus on specific namespaces if required.
   - **Configuration File**: `ai-cronjob.yaml`

2. **acs-violations-gatherer**
   - **Purpose**: Gathers all Advanced Cluster Security Violations. This can be refined to report violations in specific namespaces as needed.
   - **Configuration File**: `acs-ai-cronjob.yaml`

## Prerequisites

- **OpenShift Cluster**: An active OpenShift cluster is required for deploying these cronjobs.
- **Customized Container Image**: The cronjobs rely on a specialized container image equipped with `jq`. A Dockerfile is provided for building this image.
- **Container Runtime**: Podman or Docker is needed for building the container image.
- **Ollama**: AI-based analysis endpoint. For more information, visit [Ollama GitHub Repository](https://github.com/ollama/ollama).

## Security and Permissions
- RBAC policies are tightly controlled to adhere to the principle of least privilege.
- Secrets are used to securely manage sensitive data required by ACS and by Ollama.

## Deployment

To deploy the cronjobs in your OpenShift cluster, apply the configurations in the `deployment` directory:

```sh
oc apply -f deployment/
```

### Directory Structure

```
.
├── deployment
│   ├── acs-ai-cronjob.yaml       # ACS Violation Gatherer CronJob
│   ├── acs-secret.yaml           # Secret for ACS API
│   ├── ai-cronjob.yaml           # General AI CronJob Config
│   ├── cluster-rbac.yaml         # RBAC Configurations
│   ├── configmap.yaml            # Configuration Map
│   ├── namespace.yaml            # Namespace Config
│   ├── ollama-secret.yaml        # Secret for Ollama API
│   └── sa-rbac.yaml              # Service Account RBAC Config
├── Dockerfile                    # Dockerfile for Custom Image
└── README.md                     # This README File
```

Ensure that you review and customize the YAML files as per your cluster setup and requirements.
