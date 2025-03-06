{
  lib,
  stdenvNoCC,
  fetchurl,
  appimageTools,
  makeWrapper,
  writeScript,
}:
let
  pname = "cursor";
  version = "0.45.14";  # 更新版本号
  src = fetchurl {
    url = "https://archive.org/download/cursor-0.45.14x86_64/cursor-0.45.14x86_64.AppImage";  # 更新下载地址
    hash = "sha256-5MGWJi8TP+13jZf6YMMUU5uYY/3OBTFxtGpirvgj8ZI=";  # 需替换为实际哈希值
  };
  appimageContents = appimageTools.extractType2 { inherit version pname src; };
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = appimageTools.wrapType2 { inherit version pname src; };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -r bin $out/bin

    mkdir -p $out/share/cursor
    cp -a ${appimageContents}/locales $out/share/cursor
    cp -a ${appimageContents}/resources $out/share/cursor
    cp -a ${appimageContents}/usr/share/icons $out/share/
    install -Dm 644 ${appimageContents}/cursor.desktop -t $out/share/applications/

    substituteInPlace $out/share/applications/cursor.desktop --replace-fail "AppRun" "cursor"

    wrapProgram $out/bin/cursor \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}} --no-update"

    runHook postInstall
  '';

  passthru.updateScript = writeScript "update.sh" ''
    #!/usr/bin/env nix-shell
    #!nix-shell -i bash -p curl nix-prefetch-url
    set -eu -o pipefail
    url="https://archive.org/download/cursor-0.45.14x86_64/cursor-${version}x86_64.AppImage"  # 静态 URL，无自动检测
    currentVersion=$(nix-instantiate --eval -E "with import ./. {}; code-cursor.version or (lib.getVersion code-cursor)" | tr -d '"')

    # 由于新地址没有提供自动更新的 API，这里仅检查版本并提示手动更新
    echo "Current version: $currentVersion, specified version: ${version}"
    echo "Please manually update the version and hash in the Nix expression if needed."
    hash=$(nix-prefetch-url "$url")
    echo "New hash: $hash"
  '';

  meta = {
    description = "AI-powered code editor built on vscode";
    homepage = "https://cursor.com";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ sarahec ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "cursor";
  };
}