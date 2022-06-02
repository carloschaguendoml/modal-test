# modal-test

```swift
let saveButton = AndesButton()
let exitButton = AndesButton()

AndesModalBuilder(type: .fullscreen)
  .imageStyle(.thumbnail)
  .dissmisable(false)
  .fixedTitle(false)
  .fixedFooter(false)
  .content(
      AndesModalPage(
        image: AndesModalImage { completion in
                 completion(image)
              },
        title: "...",
        body: ".."
      )
  )
  .withAction(saveButton, exitButton, distributtion: .horizontal)
  .build()
  .show(in: self)
```

