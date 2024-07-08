package helloworld

import (
	"strconv"
)

DesignPattern: {
	name:        "helloworld"
	description: "helloworld"
	parameters: {
		replicas:     string
		imageName:    string
		k8sNamespace: string
	}

	resources: app: {
		resource0: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: name: "flask-app"
			spec: {
				replicas: strconv.Atoi(parameters.replicas)
				selector: matchLabels: app: "flask-app"
				template: {
					metadata: {
						labels: app: "flask-app"
						namespace: parameters.k8sNamespace
					}
					spec: containers: [{
						name:  "flask-app"
						image: parameters.imageName
						ports: [{
							containerPort: 5000
						}]
						env: [{
							name:  "MESSAGE"
							value: "Hello from Kubernetes!"
						}]
					}]
				}
			}
		}
		resource1: {
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name:      "flask-app-service"
				namespace: parameters.k8sNamespace
			}
			spec: {
				selector: app: "flask-app"
				ports: [{
					protocol:   "TCP"
					port:       80
					targetPort: 5000
				}]
				type: "LoadBalancer"
			}
		}
	}
}
