a Random Questioning Practice to lern nvim,

i have created this repo cuz i needed a quick way to refresh my nvim skills,
# How to use it

## get to the nvim config:

- on linux/macos:

```
cd ~/.config/nvim/
```
- on windows:

```
cd %LOCALAPPDATA%\nvim
```

## then clone the repo:
```
git clone https://github.com/dvir-yona/nvim-tutor-Practice.git
```
## then create init.lua (if you dont have it already)
- on linux/macos:
```
touch init.lua
```
- on windows:
```
echo. > init.lua
```
## then add this code to your init.lua
```
local tutor = require("nvim-tutor-Practice.tutor")

vim.api.nvim_create_user_command('Learn', function(command_args)
  if tutor then
    if #command_args.args > 0 then
      local index = command_args.args
      tutor.open(index)
    else
      tutor.open(nil)
    end
  end
end, { nargs = '*' })
```
type
```
:so
```
## Running the script
run this nvim command:
```
:Learn
```
