class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.29/kubebuddy_0.0.29_darwin_arm64.tar.gz"
      sha256 "bf25b21b045e642e9cb3b9e8137dede6f7db8b7db7c8bee9248e55dbc26db0d5"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.29/kubebuddy_0.0.29_darwin_amd64.tar.gz"
      sha256 "6f82eeb10adc5ea9511ef2ed76b1a8d1e9ddf203bf7c1d6b3f5cf73c6513d9a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.29/kubebuddy_0.0.29_linux_arm64.tar.gz"
      sha256 "ba4dacae07d2724b08c53d6d34be034c5a25a6aa96823c4eadaa2394de5ba3f9"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.29/kubebuddy_0.0.29_linux_amd64.tar.gz"
      sha256 "32a9375015eaf7948f0d41c6d8baa7865e1f25c495470c2bf69bca4a2da5675e"
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
