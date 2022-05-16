VAR_MASTER_NODE_IP=""
VAR_USER_NAME=""


ssh -o "StrictHostKeyChecking no" "${VAR_USER_NAME}@${VAR_MASTER_NODE_IP}" "
    sudo kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
"