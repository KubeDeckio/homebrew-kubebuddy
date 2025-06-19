class Kubebuddy < Formula
  desc "A Kubernetes assistant for PowerShell"
  homepage "https://kubebuddy.io"
  url "https://github.com/KubeDeckio/KubeBuddy/releases/download/v0.0.23/kubebuddy-v0.0.23.tar.gz"
  sha256 "af43c8ce599bc4596a03531a3f3755d45c75ea50cf8e9e27720afd560cf250ea"
  license "MIT"

  # On macOS, use the cask
  depends_on  "powershell" if OS.mac?

  def install
    # On Linux, check that pwsh is installed
    if OS.linux? && which("pwsh").nil?
      odie "PowerShell (pwsh) is required but not found. Please install it from https://aka.ms/pwsh-linux"
    end

    libexec.install Dir["*"]

    # Install PowerShell module dependencies into an isolated path
    ps_modules = libexec/"modules"
    ps_modules.mkpath

    ENV["PSModulePath"] = ps_modules.to_s
    system "pwsh", "-NoProfile", "-Command", <<~EOS
      Save-Module -Name powershell-yaml -Path "#{ps_modules}" -Force
      Save-Module -Name PSAI -Path "#{ps_modules}" -Force
    EOS

    # Create wrapper script that uses isolated module path
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
      ⚠️ PowerShell (pwsh) is required to use KubeBuddy.

      On macOS, it will be installed via Homebrew Cask.
      On Linux, please install PowerShell manually:

          https://learn.microsoft.com/powershell/scripting/install/installing-powershell

      You can use Snap, apt, yum, or manual tarball extraction.

      After installing, ensure 'pwsh' is in your PATH.
    EOS
  end

  test do
    assert_match "KubeBuddy", shell_output("#{bin}/kubebuddy -h", 1)
  end
end
