{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.bark;

in
{
  options.services.bark = {
    enable = lib.mkEnableOption "push-notification service for iOS";

    package = lib.mkPackageOption pkgs "bark-server" { };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/bark";
      description = "Data directory for bark-server";
    };

    settings = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {
        BARK_SERVER_DATA_DIR = cfg.dataDir;
      };

      description = ''
        Configuration options for bark-server.

        See getAppServer in https://github.com/Finb/bark-server/blob/master/main.go
      '';
      example = lib.literalExpression ''
        {
          BARK_SERVER_ADDRESS = "127.0.0.1:8080";
          BARK_SERVER_DATA_DIR = "/data";
        }
      '';
    };

    secrets = lib.mkOption {
      type = with lib.types; listOf path;
      description = ''
        A list of files containing secrets for bark-server. Should be in the
        format expected by systemd's EnvironmentFile.
      '';
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    services.bark.settings = {
      BARK_SERVER_DATA_DIR = lib.mkDefault cfg.dataDir;
    };

    systemd.services.bark = {
      description = "Bark Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      environment = cfg.settings;
      serviceConfig = {
        ExecStart = lib.getExe cfg.package;
        WorkingDirectory = cfg.dataDir;
        RuntimeDirectory = "bark";
        StateDirectory = "bark";
        EnvironmentFile = [ cfg.secrets ];

        # hardening
        AmbientCapabilities = "";
        CapabilityBoundingSet = "";
        DevicePolicy = "closed";
        DynamicUser = true;
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProcSubset = "pid";
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        ProtectSystem = "strict";
        RemoveIPC = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_INET"
          "AF_INET6"
        ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [
          "@system-service"
          "~@privileged"
        ];
        UMask = "0077";
      };
    };

    systemd.tmpfiles.rules = [ "d /tmp 1777 root root 10d" ];
  };
}
