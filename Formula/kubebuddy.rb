class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.35/kubebuddy_0.0.35_darwin_arm64.tar.gz"
      sha256 "9b33a6110fd1a6c929cd160193c3295242d7c175a8c84c14c59722884b8fafa6"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.35/kubebuddy_0.0.35_darwin_amd64.tar.gz"
      sha256 "a50342a56e06ade48964ca2685ec37ed36490cde5404d1d7b80714d342412f23"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.35/kubebuddy_0.0.35_linux_arm64.tar.gz"
      sha256 "2d564475157bda23045abcaa81c2a217383c22f95e40859f3fe73df2953a60c6"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.35/kubebuddy_0.0.35_linux_amd64.tar.gz"
      sha256 "799c8beffe38736421e5385381b5b16911d1d8dc211c0d972a415a5dee668e2a"
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
