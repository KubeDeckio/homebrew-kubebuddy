class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.37/kubebuddy_0.0.37_darwin_arm64.tar.gz"
      sha256 "4e0711bcd5c047dd3ed062ace04ea8e437688e340c42650789530bb69299d0ca"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.37/kubebuddy_0.0.37_darwin_amd64.tar.gz"
      sha256 "8d593a3ea670cc0c00973b4c20675f1b34c745ec45b5eec3078b59c84c1e8dd8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.37/kubebuddy_0.0.37_linux_arm64.tar.gz"
      sha256 "bab08480d44025341a3130eb7f41bc098b36e083f06b02232071469b4e2a0a5e"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.37/kubebuddy_0.0.37_linux_amd64.tar.gz"
      sha256 "3c14dd9a69b81b95c9c70b7e025874cf65ec1119d987ada22fb03c50d200b171"
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
