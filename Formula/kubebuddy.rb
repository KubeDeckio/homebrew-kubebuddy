class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.32/kubebuddy_0.0.32_darwin_arm64.tar.gz"
      sha256 "5ac300990c9952ea47bbe70d3b71ce0b189913c11a668e6d9f42970ccbbba923"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.32/kubebuddy_0.0.32_darwin_amd64.tar.gz"
      sha256 "499fcf19d994bec32daab36e13c80b9de34b80820ef8464de8324d08a0cc17f5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.32/kubebuddy_0.0.32_linux_arm64.tar.gz"
      sha256 "be0e01feabf4d04653fcf9e2e218bdc599417c923408513f6dc496359d575f67"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.32/kubebuddy_0.0.32_linux_amd64.tar.gz"
      sha256 "5c0e59f260ba1f92e31aee065fcec8e5e332f2b3f59c09e6e36f1426c1869c1b"
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
