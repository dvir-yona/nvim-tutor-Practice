a Random Questioning Practice to lern nvim,

i have created this repo cuz i needed a quick way to refreash my nvim skills,
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
local tutor = loadfile("tutor.lua")
vim.api.nvim_create_user_command('Learn', function()
if (tutor) then tutor() end
end, {})
```
run
```
:so
```
## Running the script
run this nvim command:
```
:Learn
```
