# File Organizer 2000 Backend

This project is a self-hosted backend for the File Organizer 2000 Obsidian plugin. It is designed to be used with Podman, but the YAML files provided can be used for hosting on Kubernetes.

## Prerequisites

- [Podman](https://podman.io/getting-started/installation)
- [Kubernetes](https://kubernetes.io/docs/setup/) (optional)
- [File Organizer 2000](https://github.com/different-ai/file-organizer-2000)

## Building the Image

To build the Docker image using Podman, run the following command:

```sh
podman build -t fo2k-backend .
```

## Running the Service with Podman

Add your BASE64 encoded OpenAPI key to `fo2k_secret_api_key.yaml`

To base64 encode your OpenAI API key on a Linux system, use the following command:

```sh
echo -n 'your-openai-api-key' | base64
```

Replace `'your-openai-api-key'` with your actual OpenAI API key.

To spin up the service using Podman, use the `podman play` command with the provided YAML file:

```sh
podman play kube fo2k_secret_api_key.yaml
podman play kube fo2k_pod.yaml
```

## Running the Service on Kubernetes

If you prefer to run the service on Kubernetes, apply the provided Kubernetes YAML file:

```sh
kubectl apply -f fo2k_secret_api_key.yaml
kubectl apply -f fo2k_pod.yaml
```

## Configuration

Ensure that you configure the necessary environment variables and volumes in the YAML files to match your setup. Specifically the models to be used when using a local Ollama server.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or issues, please open an issue on the GitHub repository.
