resource "k8s_apiextensions_k8s_io_v1beta1_custom_resource_definition" "certificates_cert_manager_io" {
  metadata {
    name = "certificates.cert-manager.io"
  }
  spec {

    additional_printer_columns {
      json_path = <<-EOF
        .status.conditions[?(@.type=="Ready")].status
        EOF
      name      = "Ready"
      type      = "string"
    }
    additional_printer_columns {
      json_path = ".spec.secretName"
      name      = "Secret"
      type      = "string"
    }
    additional_printer_columns {
      json_path = ".spec.issuerRef.name"
      name      = "Issuer"
      priority  = 1
      type      = "string"
    }
    additional_printer_columns {
      json_path = <<-EOF
        .status.conditions[?(@.type=="Ready")].message
        EOF
      name      = "Status"
      priority  = 1
      type      = "string"
    }
    additional_printer_columns {
      json_path   = ".metadata.creationTimestamp"
      description = "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
      name        = "Age"
      type        = "date"
    }
    group = "cert-manager.io"
    names {
      kind      = "Certificate"
      list_kind = "CertificateList"
      plural    = "certificates"
      short_names = [
        "cert",
        "certs",
      ]
      singular = "certificate"
    }
    preserve_unknown_fields = false
    scope                   = "Namespaced"
    subresources {
      status = {
        "" = "" //hack since TF does not allow empty values
      }
    }
    versions {
      name = "v1alpha2"
      schema {
        open_apiv3_schema = <<-JSON
          {
            "description": "Certificate is a type to represent a Certificate from ACME",
            "properties": {
              "apiVersion": {
                "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
                "type": "string"
              },
              "kind": {
                "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
                "type": "string"
              },
              "metadata": {
                "type": "object"
              },
              "spec": {
                "description": "CertificateSpec defines the desired state of Certificate. A valid Certificate requires at least one of a CommonName, DNSName, or URISAN to be valid.",
                "properties": {
                  "commonName": {
                    "description": "CommonName is a common name to be used on the Certificate. The CommonName should have a length of 64 characters or fewer to avoid generating invalid CSRs. This value is ignored by TLS clients when any subject alt name is set. This is x509 behaviour: https://tools.ietf.org/html/rfc6125#section-6.4.4",
                    "type": "string"
                  },
                  "dnsNames": {
                    "description": "DNSNames is a list of subject alt names to be used on the Certificate.",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "duration": {
                    "description": "Certificate default Duration",
                    "type": "string"
                  },
                  "emailSANs": {
                    "description": "EmailSANs is a list of Email Subject Alternative Names to be set on this Certificate.",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "ipAddresses": {
                    "description": "IPAddresses is a list of IP addresses to be used on the Certificate",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "isCA": {
                    "description": "IsCA will mark this Certificate as valid for signing. This implies that the 'cert sign' usage is set",
                    "type": "boolean"
                  },
                  "issuerRef": {
                    "description": "IssuerRef is a reference to the issuer for this certificate. If the 'kind' field is not set, or set to 'Issuer', an Issuer resource with the given name in the same namespace as the Certificate will be used. If the 'kind' field is set to 'ClusterIssuer', a ClusterIssuer with the provided name will be used. The 'name' field in this stanza is required at all times.",
                    "properties": {
                      "group": {
                        "type": "string"
                      },
                      "kind": {
                        "type": "string"
                      },
                      "name": {
                        "type": "string"
                      }
                    },
                    "required": [
                      "name"
                    ],
                    "type": "object"
                  },
                  "keyAlgorithm": {
                    "description": "KeyAlgorithm is the private key algorithm of the corresponding private key for this certificate. If provided, allowed values are either \"rsa\" or \"ecdsa\" If KeyAlgorithm is specified and KeySize is not provided, key size of 256 will be used for \"ecdsa\" key algorithm and key size of 2048 will be used for \"rsa\" key algorithm.",
                    "enum": [
                      "rsa",
                      "ecdsa"
                    ],
                    "type": "string"
                  },
                  "keyEncoding": {
                    "description": "KeyEncoding is the private key cryptography standards (PKCS) for this certificate's private key to be encoded in. If provided, allowed values are \"pkcs1\" and \"pkcs8\" standing for PKCS#1 and PKCS#8, respectively. If KeyEncoding is not specified, then PKCS#1 will be used by default.",
                    "enum": [
                      "pkcs1",
                      "pkcs8"
                    ],
                    "type": "string"
                  },
                  "keySize": {
                    "description": "KeySize is the key bit size of the corresponding private key for this certificate. If provided, value must be between 2048 and 8192 inclusive when KeyAlgorithm is empty or is set to \"rsa\", and value must be one of (256, 384, 521) when KeyAlgorithm is set to \"ecdsa\".",
                    "maximum": 8192,
                    "minimum": 0,
                    "type": "integer"
                  },
                  "organization": {
                    "description": "Organization is the organization to be used on the Certificate",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "renewBefore": {
                    "description": "Certificate renew before expiration duration",
                    "type": "string"
                  },
                  "secretName": {
                    "description": "SecretName is the name of the secret resource to store this secret in",
                    "type": "string"
                  },
                  "subject": {
                    "description": "Full X509 name specification (https://golang.org/pkg/crypto/x509/pkix/#Name).",
                    "properties": {
                      "countries": {
                        "description": "Countries to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "localities": {
                        "description": "Cities to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "organizationalUnits": {
                        "description": "Organizational Units to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "postalCodes": {
                        "description": "Postal codes to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "provinces": {
                        "description": "State/Provinces to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "serialNumber": {
                        "description": "Serial number to be used on the Certificate.",
                        "type": "string"
                      },
                      "streetAddresses": {
                        "description": "Street addresses to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      }
                    },
                    "type": "object"
                  },
                  "uriSANs": {
                    "description": "URISANs is a list of URI Subject Alternative Names to be set on this Certificate.",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "usages": {
                    "description": "Usages is the set of x509 actions that are enabled for a given key. Defaults are ('digital signature', 'key encipherment') if empty",
                    "items": {
                      "description": "KeyUsage specifies valid usage contexts for keys. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3      https://tools.ietf.org/html/rfc5280#section-4.2.1.12 Valid KeyUsage values are as follows: \"signing\", \"digital signature\", \"content commitment\", \"key encipherment\", \"key agreement\", \"data encipherment\", \"cert sign\", \"crl sign\", \"encipher only\", \"decipher only\", \"any\", \"server auth\", \"client auth\", \"code signing\", \"email protection\", \"s/mime\", \"ipsec end system\", \"ipsec tunnel\", \"ipsec user\", \"timestamping\", \"ocsp signing\", \"microsoft sgc\", \"netscape sgc\"",
                      "enum": [
                        "signing",
                        "digital signature",
                        "content commitment",
                        "key encipherment",
                        "key agreement",
                        "data encipherment",
                        "cert sign",
                        "crl sign",
                        "encipher only",
                        "decipher only",
                        "any",
                        "server auth",
                        "client auth",
                        "code signing",
                        "email protection",
                        "s/mime",
                        "ipsec end system",
                        "ipsec tunnel",
                        "ipsec user",
                        "timestamping",
                        "ocsp signing",
                        "microsoft sgc",
                        "netscape sgc"
                      ],
                      "type": "string"
                    },
                    "type": "array"
                  }
                },
                "required": [
                  "issuerRef",
                  "secretName"
                ],
                "type": "object"
              },
              "status": {
                "description": "CertificateStatus defines the observed state of Certificate",
                "properties": {
                  "conditions": {
                    "items": {
                      "description": "CertificateCondition contains condition information for an Certificate.",
                      "properties": {
                        "lastTransitionTime": {
                          "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                          "format": "date-time",
                          "type": "string"
                        },
                        "message": {
                          "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                          "type": "string"
                        },
                        "reason": {
                          "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                          "type": "string"
                        },
                        "status": {
                          "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                          "enum": [
                            "True",
                            "False",
                            "Unknown"
                          ],
                          "type": "string"
                        },
                        "type": {
                          "description": "Type of the condition, currently ('Ready').",
                          "type": "string"
                        }
                      },
                      "required": [
                        "status",
                        "type"
                      ],
                      "type": "object"
                    },
                    "type": "array"
                  },
                  "lastFailureTime": {
                    "format": "date-time",
                    "type": "string"
                  },
                  "notAfter": {
                    "description": "The expiration time of the certificate stored in the secret named by this resource in spec.secretName.",
                    "format": "date-time",
                    "type": "string"
                  }
                },
                "type": "object"
              }
            },
            "type": "object"
          }
          JSON
      }
      served  = true
      storage = true
    }
    versions {
      name = "v1alpha3"
      schema {
        open_apiv3_schema = <<-JSON
          {
            "description": "Certificate is a type to represent a Certificate from ACME",
            "properties": {
              "apiVersion": {
                "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
                "type": "string"
              },
              "kind": {
                "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
                "type": "string"
              },
              "metadata": {
                "type": "object"
              },
              "spec": {
                "description": "CertificateSpec defines the desired state of Certificate. A valid Certificate requires at least one of a CommonName, DNSName, or URISAN to be valid.",
                "properties": {
                  "commonName": {
                    "description": "CommonName is a common name to be used on the Certificate. The CommonName should have a length of 64 characters or fewer to avoid generating invalid CSRs. This value is ignored by TLS clients when any subject alt name is set. This is x509 behaviour: https://tools.ietf.org/html/rfc6125#section-6.4.4",
                    "type": "string"
                  },
                  "dnsNames": {
                    "description": "DNSNames is a list of subject alt names to be used on the Certificate.",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "duration": {
                    "description": "Certificate default Duration",
                    "type": "string"
                  },
                  "emailSANs": {
                    "description": "EmailSANs is a list of Email Subject Alternative Names to be set on this Certificate.",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "ipAddresses": {
                    "description": "IPAddresses is a list of IP addresses to be used on the Certificate",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "isCA": {
                    "description": "IsCA will mark this Certificate as valid for signing. This implies that the 'cert sign' usage is set",
                    "type": "boolean"
                  },
                  "issuerRef": {
                    "description": "IssuerRef is a reference to the issuer for this certificate. If the 'kind' field is not set, or set to 'Issuer', an Issuer resource with the given name in the same namespace as the Certificate will be used. If the 'kind' field is set to 'ClusterIssuer', a ClusterIssuer with the provided name will be used. The 'name' field in this stanza is required at all times.",
                    "properties": {
                      "group": {
                        "type": "string"
                      },
                      "kind": {
                        "type": "string"
                      },
                      "name": {
                        "type": "string"
                      }
                    },
                    "required": [
                      "name"
                    ],
                    "type": "object"
                  },
                  "keyAlgorithm": {
                    "description": "KeyAlgorithm is the private key algorithm of the corresponding private key for this certificate. If provided, allowed values are either \"rsa\" or \"ecdsa\" If KeyAlgorithm is specified and KeySize is not provided, key size of 256 will be used for \"ecdsa\" key algorithm and key size of 2048 will be used for \"rsa\" key algorithm.",
                    "enum": [
                      "rsa",
                      "ecdsa"
                    ],
                    "type": "string"
                  },
                  "keyEncoding": {
                    "description": "KeyEncoding is the private key cryptography standards (PKCS) for this certificate's private key to be encoded in. If provided, allowed values are \"pkcs1\" and \"pkcs8\" standing for PKCS#1 and PKCS#8, respectively. If KeyEncoding is not specified, then PKCS#1 will be used by default.",
                    "enum": [
                      "pkcs1",
                      "pkcs8"
                    ],
                    "type": "string"
                  },
                  "keySize": {
                    "description": "KeySize is the key bit size of the corresponding private key for this certificate. If provided, value must be between 2048 and 8192 inclusive when KeyAlgorithm is empty or is set to \"rsa\", and value must be one of (256, 384, 521) when KeyAlgorithm is set to \"ecdsa\".",
                    "maximum": 8192,
                    "minimum": 0,
                    "type": "integer"
                  },
                  "renewBefore": {
                    "description": "Certificate renew before expiration duration",
                    "type": "string"
                  },
                  "secretName": {
                    "description": "SecretName is the name of the secret resource to store this secret in",
                    "type": "string"
                  },
                  "subject": {
                    "description": "Full X509 name specification (https://golang.org/pkg/crypto/x509/pkix/#Name).",
                    "properties": {
                      "countries": {
                        "description": "Countries to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "localities": {
                        "description": "Cities to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "organizationalUnits": {
                        "description": "Organizational Units to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "organizations": {
                        "description": "Organizations to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "postalCodes": {
                        "description": "Postal codes to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "provinces": {
                        "description": "State/Provinces to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      },
                      "serialNumber": {
                        "description": "Serial number to be used on the Certificate.",
                        "type": "string"
                      },
                      "streetAddresses": {
                        "description": "Street addresses to be used on the Certificate.",
                        "items": {
                          "type": "string"
                        },
                        "type": "array"
                      }
                    },
                    "type": "object"
                  },
                  "uriSANs": {
                    "description": "URISANs is a list of URI Subject Alternative Names to be set on this Certificate.",
                    "items": {
                      "type": "string"
                    },
                    "type": "array"
                  },
                  "usages": {
                    "description": "Usages is the set of x509 actions that are enabled for a given key. Defaults are ('digital signature', 'key encipherment') if empty",
                    "items": {
                      "description": "KeyUsage specifies valid usage contexts for keys. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3      https://tools.ietf.org/html/rfc5280#section-4.2.1.12 Valid KeyUsage values are as follows: \"signing\", \"digital signature\", \"content commitment\", \"key encipherment\", \"key agreement\", \"data encipherment\", \"cert sign\", \"crl sign\", \"encipher only\", \"decipher only\", \"any\", \"server auth\", \"client auth\", \"code signing\", \"email protection\", \"s/mime\", \"ipsec end system\", \"ipsec tunnel\", \"ipsec user\", \"timestamping\", \"ocsp signing\", \"microsoft sgc\", \"netscape sgc\"",
                      "enum": [
                        "signing",
                        "digital signature",
                        "content commitment",
                        "key encipherment",
                        "key agreement",
                        "data encipherment",
                        "cert sign",
                        "crl sign",
                        "encipher only",
                        "decipher only",
                        "any",
                        "server auth",
                        "client auth",
                        "code signing",
                        "email protection",
                        "s/mime",
                        "ipsec end system",
                        "ipsec tunnel",
                        "ipsec user",
                        "timestamping",
                        "ocsp signing",
                        "microsoft sgc",
                        "netscape sgc"
                      ],
                      "type": "string"
                    },
                    "type": "array"
                  }
                },
                "required": [
                  "issuerRef",
                  "secretName"
                ],
                "type": "object"
              },
              "status": {
                "description": "CertificateStatus defines the observed state of Certificate",
                "properties": {
                  "conditions": {
                    "items": {
                      "description": "CertificateCondition contains condition information for an Certificate.",
                      "properties": {
                        "lastTransitionTime": {
                          "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                          "format": "date-time",
                          "type": "string"
                        },
                        "message": {
                          "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                          "type": "string"
                        },
                        "reason": {
                          "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                          "type": "string"
                        },
                        "status": {
                          "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                          "enum": [
                            "True",
                            "False",
                            "Unknown"
                          ],
                          "type": "string"
                        },
                        "type": {
                          "description": "Type of the condition, currently ('Ready').",
                          "type": "string"
                        }
                      },
                      "required": [
                        "status",
                        "type"
                      ],
                      "type": "object"
                    },
                    "type": "array"
                  },
                  "lastFailureTime": {
                    "format": "date-time",
                    "type": "string"
                  },
                  "notAfter": {
                    "description": "The expiration time of the certificate stored in the secret named by this resource in spec.secretName.",
                    "format": "date-time",
                    "type": "string"
                  }
                },
                "type": "object"
              }
            },
            "type": "object"
          }
          JSON
      }
      served  = true
      storage = false
    }
  }
}