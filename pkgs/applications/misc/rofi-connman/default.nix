{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, connman
, empty
, rofi
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "rofi-connman";
  version = "0.5";

  src = fetchFromGitHub {
    owner = "sourcemage";
    repo = finalAttrs.pname;
    rev = "6db2df2";
    sha256 = "sha256-e2mQ9YtxEuFcaVGsbEMSql1p7VMyEh6m2GfBlDSRjnM=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    install -D --target-directory=$out/bin/ ./rofi-connman

    wrapProgram $out/bin/rofi-connman \
      --prefix PATH ":" ${lib.makeBinPath [ connman empty rofi] }
    runHook postInstall
  '';

  meta = with lib; {
    description = "Rofi-based interface to connect to Wifi ";
    homepage = "https://github.com/nickclyde/rofi-connman";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ yvonne-aizawa ];
    platforms = platforms.linux;
  };
})