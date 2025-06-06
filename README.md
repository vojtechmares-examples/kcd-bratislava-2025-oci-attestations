# kcd-bratislava-2025-oci-attestations

## Setup Policy Controller

Install Policy Controller:

```bash
helm repo add
helm repo update

kubectl create namespace cosign-system
helm install -n cosign-system policy-controller sigstore/policy-controller
```

Load cosign public key:

```bash
kubectl create secret generic cosign-pubkey -n \
cosign-system --from-file=cosign.pub=./cosign.pub
```

Add label application namespace to opt-in:

```bash
kubectl label namespace kcd-demo policy.sigstore.dev/include="true"
```

## Demo

1. Install podinfo – nothing works, because default behavior is to deny all

    ```bash
    helm upgrade --install -n kcd-demo podinfo podinfo/podinfo
    # fails
    ```

1. Install unsigned demo app – fails

    ```bash
    kubectl apply -f k8s/apps/unsigned-app-deployment.yaml
    ```

1. Create policy that allows images from `ghcr.io/vojtechmares-examples/kcd-bratislava-2025-oci-attestations/**`

    ```bash
    kubectl apply -f k8s/policies/allow-only-ghcrio-vojtechmares-examples-images.yaml

    # try installing deployment again
    kubectl apply -f k8s/apps/unsigned-app-deployment.yaml
    ```

1. Deploy policy to allow only signed images with private key

    ```bash
    kubectl apply -f k8s/policies/signed-images-with-demo-key.yaml

    # delete pod of unsigned-demo-app
    kubectl delete pod -l app=unsigned-demo-app

    # install signed app
    kubectl apply -f k8s/apps/signed-app-deployment.yaml
    ```

## More

Policy examples:

[Sigstore Policy Controller examples](https://github.com/sigstore/policy-controller/tree/main/examples/policies)
