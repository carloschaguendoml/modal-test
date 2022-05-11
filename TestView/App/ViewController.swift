//
//  ViewController.swift
//  TestView
//
//  Created by Carlos Chaguendo on 4/05/22.
//

import UIKit

struct Page {
    
    let tile: String
    let body: String
    let header: AndesModalImageStyle
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var ilustrationStyle: UISegmentedControl!
    @IBOutlet weak var verticalAlignmetControl: UISegmentedControl!
    @IBOutlet weak var textAlignment: UISegmentedControl!
    @IBOutlet weak var displayMode: UISegmentedControl!
    @IBOutlet weak var textContent: UISegmentedControl!
    @IBOutlet weak var titleContent: UISegmentedControl!
    
    var modal: AndesModal?
    @IBOutlet weak var fixHeader: UISwitch!
    @IBOutlet weak var fixFooter: UISwitch!
    @IBOutlet weak var allowsDismissButton: UISwitch!
    
    
   
    let largeText = """
        Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum. Es un hecho establecido
        
                hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño. El punto de usar Lorem Ipsum es que tiene una distribución más o menos normal de las letras, al contrario de usar textos como por ejemplo
        
        hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño. El punto de usar Lorem Ipsum es que tiene una distribución más o menos normal de las letras, al contrario de usar textos como por ejemplo "Contenido aquí, contenido aquí". Estos textos hacen parecerlo un español que se puede leer. Muchos paquetes de autoedición y editores de páginas web usan el Lorem Ipsum como su texto por defecto, y al hacer una búsqueda de "Lorem Ipsum" va a dar por resultado muchos sitios web que usan este texto si se encuentran en estado de desarrollo. Muchas versiones han evolucionado a través de los años, algunas veces por accidente, otras veces a propósito (por ejemplo insertándole humor y cosas por el estilo).
        
        Gracias!!
        """
    
    let mediumContent = """
        Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem
        """
    
    let smallContent = """
        Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.
        """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMode.selectedSegmentIndex = 1
        textContent.selectedSegmentIndex = 2
    }
    
    @IBAction func updateContentModeAction(_ sender: Any) {

    }
    
    @IBAction func openModalAction(_ sender: Any) {
        
        let size = AndesModalImageStyle(rawValue: ilustrationStyle.selectedSegmentIndex) ?? .tmb
        let vAlignmet = AndesModalVerticalAlignment(rawValue: verticalAlignmetControl.selectedSegmentIndex) ?? .middle
        let textAling = NSTextAlignment(rawValue: textAlignment.selectedSegmentIndex) ?? .left
        
        let ty = AndesModalHierarchy(rawValue: displayMode.selectedSegmentIndex) ?? .fullscreen
        
        let text: String
        switch textContent.selectedSegmentIndex {
        case 0: text = smallContent
        case 1: text = mediumContent
        default: text = largeText
        }
        
        let title: String
        switch titleContent.selectedSegmentIndex {
        case 0: title = "Modal"
        case 1: title = "This is a multiline  modal title "
        default: title = "This is a multiline modal title and it is used as an exmaple of a long text for example."
        }
        
        modal = AndesModal(
            type: ty,
            imageSize: size,
            stickHeader: fixHeader.isOn,
            stickFooter: fixFooter.isOn,
            allowsDismissButton: allowsDismissButton.isOn,
            vertical: vAlignmet,
            textAlignmet: textAling,
            pages: [AndesModalPage(title: title, body: text)]
        )
        modal?.show(in: self)
    }
}

