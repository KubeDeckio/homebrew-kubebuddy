class Kubebuddy < Formula
  desc "KubeBuddy - A Kubernetes assistant for PowerShell"
  homepage "https://kubebuddy.io"
  url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.23/kubebuddy-v0.0.23.tar.gz"
  sha256 "6f3278e71df8dacbde533aa2d8cb8ff741709d90fd971d80823dd1b4c0e21723"
  license "MIT"

  depends_on "powershell"

  def install
    # Install the module into libexec to avoid conflicts
    libexec.install Dir["*"]

    # Install PowerShell Gallery dependencies
    system "pwsh", "-Command", <<~PS1
      Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
      Install-Module -Name powershell-yaml -Scope AllUsers -Force
      Install-Module -Name PSAI -Scope AllUsers -Force
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
```ruby
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