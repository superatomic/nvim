local ui_height = 0.5

require('vim._core.ui2').enable {
  enabled = true,
  msg = {
    cmd = { height = ui_height },
    dialog = { height = ui_height },
    msg = { height = ui_height },
    pager = { height = ui_height },
  },
}
