{ lib, buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "ytt";
  version = "0.45.2";

  src = fetchFromGitHub {
    owner = "vmware-tanzu";
    repo = "carvel-ytt";
    rev = "v${version}";
    sha256 = "sha256-D2m+o1rGi2CPLqaLJWHOcVeA7F0GeUu4jFneTOsP+Ak=";
  };

  vendorHash = null;

  ldflags = [
    "-X github.com/vmware-tanzu/carvel-ytt/pkg/version.Version=${version}"
  ];

  subPackages = [ "cmd/ytt" ];

  meta = with lib; {
    description = "YAML templating tool that allows configuration of complex software via reusable templates with user-provided values";
    homepage = "https://get-ytt.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ brodes techknowlogick ];
  };
}
