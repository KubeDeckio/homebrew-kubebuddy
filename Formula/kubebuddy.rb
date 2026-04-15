class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_darwin_arm64.tar.gz"
      sha256 "57f41a7fbc0d0f1b3f36bca9c88cb4d3df25d7aa5ffdd889d6e867117cfea7ff"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_darwin_amd64.tar.gz"
      sha256 "bb1dbfd0d6b8d1ec36588e9297a11352ad9f9d7e8c6513b18ab6f977a98750f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_linux_arm64.tar.gz"
      sha256 "8e1eea25213d56b724737f899da2f5fc71bb47b32d96c1decd7978ff59ba33c6"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_linux_amd64.tar.gz"
      sha256 "56755b6edca90e5e5c42fddebd5688210f7ea0ddde392c42078be8ed451ed284"
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
