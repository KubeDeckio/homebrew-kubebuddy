class Kubebuddy < Formula
  desc "Native Kubernetes and AKS scanner for reports, audits, and CI"
  homepage "https://kubebuddy.kubedeck.io"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_darwin_arm64.tar.gz"
      sha256 "af2cf7287f52081ea35540eabc83fe38e634ebd86f49715b4b6868960a21cdb0"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_darwin_amd64.tar.gz"
      sha256 "c96d6cd9fea9a594812c810933815b9e0ab702ace03941dbe206f95270bc633c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_linux_arm64.tar.gz"
      sha256 "b41fe444112ff6f9dfe123bac729a68e46fd7c564e22b0774b983778ae2e450c"
    else
      url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.36/kubebuddy_0.0.36_linux_amd64.tar.gz"
      sha256 "0c1b3c14d48166b9deff9532db894f938e021b691e579041f9a70edf8fd06a6a"
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
