class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_darwin_arm64.tar.gz"
      sha256 "bbba95351cd1b7d288f419e64f95284cdf4dd55b56fe90d625b9ab84bdf1172d"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_darwin_amd64.tar.gz"
      sha256 "ad23e3f12dc5b476ab3bca5523a55cbead9e081f40a6c961b65d2e3cd614a885"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_linux_arm64.tar.gz"
      sha256 "df698e0c55da4a5f790872d0e2cea26d9016e30d37bd1c184a81e8a80d93c32f"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_linux_amd64.tar.gz"
      sha256 "df67c6e01b709abb54fac4aca0e6ddd51022c2c29d4b68e30c6a2a35791fd650"
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
