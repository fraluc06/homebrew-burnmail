class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "aee5434160f29b034994644d2e57b3da951d5fb11b25949dca59148269b5c513"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-burnmail/releases/download/burnmail-v1.0.1-bottles"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "01ec39c7a5dacffa6dc277685ff9fcd2eb2e98e1b1a956d6df514d2bb6e4e5f0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "01ec39c7a5dacffa6dc277685ff9fcd2eb2e98e1b1a956d6df514d2bb6e4e5f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "01ec39c7a5dacffa6dc277685ff9fcd2eb2e98e1b1a956d6df514d2bb6e4e5f0"
    sha256 cellar: :any_skip_relocation, ventura:       "1e0ab8fa42fc3ba0d57219b5da237e77c1a85024f881dc458a0912a668ab70e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7c4c71c4326e8463ec817196e03fa102241519f5ff18c4d2e1f2f7dabff848b"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.Version=#{version}
      -X main.BuildTime=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    output = shell_output("#{bin}/burnmail --version")
    assert_match version.to_s, output

    output = shell_output("#{bin}/burnmail domains 2>&1")
    assert_match "Available domains", output
  end
end
