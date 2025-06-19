class Kubebuddy < Formula
  desc "Smart Kubernetes scanner built for PowerShell, CI, and secure audits"
  homepage "https://kubebuddy.io"
  url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.23/kubebuddy-v0.0.23.tar.gz"
  sha256 "af43c8ce599bc4596a03531a3f3755d45c75ea50cf8e9e27720afd560cf250ea"
  license "MIT"

  def install
    # Abort if PowerShell is not installed
    unless which("pwsh")
      odie <<~EOS
        PowerShell (pwsh) is required but not found.

        ➤ On macOS:
            brew install --cask powershell

        ➤ On Linux:
            https://aka.ms/pwsh-linux

        After installing, make sure 'pwsh' is in your PATH and try again.
      EOS
    end

    # Install main module files
    libexec.install Dir["*"]

    # Set up isolated PSModulePath
    ps_modules = libexec/"modules"
    ps_modules.mkpath
    ENV["PSModulePath"] = ps_modules.to_s

    # Download dependencies into isolated path
    system "pwsh", "-NoProfile", "-Command", <<~EOS
      Save-Module -Name powershell-yaml -Path "#{ps_modules}" -Force
      Save-Module -Name PSAI -Path "#{ps_modules}" -Force
    EOS

    # Create wrapper executable
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
      ⚠️ PowerShell (pwsh) is required to run KubeBuddy.

      ➤ On macOS:
          brew install --cask powershell

      ➤ On Linux:
          https://learn.microsoft.com/powershell/scripting/install/installing-powershell

      Once installed, make sure 'pwsh' is in your PATH and re-run this tool.
    EOS
  end

  test do
    assert_match "KubeBuddy", shell_output("#{bin}/kubebuddy -h", 1)
  end
end
