class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.31/kubebuddy_0.0.31_darwin_arm64.tar.gz"
      sha256 "a6e2515e7d1b9dde028818c9cf3bd8a98aceaeb21aa3cb26c8174c253f22a735"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.31/kubebuddy_0.0.31_darwin_amd64.tar.gz"
      sha256 "99f41f0a3141a585597b475586f2dec76f9213243537a074e5920aed31e2ac8f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.31/kubebuddy_0.0.31_linux_arm64.tar.gz"
      sha256 "459618c004755c3f4f1961c26cc8c6d72832fad0d89366af58b5d6b0c7e0c8a6"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.31/kubebuddy_0.0.31_linux_amd64.tar.gz"
      sha256 "4f3837c6fbe52bbc8616138ace0eb2a571b7c77010fbb16f7d50b4912a3fc45e"
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
