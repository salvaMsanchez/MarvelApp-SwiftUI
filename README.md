<a name="top"></a>

<h1 align="center">
  <strong><span>Bootcamp Desarrollo de Apps Móviles </span></strong>
</h1>

---

<p align="center">
  <strong><span style="font-size:20px;">Módulo: iOS superpoderes 🍏</span></strong>
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
	* [Descripción](#descripcion)
	* [Arquitectura](#arquitectura)
	* [Diseño](#diseno) 
	* [Programación reactiva con Combine](#combine)
	* [Gestión asíncrona con `async/await`](#asincrono)

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

![Demo app gif](images/demoApp.gif)

<a name="descripcion"></a>
### Descripción

Pequeña aplicación iOS para poner en práctica programación reactiva con el *framework* **Combine**; llamadas asíncronas a *[The Marvel Comics API](https://developer.marvel.com)* con **`async/await`**; el uso del patrón de diseño **MVVM** empleando casos de uso conectados con un repositorio (como explico en la sección de [Arquitectura](#arquitectura)) en pos de crear un sistema de *software* escalable, mantenible y testable (arquitectura **CLEAN**); y el acoplamiento de todo lo anterior con el pertinente desarrollo en **UIKit**.

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
* **Facilita las pruebas unitarias:** aunque en este caso no se han añadido *tests*, realizar la arquitectura como se indica facilita la inyección de dependencias con casos *fake*, por ejemplo. Incluso nos podría servir para diseñar nuestras pantallas sin realizar llamadas a la API.
* **Independencia de componentes:** permite trabajar de forma independiente y simultánea en los componentes durante el desarrollo.
* **Reutilización de código:** mantiene una separación limpia entre la lógica de la aplicación y la UI, lo que puede mejorar significativamente las oportunidades de reutilización de código.

Debemos destacar el rol del ***respository***, el cual es el responsable de manejar las operaciones de datos. Puede interactuar con diferentes fuentes de datos como “Local” (CoreData, por ejemplo) o “Network” (API, por ejemplo) sin que las capas superiores sepan qué está sucediendo.

<a name="diseno"></a>
### Diseño

Como inspiración, he partido del **[concepto creativo y prototipo](https://dribbble.com/shots/2671572-Marvel-App/attachments/537660?mode=media)** del usuario llamado [Luis Herrero](https://dribbble.com/luisherrero) encontrado en la web [Dribbble](https://dribbble.com), punto de partida que me ha ayudado para comenzar este proyecto.

<a name="combine"></a>
### Programación reactiva con Combine

He empleado el *framework* **Combine** para gestionar flujos de datos asíncronos y eventos en la aplicación. Combine **facilita la composición y gestión de secuencias de eventos**, proporcionando operadores para transformar, combinar y manipular datos de manera declarativa. Este enfoque funcional **simplifica la lógica de manejo de eventos** y permite una **programación reactiva más eficiente**.

<a name="asincrono"></a>
### Gestión asíncrona con `async/await`

Se han implementado llamadas asíncronas utilizando las funciones `async` y `await`. Esta característica, introducida en ***Swift 5.5***, me ha posibilitado **simplificar la escritura** de código asíncrono al permitir que las funciones asíncronas se vean y se utilicen de manera similar a las funciones síncronas. Además, al emplear `async/await`, las operaciones asíncronas se desarrollan de manera más clara y concisa, mejorando la legibilidad del código.

# TODO

* Separar vistas en subvistas para más organización
* Comentar código
* Adaptación a SmartWatch
* Dirigir a SeriesView desde Favoritos
* Test

# NOTAS SOBRE QUÉ ESCRIBIR

* [iOS 16 not responding to changes in section spacing](https://www.reddit.com/r/SwiftUI/comments/xia4sv/ios_16_not_responding_to_changes_in_section/?rdt=63091)
* [ListStyle](https://sarunw.com/posts/swiftui-list-style/)
* [SwiftUI NavigationLink Hide Arrow Indicator on List](https://thinkdiff.net/swiftui-navigationlink-hide-arrow-indicator-on-list-b842bcb78c79)
* [A Guide to Utilize Lottie Animations in SwiftUI watchOS](https://medium.com/@achmadsyarieft/a-guide-to-utilize-lottie-animations-in-swiftui-watchos-b76e07524700)
* [iOS Share CoreData with Extension and App Groups](https://medium.com/@pietromessineo/ios-share-coredata-with-extension-and-app-groups-69f135628736)
* Solo CoreData para la liista de héroes.

# Mejoras a implementar

* CoreData para lista de series
* Detalle para series ya que el texto queda mal a nivel diseño y no se lee, tanto para móvil como para reloj
* Implementar conectividad entre móvil y reloj


---

[Subir ⬆️](#top)

---
