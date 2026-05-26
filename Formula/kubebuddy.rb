class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.30/kubebuddy_0.0.30_darwin_arm64.tar.gz"
      sha256 "c5a1fca6d965ff87c0b33be3505c9097308969501e6481b67c4accc72bea9525"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.30/kubebuddy_0.0.30_darwin_amd64.tar.gz"
      sha256 "160ad398ef5a0735060bb03f190a3eb8c45d84089c785e299b5ff5a6ceba81f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.30/kubebuddy_0.0.30_linux_arm64.tar.gz"
      sha256 "25be3810905c51357840d79554239cc5b110163452ff961a39ab38e9b94778d5"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.30/kubebuddy_0.0.30_linux_amd64.tar.gz"
      sha256 "c295d9dfc805bc3d5857c87238da89be5d417b9e5cd9c0681b2f7d82f4be5de8"
    end
  end

  def install
    bin.install "kubebuddy"
    pkgshare.install "README.md", "LICENSE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kubebuddy version")
  end
end
