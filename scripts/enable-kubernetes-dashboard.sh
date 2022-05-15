#TODO Fillout
VAR_MASTER_NODE_IP=""
VAR_USER_NAME=""


ssh-keygen -R $VAR_MASTER_NODE_IP

ssh -o "StrictHostKeyChecking no" "${VAR_USER_NAME}@${VAR_MASTER_NODE_IP}" "
cat << EOF > dashboard.admin-user.yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

cat << EOF > dashboard.admin-user-role.yml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF
"

ssh -o "StrictHostKeyChecking no" "${VAR_USER_NAME}@${VAR_MASTER_NODE_IP}" "
export GITHUB_URL=https://github.com/kubernetes/dashboard/releases
export VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
sudo k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
sudo kubectl create -f dashboard.admin-user.yml -f dashboard.admin-user-role.yml

"

#Next change the kubernetes dashboard service "ClusterIP" type to "NodePort" usinf this command:
#sudo env EDITOR=nano kubectl edit service kubernetes-dashboard -n kubernetes-dashboard

