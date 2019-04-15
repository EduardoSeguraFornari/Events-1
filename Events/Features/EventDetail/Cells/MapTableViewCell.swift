import UIKit
import MapKit

final class MapTableViewCell: UITableViewCell {
    
    private let identifier = "Annotation"
    
    @IBOutlet weak var mapView: MKMapView!
    var title: String?
    
    var location: CLLocationCoordinate2D? {
        didSet {
            guard let location = location else { return }
            makeAnnotation(location)
        }
    }
    
    private func makeAnnotation(_ location: CLLocationCoordinate2D) {
        let point = (mapView.annotations.first as? MKPointAnnotation)  ?? MKPointAnnotation()
        point.title = title
        point.coordinate = location
        if mapView.annotations.isEmpty {
            mapView.addAnnotation(point)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
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
