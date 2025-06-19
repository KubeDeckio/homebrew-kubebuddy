class Kubebuddy < Formula
  desc "A Kubernetes assistant for PowerShell"
  homepage "https://kubebuddy.io"
  url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.24/kubebuddy-v0.0.24.tar.gz"
  sha256 "2f7765cb74c88162e460cbe2fb710d71081f78270a531cf7fe6b18dc3b54c2cd"
  license "MIT"

  depends_on "powershell"

  def install
    # Install everything into libexec
    libexec.install Dir["*"]

    # Create directory for isolated PowerShell modules
    ps_modules = libexec/"modules"
    ps_modules.mkpath

    # Save required modules into our PSModulePath
    ENV["PSModulePath"] = ps_modules.to_s
    system "pwsh", "-NoProfile", "-Command", <<~EOS
      Save-Module -Name powershell-yaml -Path "#{ps_modules}" -Force
      Save-Module -Name PSAI -Path "#{ps_modules}" -Force
    EOS

    # Create a wrapper script that sets the isolated module path
    (bin/"kubebuddy").write <<~EOS
      #!/usr/bin/env pwsh
      $env:PSModulePath = "#{ps_modules}" + [System.IO.Path]::PathSeparator + $env:PSModulePath
      Import-Module "#{libexec}/KubeBuddy.psd1" -Force
      Invoke-KubeBuddy @Args
    EOS

    chmod 0755, bin/"kubebuddy"
  end

  def caveats
    <<~EOS
      If you're on Linux and encounter issues installing PowerShell:
          brew update-reset
        brew install powershell

      If that fails:
        brew untap homebrew/core
        brew tap homebrew/core --force
    EOS
  end

  test do
    # Simple test: command should output help text or known marker
    assert_match "KubeBuddy", shell_output("#{bin}/kubebuddy -h", 1)
  end
end
