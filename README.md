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

## Configurable Parameters in ConfigMap

The `configmap.yaml` in the deployment directory contains several configurable parameters that are used by the cronjobs. You can customize these parameters according to your specific requirements. The configurable parameters include:

1. **ollama-model**
   - **Description**: Specifies the model used by the Ollama AI endpoint.
   - **Default Value**: (A default value is provided - mistral:7b-instruct-v0.2-q5_K_M)
   - **Customization**: Update with your specific model identifier if different from the default.
   - **Key in ConfigMap**: `ollama-model`

2. **ollama-prompt-acs**
   - **Description**: Defines the prompt or query format for the ACS violations data when interacting with the Ollama AI endpoint.
   - **Default Value**: (A default prompt is provided.)
   - **Customization**: Update with your tailored prompt that aligns with your specific data format or analytical needs.
   - **Key in ConfigMap**: `ollama-prompt-acs`

3. **ollama-prompt-ocp**
   - **Description**: Sets the prompt or query format for OpenShift cluster events data when submitted to the Ollama AI endpoint.
   - **Default Value**: (A default prompt is provided.)
   - **Customization**: Modify with a custom prompt as needed for your cluster events analysis.
   - **Key in ConfigMap**: `ollama-prompt-ocp`

4. **api-endpoint-ollama**
   - **Description**: The endpoint URL for the Ollama AI service.
   - **Default Value**: `"http://<ollama_url>:<ollama_port>/ollama/api/generate"`
   - **Customization**: Replace `<ollama_url>` and `<ollama_port>` with the actual URL and port of your Ollama AI service.
   - **Key in ConfigMap**: `api-endpoint-ollama`

5. **api-endpoint-stackrox**
   - **Description**: The API endpoint for Red Hat Advanced Cluster Security (ACS) violations.
   - **Default Value**: `"https://<acs_endpoint>/v1/alerts"`
   - **Customization**: Substitute `<acs_endpoint>` with the actual endpoint of your ACS service.
   - **Key in ConfigMap**: `api-endpoint-stackrox`

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
│   ├── ai-cronjob.yaml           # OCP Event Gatherer CronJob
│   ├── cluster-rbac.yaml         # RBAC Configurations
│   ├── configmap.yaml            # Configuration Map
│   ├── namespace.yaml            # Namespace Config
│   ├── ollama-secret.yaml        # Secret for Ollama API
│   └── sa-rbac.yaml              # Service Account RBAC Config
├── Dockerfile                    # Dockerfile for Custom Image
└── README.md                     # This README File
```

