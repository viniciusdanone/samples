helm repo add bitnami https://charts.bitnami.com/bitnami

CRATE CHART
helm upgrade --install airflow-test bitnami/airflow --set airflow.loadExamples=true \
                                                    --set ingress.enabled=true \
                                                    --set ingress.hosts[0].name=airflow-test.beta.cfood.xyz \
                                                    --set ingress.hosts[0].path=/airflow \
                                                    --set auth.username=danone \
                                                    --set auth.password=danone \
                                                    --set auth.fernetKey=my-fernet-key \
                                                    --set postgresql.postgresqlUsername=bn_airflow \
                                                    --set postgresql.postgresqlPassword="" \
                                                    --set airflow.baseUrl=https://airflow-test.beta.cfood.xyz -n airflow-test 

DELETE
helm delete  airflow-test -n airflow-test