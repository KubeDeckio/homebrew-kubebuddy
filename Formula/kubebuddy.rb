class Kubebuddy < Formula
  desc "A Kubernetes assistant for PowerShell"
  homepage "https://kubebuddy.io"
  url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.24/kubebuddy-v0.0.24.tar.gz"
  sha256 "1584dba183cb262370dbb74df3efaffa39410eb4d3b0a06a8199b0bda71d73a9"
  license "MIT"

  depends_on cask: "powershell"

  def install
    # Install the module into libexec to avoid conflicts
    libexec.install Dir["*"]

    # Install PowerShell Gallery dependencies into current user scope
    system "pwsh", "-Command", <<~PS1
      Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
      Install-Module -Name powershell-yaml -Scope CurrentUser -Force
      Install-Module -Name PSAI -Scope CurrentUser -Force
    PS1

    # Create a shim script so users can invoke `kubebuddy` directly
    (bin/"kubebuddy").write <<~EOS
      #!/usr/bin/env pwsh
      Import-Module "#{libexec}/KubeBuddy.psd1" -Force
      Invoke-KubeBuddy @Args
    EOS
    chmod 0755, bin/"kubebuddy"
  end

  test do
    # Basic smoke test: ensure help text includes the module name
    assert_match "KubeBuddy", shell_output("#{bin}/kubebuddy -h", 1)
  end
end
