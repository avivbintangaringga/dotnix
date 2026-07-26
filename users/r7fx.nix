{
  userdata,
  mylib,
  pkgs,
  lib,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  xdg = {
    mimeApps = {
      defaultApplications =
        let
          archives = [
            "application/zip"
            "application/x-tar"
            "application/x-gzip"
            "application/x-bzip2"
            "application/x-xz"
            "application/x-7z-compressed"
            "application/x-rar-compressed"
            "application/x-rar"
            "application/x-cpio"
            "application/x-iso9660-image"
            "application/x-debian-package"
            "application/vnd.android.package-archive"
            "application/x-redhat-package-manager"
            "application/x-zstd"
          ];
          browser = [
            "text/html"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/about"
            "x-scheme-handler/unknown"
          ];
          images = [
            "image/jpeg"
            "image/png"
            "image/gif"
            "image/webp"
            "image/avif"
            "image/heic"
            "image/heif"
            "image/svg+xml"
            "image/bmp"
          ];
          videos = [
            "video/mp4"
            "video/webm"
            "video/x-matroska"
            "video/quicktime"
            "video/x-msvideo"
            "video/mpeg"
            "video/ogg"
            "video/mp2t"
            "video/3gpp"
          ];
          audios = [
            "audio/mpeg"
            "audio/mp4"
            "audio/ogg"
            "audio/wav"
            "audio/x-wav"
            "audio/flac"
            "audio/x-flac"
            "audio/aac"
            "audio/webm"
            "audio/x-matroska"
            "audio/midi"
            "audio/x-midi"
            "audio/opus"
          ];
        in
        lib.mkMerge [
          (mylib.listToAttrsSameValue browser [ "zen-beta.desktop" "thorium-browser.desktop" ])
          (mylib.listToAttrsSameValue archives [ "peazip.desktop" ])
          (mylib.listToAttrsSameValue images [ "org.kde.gwenview.desktop" "gimp.desktop" ])
          (mylib.listToAttrsSameValue videos [ "vlc.desktop" ])
          (mylib.listToAttrsSameValue audios [ "vlc.desktop" ])
        ];
    };

  };
}
