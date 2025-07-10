# dotfiles

## Setting Up Symlinks

After cloning this repository to `~/Documents/github/dotfiles` (or your preferred location), you'll need to create symlinks to connect your dotfiles to where your system expects to find them.

### Prerequisites

**Backup your existing configs first!** 
```bash
# Example for Neovim
mv ~/.config/nvim ~/.config/nvim.backup  # Linux/Mac
```

### Linux & macOS

Use the `ln -s` command to create symbolic links:

```bash
# Neovim
ln -s ~/Documents/github/dotfiles/nvim ~/.config/nvim

# Other common configs (adjust paths as needed)
ln -s ~/Documents/github/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/Documents/github/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/Documents/github/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

**Verify the symlinks:**
```bash
ls -la ~/.config/nvim
# Should show: nvim -> /home/username/Documents/github/dotfiles/nvim
```

### Windows

#### Option 1: Using Command Prompt (as Administrator)

```cmd
# Neovim
mklink /D "%LOCALAPPDATA%\nvim" "%USERPROFILE%\Documents\github\dotfiles\nvim"

# PowerShell profile
mklink "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\github\dotfiles\powershell\profile.ps1"

# Git config
mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\Documents\github\dotfiles\git\.gitconfig"
```

#### Option 2: Using PowerShell (as Administrator)

```powershell
# Neovim
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$env:USERPROFILE\Documents\github\dotfiles\nvim"

# PowerShell profile
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$env:USERPROFILE\Documents\github\dotfiles\powershell\profile.ps1"

# Git config
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$env:USERPROFILE\Documents\github\dotfiles\git\.gitconfig"
```

#### Option 3: Using Git Bash (Unix-like commands on Windows)

```bash
# Neovim
ln -s ~/Documents/github/dotfiles/nvim ~/AppData/Local/nvim

# Git config
ln -s ~/Documents/github/dotfiles/git/.gitconfig ~/.gitconfig
```

### Common Config Locations

| Application | Linux/macOS | Windows |
|-------------|-------------|---------|
| Neovim | `~/.config/nvim` | `%LOCALAPPDATA%\nvim` |
| Zsh | `~/.zshrc` | N/A |
| Bash | `~/.bashrc` | `~/.bashrc` (Git Bash) |
| Git | `~/.gitconfig` | `%USERPROFILE%\.gitconfig` |
| Tmux | `~/.tmux.conf` | N/A |
| PowerShell | N/A | `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` |

### Troubleshooting

**Permission Issues (Windows):**
- Run Command Prompt or PowerShell as Administrator
- Enable Developer Mode in Windows Settings for easier symlink creation

**Broken Symlinks:**
```bash
# Remove broken symlink
rm ~/.config/nvim  # Linux/Mac
rmdir /s "%LOCALAPPDATA%\nvim"  # Windows CMD

# Recreate with correct path
ln -s ~/Documents/github/dotfiles/nvim ~/.config/nvim
```

**Verify Setup:**
- Edit a file in your dotfiles directory
- Check if the change appears in the linked location
- Your application should immediately see the changes

### Benefits

- ✅ Changes in dotfiles are instantly reflected in your applications
- ✅ Easy to version control and sync across machines
- ✅ No need to manually copy files between locations
- ✅ Clean separation between your configs and system files
