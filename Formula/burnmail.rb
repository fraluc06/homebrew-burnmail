class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/Burnmail/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "fc5df6f438574f7f16d6fc248f97f2cf36893ac9338ad33c79b3f3fbdc851270"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-burnmail/releases/download/burnmail-v1.2.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "25f2079de5917abef28de923b7609782d141a504fe508ede730f416a241072fa"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "316142d8a520de57054875f501d530c760e8b98af566a0845c32fc3362f83a91"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25f2079de5917abef28de923b7609782d141a504fe508ede730f416a241072fa"
    sha256 cellar: :any_skip_relocation, ventura:       "ad66278f28aa9102204b157b09df46425231b3d63eaf3518733619a36ffb781c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a67d02a63dddc411eb1b915b87afd36fab262ca3c19f00b09619f237ae266d83"
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
  end
end
