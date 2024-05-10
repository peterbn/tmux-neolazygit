CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CUSTOM_LAZYGIT_CONFIG="$CURRENT_DIR/../lazygit/config.yml"

LAZYGIT_EDITOR="$CURRENT_DIR/editor.sh" # Check usage in lazygit/config.yml
LAZYGIT_CONFIG=$(echo "$(lazygit -cd)/config.yml")

openLazygit () {
    # Gets the pane id from where the script was called
    local LAZYGIT_ORIGIN_PANE=($(tmux display-message -p "#D"))
    local USE_POPUP=true # true

    # Opens a new tmux window running lazygit appending the needed config
    if [ $USE_POPUP="true" ];
    then
      tmux popup \
          -d "#{pane_current_path}" \
          -E \
          -w 90% -h 90% \
          -e LAZYGIT_EDITOR=$LAZYGIT_EDITOR \
          -e LAZYGIT_ORIGIN_PANE=$LAZYGIT_ORIGIN_PANE \
          lazygit \
          -ucf $LAZYGIT_CONFIG,$CUSTOM_LAZYGIT_CONFIG
    else
      tmux new-window \
          -c "#{pane_current_path}" \
          -e LAZYGIT_EDITOR=$LAZYGIT_EDITOR \
          -e LAZYGIT_ORIGIN_PANE=$LAZYGIT_ORIGIN_PANE \
          lazygit \
          -ucf $LAZYGIT_CONFIG,$CUSTOM_LAZYGIT_CONFIG
    fi
}

openLazygit
