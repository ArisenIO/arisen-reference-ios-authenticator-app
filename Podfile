using_local_pods = ENV['USE_LOCAL_PODS'] == 'true' || false

platform :ios, '12.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def set_up_local_pods
    pod 'ArisenSwift', :path => '../arisen-swift'
    pod 'ArisenSwiftAbieosSerializationProvider', :path => '../arisen-swift-abieos-serialization-provider'
    pod 'ArisenSwiftVault', :path => '../arisen-swift-vault'
    pod 'ArisenSwiftEcc', :path => '../arisen-swift-ecc'
    pod 'ArisenSwiftVaultSignatureProvider', :path => '../arisen-swift-vault-signature-provider'
    pod 'ArisenSwiftReferenceAuthenticatorSignatureProvider', :path => '../arisen-swift-reference-ios-authenticator-signature-provider'
end

def set_up_remote_pods
    pod 'ArisenSwift', '~> 0.1.1'
    pod 'ArisenSwiftAbieosSerializationProvider', '~> 0.1.1'
    pod 'ArisenSwiftVault', '~> 0.1.1'
    pod 'ArisenSwiftEcc', '~> 0.1.1'
    pod 'ArisenSwiftVaultSignatureProvider', '~> 0.1.1'
    pod 'ArisenSwiftReferenceAuthenticatorSignatureProvider', '~> 0.1.1'
end

if using_local_pods
    # Pull pods from sibling directories if using local pods
    target 'ArisenReferenceAuthenticator' do
        # Pods for ArisenReferenceAuthenticator
        set_up_local_pods
        pod 'ReachabilitySwift'
    end

    target 'ArisenReferenceAuthenticatorTests' do
        inherit! :search_paths
        # Pods for testing
        set_up_local_pods
        pod 'SnapshotTesting', '~> 1.1'
    end

    target 'ArisenReferenceAuthenticatorUITests' do
        inherit! :search_paths
        # Pods for testing, must be all pods
        set_up_local_pods
    end
else
    # Pull pods from sources above if not using local pods
    target 'ArisenReferenceAuthenticator' do
        # Pods for ArisenReferenceAuthenticator
        set_up_remote_pods
        pod 'ReachabilitySwift'
    end

    target 'ArisenReferenceAuthenticatorTests' do
        inherit! :search_paths
        # Pods for testing
        set_up_remote_pods
        pod 'SnapshotTesting', '~> 1.1'
    end

    target 'ArisenReferenceAuthenticatorUITests' do
        inherit! :search_paths
        # Pods for testing, must be all pods
        set_up_remote_pods
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end
