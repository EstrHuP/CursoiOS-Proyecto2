//
//  LocationPermissionInteractor.swift
//  CursoiOS-Proyecto2
//
//  Created by Esther Huecas on 27/1/22.
//

import Foundation
import CoreLocation

class LocationPermissionInteractor: NSObject {
    var output: PermissionsInteractorOutputContract?
    
    private let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }
}

extension LocationPermissionInteractor: PermissionsInteractorContract {
    var currentPermission: PermissionInteractorStatus {
        //traducir los permisos del locationManager
        switch locationManager.authorizationStatus {
        case .notDetermined: return .unknown
        case .restricted, .denied: return .denied
        case .authorizedAlways, .authorizedWhenInUse: return .allowed
        @unknown default: return .unknown
        }
    }
    
    func askForPermission() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationPermissionInteractor: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        output?.didUpdatePermission(status: currentPermission)
    }
}
