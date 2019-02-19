# iot-data-pipeline

The goal of these repository is to present a simple simulated MQTT (IoT) device to be run in Google Cloud.
Integration with Cloud Storage (where 'simulated' environmental data is stored) and also IoT Core is implemented. Device is registered and then
starts publishing IoT messages into the Pub/Sub topic associated with the given IoT Core registry.

_Important!_ The goal is for this simple piece of code to be run on Cloud Shell, therefore leveraging the native Service Account credentials.
The sensor itself won't fetch Service Account credentials - it will run directly, assuming credentials are provided.

The provided shell script shows how to leverage the CLI to create a registry, keys and a device using __gcloud__ commands.
