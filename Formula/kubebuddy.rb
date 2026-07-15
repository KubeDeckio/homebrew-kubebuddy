class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.33/kubebuddy_0.0.33_darwin_arm64.tar.gz"
      sha256 "f2d0563c6dd3633bf16f38fe4947cc24f130e72f74f682fbe5b69c679021cfae"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.33/kubebuddy_0.0.33_darwin_amd64.tar.gz"
      sha256 "b23931d060c5764d34c8b05dad50d095e135f8cb73d1fd7e95f822a31efa0d75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.33/kubebuddy_0.0.33_linux_arm64.tar.gz"
      sha256 "0433da7d00aee5a2176ef022f1d699c96d7a78e0a80daa149aa8cc1b761e66aa"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.33/kubebuddy_0.0.33_linux_amd64.tar.gz"
      sha256 "cb53f3662e602300962277b6c165d429b2dc53f00af96ffd6d4267a9ad8ac253"
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
