{ config }:
{
  "global" = { "unsafe_ui" = true; };
  "profiles" = [
    {
      "complex_modifications" = {
        "rules" = [
          {
            "description" = "Command (right) + NEIO = arrow keys (Colemak)";
            "manipulators" = [
              {
                "from" = {
                  "key_code" = "j";
                  "modifiers" = {
                    "mandatory" = ["right_command"];
                    "optional" = ["any"];
                  };
                };
                "to" = [{ "key_code" = "left_arrow"; }];
                "type" = "basic";
              }
              {
                "from" = {
                  "key_code" = "l";
                  "modifiers" = {
                    "mandatory" = ["right_command"];
                    "optional" = ["any"];
                  };
                };
                "to" = [{ "key_code" = "up_arrow"; }];
                "type" = "basic";
              }
              {
                "from" = {
                  "key_code" = "k";
                  "modifiers" = {
                    "mandatory" = ["right_command"];
                    "optional" = ["any"];
                  };
                };
                "to" = [{ "key_code" = "down_arrow"; }];
                "type" = "basic";
              }
              {
                "from" = {
                  "key_code" = "semicolon";
                  "modifiers" = {
                    "mandatory" = ["right_command"];
                    "optional" = ["any"];
                  };
                };
                "to" = [{ "key_code" = "right_arrow"; }];
                "type" = "basic";
              }
            ];
          }
        ];
      };
      "devices" = [
        {
          "identifiers" = {
            "is_keyboard" = true;
            "product_id" = 9090;
            "vendor_id" = 13613;
          };
          "treat_as_built_in_keyboard" = true;
        }
        {
          "identifiers" = {
            "is_keyboard" = true;
            "product_id" = 11406;
            "vendor_id" = 7805;
          };
          "ignore" = true;
        }
        {
          "identifiers" = {
            "is_keyboard" = true;
            "product_id" = 45930;
            "vendor_id" = 1133;
          };
          "treat_as_built_in_keyboard" = true;
        }
      ];
      "name" = "Default profile";
      "selected" = true;
      "simple_modifications" = [
        {
          "from" = { "key_code" = "caps_lock"; };
          "to" = [{ "key_code" = "delete_or_backspace"; }];
        }
        {
          "from" = { "key_code" = "left_command"; };
          "to" = [{ "key_code" = "left_option"; }];
        }
        {
          "from" = { "key_code" = "left_control"; };
          "to" = [{ "key_code" = "left_command"; }];
        }
        {
          "from" = { "key_code" = "left_option"; };
          "to" = [{ "key_code" = "left_control"; }];
        }
      ];
      "standalone_keys" = [];
      "virtual_hid_keyboard" = {
        "caps_lock_delay_milliseconds" = 0;
        "keyboard_type" = "ansi";
        "keyboard_type_v2" = "ansi";
      };
    }
  ];
}