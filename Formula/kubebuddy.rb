class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.34/kubebuddy_0.0.34_darwin_arm64.tar.gz"
      sha256 "e0656fd00f42ac05d32a6f3c0197e2069fd8d2fb00a00016d5313ee266645b86"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.34/kubebuddy_0.0.34_darwin_amd64.tar.gz"
      sha256 "28e83e79049fe04058aa09ef9770b84cecf238ed46379c2b1fe9f449949c0ecc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.34/kubebuddy_0.0.34_linux_arm64.tar.gz"
      sha256 "fdd20b6ea0c5df235d01b18f1b48df91769e72331e18b269ae81ccd9729134f0"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.34/kubebuddy_0.0.34_linux_amd64.tar.gz"
      sha256 "3fdf663ab627df0b9e0a015a81554a6228922373b7390302d801b5a7be7eb6a9"
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
