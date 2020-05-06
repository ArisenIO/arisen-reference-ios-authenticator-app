//
//  AuthenticatorRequestViewController+SelectiveDisclosure.swift
//  Arisen
//
//  Created by Todd Bowden on 11/13/18.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation
import ArisenSwift
import ArisenSwiftReferenceAuthenticatorSignatureProvider


extension AuthenticatorRequestViewController {


    func handleSelectiveDisclosureRequest(payload: ArisenReferenceAuthenticatorSignatureProvider.RequestPayload,
                                          manifest: AppManifest,
                                          completion: @escaping (ArisenReferenceAuthenticatorSignatureProvider.SelectiveDisclosureResponse?)->Void) {
        
        guard let selectiveDisclosureRequest = payload.request.selectiveDisclosure else { return completion(nil) }
        
        present(selectiveDisclosureRequest: selectiveDisclosureRequest, manifest: manifest) { [weak self] (didAllow) in
            guard let strongSelf = self else {
                return completion(ArisenReferenceAuthenticatorSignatureProvider.SelectiveDisclosureResponse(error: ArisenError(.unexpectedError, reason: "self not in scope")))
            }
            strongSelf.handleSelectiveDisclosureUserResponse(didAllow: didAllow, completion: completion)
        }
        
    }

    
    func present(selectiveDisclosureRequest: ArisenReferenceAuthenticatorSignatureProvider.SelectiveDisclosureRequest, manifest: AppManifest, reply: @escaping (Bool)->Void) {
        let selectiveDisclosureViewController = UIStoryboard(name: "SelectiveDisclosure", bundle: nil).instantiateViewController(withIdentifier: "SelectiveDisclosureViewController") as! SelectiveDisclosureViewController
        print(manifest)
        
        selectiveDisclosureViewController.reply = reply
        selectiveDisclosureViewController.request = selectiveDisclosureRequest
        selectiveDisclosureViewController.appName = manifest.metadata.shortname
        selectiveDisclosureViewController.appDescription = manifest.metadata.description
        selectiveDisclosureViewController.appIcon = manifest.metadata.iconImage
        selectiveDisclosureViewController.appUrl = manifest.domain
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(selectiveDisclosureViewController, animated: false)
            
        }
        
    }
    
    
    func handleSelectiveDisclosureUserResponse(didAllow: Bool, completion: @escaping (ArisenReferenceAuthenticatorSignatureProvider.SelectiveDisclosureResponse?)->Void) {
        var response = ArisenReferenceAuthenticatorSignatureProvider.SelectiveDisclosureResponse()
        guard didAllow else {
            response.error = ArisenError(ArisenErrorCode.signatureProviderError, reason: "User Declined")
            return completion(response)
        }

        getAllDevices(completion: { (devices, error) in
            if let error = error  {
                response.error = error
                return completion(response)
            }
            var authorizers = [ArisenReferenceAuthenticatorSignatureProvider.Authorizer]()
            if let devices = devices {
                for device in devices {
                    for key in device.keys {
                        if key.isEnabled {
                            var authorizer = ArisenReferenceAuthenticatorSignatureProvider.Authorizer()
                            authorizer.publicKey = key.publicKey
                            authorizers.append(authorizer)
                        }
                    }
                }
            }
            response.authorizers = authorizers
            completion(response)
        })

    }

    private func getAllDevices(completion: ([Device]?, ArisenError?)->Void ) {
        completion([Device.current],nil)
    }


}
