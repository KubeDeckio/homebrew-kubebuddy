class Kubebuddy < Formula
  desc "KubeBuddy - A Kubernetes assistant for PowerShell"
  homepage "https://kubebuddy.io"
  url "https://github.com/your-user/kubebuddy/archive/v0.0.4.tar.gz"
  sha256 "<SHA256-of-that-tarball>"
  license "MIT"

  depends_on "powershell"

  def install
    # Install the module into libexec to avoid conflicts
    libexec.install Dir["*"]

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
