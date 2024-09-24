#!/bin/zsh

vault token lookup &>/dev/null
if [ $? -ne 0 ]; then
  echo "Vault token is invalid or not found. Logging in..."
  vault login -method=oidc &>/dev/null

  if [ $? -ne 0 ]; then
    echo "Failed to log in to Vault. Exiting..."
    sleep 5
    exit 1
  fi
fi

keys_list=$(vault kv list -format=json $VAULT_KUBECONFIGS_PATH 2>/dev/null | jq -r '.[]')

if [ -z "$keys_list" ]; then
  echo "Failed to list keys or no key selected. Vault logged in? VPN connected? Exiting..."
  sleep 5
  exit 1
fi

selected_key=$(echo $keys_list | fzf)

config=$(vault kv get -field=config $VAULT_KUBECONFIGS_PATH/$selected_key 2>/dev/null) 

if [ $? -ne 0 ] || [ -z "$config" ]; then
  echo "Failed to fetch configuration from Vault. Exiting..."
  sleep 5
  exit 1
fi

echo "$config"> ~/.kube/$selected_key.yaml

chmod 0600 ~/.kube/$selected_key.yaml

export KUBECONFIG=~/.kube/$selected_key.yaml
yq -i ".contexts[0].name=\"$selected_key\" | .current-context=\"$selected_key\"" $KUBECONFIG
echo "✅ Switched to context: $selected_key"

#if [ -z "$TMUX" ]
#then
    #tmux new-session -A -s "${selected_key}"
#fi

#if [[ -z "$TMUX" ]]; then
    #tmux new-session -A -s "${selected_key}"
#else
    #tmux new-window -t 1 -n "${selected_key}"
#fi

# selected_namespace=$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | fzf)
# kubectl config set-context --current --namespace=$selected_namespace
