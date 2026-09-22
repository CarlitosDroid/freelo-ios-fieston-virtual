# Librerías utilizadas en el proyecto FiestonVirtual

## 1. CocoaPods

El proyecto utiliza CocoaPods como gestor de dependencias.

### Dependencias directas
Son las librerias, declaradas explicitamente (uno mismo escribe esta dependencia) en el podfile del proyecto.

| Librería | Versión |
| Firebase/Analytics | 11.15.0 |
| Firebase/Messaging | 11.15.0 |

### Dependencias transitivas
Son las librerias requqeridas internamente por las dependecias directas. No se declaran directamente en el podfile sino que cocoapods las resuelve e instala de manera automatica.

| Librería | Versión |
| Firebase | 11.15.0 |
| FirebaseAnalytics | 11.15.0 |
| FirebaseCore | 11.15.0 |
| FirebaseCoreInternal | 11.15.0 |
| FirebaseInstallations | 11.15.0 |
| FirebaseMessaging | 11.15.0 |
| GoogleAdsOnDeviceConversion | 2.1.0 |
| GoogleAppMeasurement | 11.15.0 |
| GoogleDataTransport | 10.1.1 |
| GoogleUtilities | 8.1.2 |
| nanopb | 3.30910.0 |
| PromisesObjC | 2.4.1 |

Versión de CocoaPods utilizada: 1.16.2.

---

## 2. Swift Package Manager

El proyecto utiliza Swift Package Manager (SPM) para gestionar las siguientes dependencias:

| # | Librería | Versión |
| 1 | Alamofire | 5.2.2 |
| 2 | IQKeyboardManagerSwift | 6.5.6 |
| 3 | Kingfisher | 5.15.5 |
| 4 | QGrid | 0.1.4 |
| 5 | SocketIO | 15.2.0 |
| 6 | Grid | 1.0.4 |
| 7 | Introspect | 0.1.1 |
| 8 | SwiftUIPager | 1.11.0 |
| 9 | SwiftyJSON | 5.0.0 |
| 10 | Swinject | 2.7.1 |

Las dependencias de Swift Package Manager están configuradas utilizando la regla "Up to Next Major Version".