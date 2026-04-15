class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_darwin_arm64.tar.gz"
      sha256 "03e0eca304cb0038fe981e1f7555320478453ae388dd869024e2919a858924b1"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_darwin_amd64.tar.gz"
      sha256 "f43173ab1996840eb4493b0dc10b0c9ef1622f326a2e9058554c332ed9f79606"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_linux_arm64.tar.gz"
      sha256 "0e2959fa3c576e0fc71e938483a228d822b5ee6358bf2eec68c2ed11127c5ce7"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.28/kubebuddy_0.0.28_linux_amd64.tar.gz"
      sha256 "99bb8b5064441b21d643b906de07884760e142b8f23b7655f48d32858234f737"
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
