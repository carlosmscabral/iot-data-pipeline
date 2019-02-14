# Setting up IoT Core

gcloud config set project $PROJECT_ID

# First, creating Pub/Sub topic
gcloud pubsub topics create envTopic --project="${DEVSHELL_PROJECT_ID:-Cloud Shell}"

# Then, creates IoT registry and connects to the previous topic
gcloud iot registries create iot-registry \
  --region=us-central1 --event-notification-config=topic=envTopic

# Now, creates keys for authenticating the device
openssl req -x509 -newkey rsa:2048 -days 3650 -keyout rsa_private.pem \
    -nodes -out rsa_public.pem -subj "/CN=unused"

# Finally, we register the IoT device with the public key on our registry
gcloud iot devices create test-dev --region=us-central1 \
  --registry=iot-registry \
  --public-key path=rsa_public.pem,type=rs256


# Now, we need the root certificate from Google
wget pki.goog/roots.pem

# And finally run our program. First, virtualenv and pip install :)

virtualenv env && source env/bin/activate
pip install -r requirements.txt

python mqtt_device.py \
  --registry_id iot-registry \
  --device_id test-dev \
  --project_id "${DEVSHELL_PROJECT_ID:-Cloud Shell}" \
  --private_key_file rsa_private.pem \
  --algorithm RS256 \
  --ca_certs roots.pem \
  --cloud_region us-central1