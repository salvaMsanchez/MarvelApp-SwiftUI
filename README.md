<a name="top"></a>

<h1 align="center">
  <strong><span>Bootcamp Desarrollo de Apps Móviles </span></strong>
</h1>

---

<p align="center">
  <strong><span style="font-size:20px;">Módulo: iOS Superpoderes 🍏</span></strong>
</p>

---

<p align="center">
  <strong>Autor:</strong> Salva Moreno Sánchez
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/salvador-moreno-sanchez/">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
  </a>
</p>

## Índice
 
* [Herramientas](#herramientas)
* [Proyecto: Marvel App 🦸🏻‍♂️ SwiftUI](#proyecto)
	* [iOS](#ios)
	* [WatchOS](#watchos)
	* [API Key & Hash](#apikey)
	* [Descripción](#descripcion)
	* [Arquitectura](#arquitectura)
	* [Diseño](#diseno) 
	* [Problemas, decisiones y resolución](#problemas)
		* [Uso de CoreData con SwiftUI](#coredata)
		* [Utilización de *Routing* para la navegación con un *routeViewModel*](#route)
		* [Ocultar el indicador de flecha en `List`](#chevron)
		* [Uso de animaciones Lottie en WatchOS con SwiftUI](#lottie)
	* [Algunos aspectos en los que seguir mejorando la aplicación](#mejoras)

<a name="herramientas"></a>
## Herramientas

<p align="center">

<a href="https://www.apple.com/es/ios/ios-17/">
   <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS">
 </a>
  
 <a href="https://www.swift.org/documentation/">
   <img src="https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
 </a>
  
 <a href="https://developer.apple.com/xcode/">
   <img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" alt="XCode">
 </a>
  
</p>

* **iOS:** 16
* **Swift:** 5.9
* **Xcode:** 14.3.1

<a name="proyecto"></a>
## Proyecto: Marvel App 🦸🏻‍♂️ SwiftUI

<a name="ios"></a>
### iOS

![Demo app iOS gif](images/demoAppiOS.gif)

<a name="watchos"></a>
### WatchOS

![Demo app WatchOS gif](images/demoAppWatchOS.gif)

<a name="apikey"></a>
### API Key & Hash

Para poder realizar las llamadas a *[The Marvel Comics API](https://developer.marvel.com)*  es necesario seguir los pasos que se indican en la documentación para conseguir la *API Key* y el *Hash*, los cuales debemos introducir en este proyecto en el `struct` llamado `Constants` en **Data > Network > APIClient**.

```swift
// MARK: - Constants -
struct Constants {
    static let apikey = "<API KEY>"
    static let ts = "1"
    static let hash = "<HASH>"
    static let orderBy = "-modified"
}
```

<a name="descripcion"></a>
### Descripción

Aplicación iOS como proyecto final del módulo *iOS Superpoderes* del *Bootcamp en Desarrollo de Apps Móviles* de [KeepCoding](https://keepcoding.io), donde se nos ha propuesto seguir el **patrón de diseño MVVM con SwiftUI** y consumir datos de *[The Marvel Comics API](https://developer.marvel.com)*, teniendo en cuenta los siguientes requisitos:

* Obligatorios:
	* Usar SwiftUI.
	* Usar Combine.
	* Alcanzar un 50% mínimo de cobertura respecto a las pruebas unitarias.
	* Pantallas: listado de héroes y detalle de cada uno mostrando las series en las que aparece.
* Opcionales:
	* Agregar pantallas de carga.
	* Uso de `Async/Await` en vez de Combine.

Cabe destacar que me he decantado por el **uso de asincronía con `Async/Await` ya que permite una adecuada integración para la consecución óptima de una arquitectura *CLEAN* a través del uso de protocolos, casos de uso, *repository*, etc.**, tal y como explico en la sección de [Arquitectura](#arquitectura).

Hasta el momento, **el uso del *framework* Combine lo veo muy útil para implementar programación reactiva en UIKit** para gestión de estados, establecimiento de observadores en variables, *bindings*, etc. Un ejemplo de ello es el **proyecto [Marvel App 🦸🏻‍♂️ UIKit + Combine](https://github.com/salvaMsanchez/MarvelApp-UIKit-Combine)** albergado en mi [GitHub](https://github.com/salvaMsanchez).

También, debo señalar que, a causa de que la API de Marvel devuelve héroes que no tienen descripción, foto, etc., he desarrollado las llamadas en función a un listado de nombres que he escogido, los cuales representan los superhéroes más relevantes y que albergan en sí todos los datos a emplear en la aplicación en pos de tener un producto final más visual y estético.

<a name="arquitectura"></a>
### Arquitectura

Según [uncle Bob's Clean Architecture pattern](https://blog.cleancoder.com/uncle-bob/2011/11/22/Clean-Architecture.html), se puede dividir el código en 3 capas:

* *Presentation*: todo el código que depende del *framework*. *Views, ViewModels, ViewControllers*, etc.
* *Data*: todo el código que interactúa con los repositorios (como llamadas a red, llamadas a la base de datos, valores predeterminados de usuario, etc.).
* *Domain*: todos los modelos de datos.

Además de seguir las indicaciones del citado Robert Cecil Martin, experto ingeniero de *software*, he concretdo la organización de mi código como se observa en la siguiente imagen:

![Demo app gif](images/diagramaMVVM.png)

De esta forma, conseguimos:

* **Separación de responsabilidades:** esto facilita la resolución de numerosos problemas de desarrollo y hace que una aplicación sea más fácil de probar, mantener y evolucionar.
* **Reducción de la lógica de negocio:** se reduce la cantidad de lógica de negocio requerida en el código detrás de ella.
* **Facilita las pruebas unitarias:** realizar la arquitectura como se indica facilita la inyección de dependencias con casos *fake*, tal y como se ha realizado en los *tests* de los casos de uso. Además, nos sirve para diseñar nuestras pantallas sin realizar llamadas a la API.
* **Independencia de componentes:** permite trabajar de forma independiente y simultánea en los componentes durante el desarrollo.
* **Reutilización de código:** mantiene una separación limpia entre la lógica de la aplicación y la UI, lo que puede mejorar significativamente las oportunidades de reutilización de código.

Debemos destacar el rol del ***respository***, el cual es el responsable de manejar las operaciones de datos. Puede interactuar con diferentes fuentes de datos como `Local` (CoreData, por ejemplo) o `Network` (API, por ejemplo) sin que las capas superiores sepan qué está sucediendo.

<a name="diseno"></a>
### Diseño

Como inspiración, he partido del **[concepto creativo y prototipo](https://github.com/salvaMsanchez/ux-ui-bootcamp)** que desarrollé en **Figma** como proyecto final del módulo *UX móvil & diseño de UI* del *Bootcamp en Desarrollo de Apps Móviles*, punto de partida que me ha ayudado para comenzar a desarrollar este proyecto.

<a name="problemas"></a>
### Problemas, decisiones y resolución

<a name="coredata"></a>
#### Uso de CoreData con SwiftUI

Cuando construyes un proyecto con SwiftUI y CoreData para persistir datos, Xcode ya te incluye en el ciclo de vida del proyecto el `persistenceController` como variable de entorno para que se pueda usar en cualquier vista.

Sin embargo, he optado por realizar las llamadas a CoreData al igual que lo haría con una API, dejando la responsabilidad de ello al *repository*, acorde a la arquitectura que vengo exponiendo. De esta forma, y como ya se ha comentado en la sección de [Arquitectura](#arquitectura), conseguimos **separar responsabilidades, reducir la lógica de negocio, facilitar las pruebas unitarias y reutilizar código**.

Aquello que no he podido conseguir en relación a CoreData ha sido la **conectividad y sincronía de los datos persistidos en memoria entre la aplicación iOS y WatchOS**. Estuve realizando búsquedas sobre ello, pero su implementación requería de más tiempo, por lo que representa un tema pendiente de estudio. Pienso que este artículo titulado [iOS Share CoreData with Extension and App Groups](https://medium.com/@pietromessineo/ios-share-coredata-with-extension-and-app-groups-69f135628736) del autor [Pietro Messineo](https://medium.com/@pietromessineo) podría ser un buen punto de partida para su debida investigación.

<a name="route"></a>
#### Utilización de *Routing* para la navegación con un *routeViewModel*

Aunque en un principio puede parecer innecesario en un proyecto simple, su inclusión se basa en las **buenas prácticas de desarrollo y la planificación para el crecimiento futuro del proyecto**.

Para entenderlo, debemos exponer que un `RouteViewModel` se trata de una abstracción que se encarga de manejar la navegación dentro de la aplicación. Su utilidad principal radica en **simplificar y desacoplar la lógica de navegación del resto de pantallas**. Esto permite una mayor modularidad y facilita la expansión y mantenimiento del código a medida que el proyecto evoluciona.

Así, y como ya he mencionado, la inclusión de un `RouteViewModel` puede parecer innecesaria en un proyecto como este; sin embargo, su adopción se justifica por la **visión a largo plazo** y el deseo de **mantener un código limpio y escalable**. Este enfoque proactivo sienta las bases para futuras expansiones y la incorporación de características más avanzadas, como el manejo de sesiones de usuario y otras funcionalidades complejas.

<a name="chevron"></a>
#### Ocultar el indicador de flecha en `List`

Para ser fiel al concepto creativo del que partía para el diseño, debía ocultar el *chevron* predeterminado que aparece en las `List` cuando usamos `NavigationLink`.

Después de realizar varias búsquedas, me encontré el magnífico artículo titulado [SwiftUI NavigationLink Hide Arrow Indicator on List](https://thinkdiff.net/swiftui-navigationlink-hide-arrow-indicator-on-list-b842bcb78c79) del autor [Mahmud Ahsan](https://mahmudahsan.medium.com), donde detalla cómo hacerlo en diversas versiones del sistema operativo iOS y, además, aquellos problemas que pueden surgir.

<a name="lottie"></a>
#### Uso de animaciones Lottie en WatchOS con SwiftUI

Sorpresa fue la mía cuando la implementación de las animaciones Lottie en WatchOS no se realizaba de la misma manera que para iOS. Representó un quebradero de cabeza hasta que encontré el artículo titulado [A Guide to Utilize Lottie Animations in SwiftUI watchOS](https://medium.com/@achmadsyarieft/a-guide-to-utilize-lottie-animations-in-swiftui-watchos-b76e07524700) del autor [Achmad Syarief Thalib](https://medium.com/@achmadsyarieft), donde explica paso a paso cómo podemos conseguir manipular de forma exitosa animaciones Lottie para WatchOS.

<a name="mejoras"></a>
## Algunos aspectos en los que seguir mejorando la aplicación

* **CoreData para Series:** utilizar CoreData para gestionar eficientemente la información de las series en la aplicación, facilitando la manipulación y recuperación de datos.
* **Pantalla de Detalle para Series:** con el fin de mejorar la legibilidad y diseño mediante un diseño *responsive*, tamaños de texto dinámicos, organización en tarjetas, etc.
* **Implementar conectividad entre móvil y reloj:** sincronización de datos y garantizar seguridad para lograr una interacción fluida entre dispositivos móviles y relojes inteligentes.

---

[Subir ⬆️](#top)

---


