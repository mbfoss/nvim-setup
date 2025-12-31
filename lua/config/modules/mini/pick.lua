require("mini.pick").setup()

vim.ui.select = function(items, opts, on_choice)
  require("mini.pick").start({
    source = {
      name = opts.prompt or "Select",
      items = items,
      choose = function(item)
        on_choice(item)
      end,
    },
  })
end
