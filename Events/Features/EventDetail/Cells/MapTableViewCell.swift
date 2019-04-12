import UIKit
import MapKit

final class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location: CLLocationCoordinate2D? {
        didSet {
            guard let location = location else { return }
            let point = MKPointAnnotation()
            point.title = "Teste"
            point.coordinate = location
            mapView.addAnnotation(point)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension MapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
