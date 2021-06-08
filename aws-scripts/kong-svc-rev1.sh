#!/bin/bash
VAR="2000"
MAX="5000"
NAMESPACE="ingress-stress"
CHECK_NAMESPACE=`kubectl get namespace | grep $NAMESPACE`

fn_create_svc(){
cat <<EOF> /tmp/application-$VAR-svc.yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
  labels:
    run: some-api-$VAR
  name: some-api-$VAR
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: some-api
  sessionAffinity: None
  type: ClusterIP
EOF

kubectl apply -f /tmp/application-$VAR-svc.yaml -n $NAMESPACE 2> /dev/null
rm /tmp/application-$VAR-svc.yaml

}

fn_create_ingress(){
cat <<EOF> /tmp/application-$VAR-ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    konghq.com/preserve-host: "false"
    kubernetes.io/ingress.class: kong
  name: external-some-api-$VAR
spec:
  rules:
  - host: some-api-$VAR.kong-wa-test.blip.tools
    http:
      paths:
      - backend:
          serviceName: some-api-$VAR
          servicePort: 80
        path: /
        pathType: ImplementationSpecific
EOF

kubectl apply -f /tmp/application-$VAR-ingress.yaml -n $NAMESPACE 2> /dev/null
rm /tmp/application-$VAR-ingress.yaml

}

fn_create_entry(){
    fn_create_svc;
    fn_create_ingress;
}

fn_clear_env(){
    kubectl delete ns $NAMESPACE
    kubectl create ns $NAMESPACE
}

#==================================================================

echo "Reset env (Delete and Create) namespace"
#fn_clear_env;

I=1
MAX_I=5

while [ $VAR -le $MAX ]
do
    fn_create_entry &

    I=$(($I+1))
    VAR=$(( $VAR + 1 ))

    if [[ $I -eq $MAX_I ]];then
      wait $(jobs -p)
      I=1
    fi
done

wait $(jobs -p)
