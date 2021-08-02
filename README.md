# MVVM-Swift
Estructura de codigo  Test

## Comenzando 🚀

_Este proyecto se creo usando la estructura de codigo MVVM en Swift, tambien si usas la app sin conexión la misma mostrara la data antes cargada
, la app consume un servicio de pruebas de Hacker News:_

```
https://hn.algolia.com/api/v1/search_by_date?query=mobile
```

El proyecto cuenta con dos vistas, la principal **MainView** donde se muestra un listado de articulos dentro de un **UITableView** y una secundaria llamada **DetailArticleView**
donde se muestra el articulo seleccionado dentro de un **WKWebView.**

### Librerias Utilizadas 📋

Estas librerias son fundamentales para el buen funcionamiento de la app.

```groovy
  pod 'Alamofire', '~> 5.4'
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
```

## Instalar librerias 🛠️

Para poder instalar estas librerias debes tener instalado en tu Mac **CocoaPods**, puedes instalar el mismo desde esta url:

```
https://cocoapods.org/
```

Si ya cuentas con **CocoaPods** en tu Mac solo queda que abras tu terminal y te direcciones dentro del proyecto **MVVM-Swift** y escribas el siguiente comando:

```groovy
  pod install
```

## NOTA IMPORTANTE 📋

_Este proyecto es netamente informativo para mostrar como poder aplicar el patrón **MVVM** usando el consumo de un servicio web de pruebas._

_Al mismo tiempo lo mas coveniente durante el proceso de **eliminar articulos** es realizar el mismo por medio de un servicio web, en este proyecto se realiza de una forma no recomendada para proyectos en producción._

## Linea de código a reemplazar:

```swift
  private func processDataDelete() {
        self.viewModel.mData.getData(key: Constants.STRING_KEYS.DELETE_DATA, value_default: "") { (json) in
            do {

                if json == "" {
                    self.setDataLocal(objectHits: self.objectHits)
                }else {
                    let jsonDecoder    = JSONDecoder()
                    var deleteArticles = try jsonDecoder.decode(ObjectHits.self, from: json.data(using: .utf8)!)

                    for i in (0..<self.objectHits.articulos!.count).reversed() {

                        for j in 0..<deleteArticles.articulos!.count {

                            if self.objectHits.articulos![i].storyId == deleteArticles.articulos![j].storyId {
                                self.objectHits.articulos?.remove(at: i)
                            }

                        }

                    }
                }

            } catch {
                print("JSONSerialization error:", error)
            }
        }
    }
```

## Construido con 🛠️

* [Xcode Version 12.2](https://developer.apple.com/xcode/) - Entorno de desarrollo integrado oficial para la plataforma iOS.
* [CocoaPods](https://cocoapods.org/) - Administrador de dependencias para proyectos Swift y Objective-C
