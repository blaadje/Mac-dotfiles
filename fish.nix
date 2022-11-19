{ config }: ''
  # Docker Compose aliases
  function dcu
      docker-compose up
  end

  function dcb
      docker-compose build
  end

  function dcud
      docker-compose up -d
  end

  function de
      docker exec $argv
  end

  function dcd
      docker-compose down
  end

  function dcp
      docker container prune
  end

  function dip
      docker image prune
  end

  function dvp
      docker volume prune
  end

  function sshdid
    ssh ec2-user@35.180.25.252
  end

  function dbash
      docker exec -it $argv[1] bash
  end

  function kbash
      kubectl exec -it $argv[1] bash
  end

  function dsh
      docker exec -it $argv[1] sh
  end

  function goto
      cd ~/projects/back/$argv[1]
  end

  function suso
      set br (git branch | string match -r '\* (.*)' | string trim)
      git branch --set-upstream-to=origin/$br $br
  end

  function ssc
      cd ~/projects/back/$argv[1]; and dcud; and cd -
  end

  # own backend services aliases

  function dlog
    docker logs -f $argv[1] | while read -l line
      echo $line | jq . 2>/dev/null
    end
  end

  function back-start
    gr @main docker-compose up -d
  end

  function back-stop
    gr @main docker-compose down
  end

  function back-restart
    gr @main git stash; and gr @main git stash pop
  end

  function back-service
    set -l action $argv[1]
    set -l service $argv[2]

    switch $action
      case start
        gr $service docker-compose up -d
        echo "Started $service service."

      case stop
        gr $service docker-compose down
        echo "Stopped $service service."

      case restart
        gr $service docker-compose down
        and gr $service docker-compose up -d
        echo "Restarted $service service."

      case '*'
        echo "Usage: back-service (start|stop|restart) [service_name]"
    end
  end

  set fish_greeting

  set color00 "${config.colorScheme.colors.base00}";
  set color01 "${config.colorScheme.colors.base08}";
  set color02 "${config.colorScheme.colors.base0B}";
  set color03 "${config.colorScheme.colors.base0A}";
  set color04 "${config.colorScheme.colors.base0D}";
  set color05 "${config.colorScheme.colors.base0E}";
  set color06 "${config.colorScheme.colors.base0C}";
  set color07 "${config.colorScheme.colors.base05}";
  set color08 "${config.colorScheme.colors.base03}";
  set color09 $color01;
  set color10 $color02;
  set color11 $color03;
  set color12 $color04;
  set color13 $color05;
  set color14 $color06;
  set color15 "${config.colorScheme.colors.base07}";
  set color16 "${config.colorScheme.colors.base09}";
  set color17 "${config.colorScheme.colors.base0F}";
  set color18 "${config.colorScheme.colors.base01}";
  set color19 "${config.colorScheme.colors.base02}";
  set color20 "${config.colorScheme.colors.base04}";
  set color21 "${config.colorScheme.colors.base06}";
  set colorfg $color07;
  set colorbg $color00;


  function put_template; printf '\033]4;%d;rgb:%s\033\\' $argv; end;
  function put_template_var; printf '\033]%d;rgb:%s\033\\' $argv; end;
  function put_template_custom; printf '\033]%s%s\033\\' $argv; end;

  # 16 color space
  put_template 0  $color00
  put_template 1  $color01
  put_template 2  $color02
  put_template 3  $color03
  put_template 4  $color04
  put_template 5  $color05
  put_template 6  $color06
  put_template 7  $color07
  put_template 8  $color08
  put_template 9  $color09
  put_template 10 $color10
  put_template 11 $color11
  put_template 12 $color12
  put_template 13 $color13
  put_template 14 $color14
  put_template 15 $color15

  # 256 color space
  put_template 16 $color16
  put_template 17 $color17
  put_template 18 $color18
  put_template 19 $color19
  put_template 20 $color20
  put_template 21 $color21

  put_template_var 10 $colorfg
  put_template_var 11 $colorbg


  put_template_var 10 $colorfg
  put_template_custom 12 ";7" # cursor (reverse video)

  # set syntax highlighting colors
  set -U fish_color_autosuggestion $color19
  set -U fish_color_cancel -r
  set -U fish_color_command green #white
  set -U fish_color_comment $color19
  set -U fish_color_cwd green
  set -U fish_color_cwd_root red
  set -U fish_color_end brblack #blue
  set -U fish_color_error red
  set -U fish_color_escape yellow #green
  set -U fish_color_history_current --bold
  set -U fish_color_host normal
  set -U fish_color_match --background=brblue
  set -U fish_color_normal normal
  set -U fish_color_operator blue #green
  set -U fish_color_param $color20
  set -U fish_color_quote yellow #brblack
  set -U fish_color_redirection cyan
  set -U fish_color_search_match bryellow --background=$color19
  set -U fish_color_selection white --bold --background=$color19
  set -U fish_color_status red
  set -U fish_color_user brgreen
  set -U fish_color_valid_path --underline
  set -U fish_pager_color_completion normal
  set -U fish_pager_color_description yellow --dim
  set -U fish_pager_color_prefix white --bold #--underline
  set -U fish_pager_color_progress brwhite --background=cyan

  set -U fish_color_autosuggestion $color19
  set -U fish_color_cancel -r
  set -U fish_color_command green #white
  set -U fish_color_comment $color19
  set -U fish_color_cwd green
  set -U fish_color_cwd_root red
  set -U fish_color_end brblack #blue
  set -U fish_color_error red
  set -U fish_color_escape yellow #green
  set -U fish_color_history_current --bold
  set -U fish_color_host normal
  set -U fish_color_match --background=brblue
  set -U fish_color_normal normal
  set -U fish_color_operator blue #green
  set -U fish_color_param $color20
  set -U fish_color_quote yellow #brblack
  set -U fish_color_redirection cyan
  set -U fish_color_search_match bryellow --background=$color19
  set -U fish_color_selection white --bold --background=$color19
  set -U fish_color_status red
  set -U fish_color_user brgreen
  set -U fish_color_valid_path --underline
  set -U fish_pager_color_completion normal
  set -U fish_pager_color_description yellow --dim
  set -U fish_pager_color_prefix white --bold #--underline
  set -U fish_pager_color_progress brwhite --background=cyan

  # clean up
  functions -e put_template put_template_var put_template_custom
''
