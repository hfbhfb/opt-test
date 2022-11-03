
## 镜像说明: hefabao/mygoapp:v0.0.1 

``` bash

cat >opt-test.yaml<<HFBEOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: opt-test
  name: opt-test
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: opt-test
  template:
    metadata:
      labels:
        app: opt-test
    spec:
      containers:
      - image: hefabao/mygoapp:v0.0.1
        name: opt-test
        command:
          - /bin/sh
          - /etc/opt-test/opt.sh
        resources:
          requests:
            cpu: 109m
            memory: 100Mi
          limits:
            cpu: 501m
            memory: 501Mi
        volumeMounts:
          - name: config-volume
            mountPath: /etc/opt-test/
      imagePullSecrets:
        - name: IfNotPresent
      volumes:
        - name: config-volume
          configMap:
            name: opt-test
            items:
            - key: "opt.sh"
              path: "opt.sh"
            - key: "appwatch.txt"
              path: "appwatch.txt"
---
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    component: "opt-test"
    app: opt-test
  name: opt-test
  namespace: default
data:
  opt.sh: |
    echo "后台启动应用"
    /mygoapp &
    sleep 1
    programpid=\`ps|grep mygoapp|grep -v grep|awk '{print $1}'\`
    while true;do
      newmd5=\`md5sum /etc/opt-test/appwatch.txt\`

      if [ "\$beformd5" == "\$newmd5" ];
      then
        echo "not change"
      else
        kill -10 \$programpid
        echo "changed"
        echo "changed"
      fi
      beformd5=\$newmd5

      #echo "wait 5 second"
      sleep 5
    done
  appwatch.txt: |
    $RANDOM

HFBEOF

# kubectl delete -f opt-test.yaml
kubectl apply -f opt-test.yaml

``` 


