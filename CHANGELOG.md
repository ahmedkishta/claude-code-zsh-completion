# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-12-13

### Added
- **120+ language support** - Expanded from 8 to 120+ languages
  - All major world languages
  - Regional variants (English: 10, Spanish: 13, German: 4, French: 4, Swedish: 3, etc.)
  - Minority and constructed languages (Esperanto, Celtic languages, etc.)
- **New directory structure** - All completion files moved to `completions/` directory
  - Better organization for large number of language files
  - Cleaner repository root directory

### Changed
- **BREAKING: Installation path updated** - Completion files now in `completions/` directory
  - Old: `https://raw.githubusercontent.com/.../main/_claude`
  - New: `https://raw.githubusercontent.com/.../main/completions/_claude`
  - Existing users need to update their installation path
- Updated README with comprehensive language list and new structure
- Updated installation instructions for new directory structure
- Updated `.gitattributes` to recognize new directory structure
- Updated GitHub Actions test paths

## [1.1.0] - 2025-12-13

### Added
- **Dynamic completion** for MCP servers, plugins, and session IDs
  - `claude --resume <TAB>` - Show available session IDs
  - `claude mcp remove <TAB>` - Show configured MCP servers
  - `claude mcp get <TAB>` - Show configured MCP servers
  - `claude plugin uninstall <TAB>` - Show installed plugins
  - `claude plugin enable/disable <TAB>` - Show installed plugins
- GitHub Actions workflow for automated testing
- `.gitattributes` for proper language detection

### Changed
- **Performance optimization** for dynamic completion
  - MCP servers: 24x faster (0.236s → <0.010s)
  - Direct config file reading instead of running `claude mcp list`
  - Optimized plugin and session detection using zsh globs
- Updated `compdef` registration method for better compatibility
- Improved README with multi-language support and dynamic completion documentation

### Fixed
- Completion registration to prevent conflicts with existing completions

## [1.0.0] - 2025-12-13

### Added
- Initial release with 8 language versions:
  - `_claude` - English
  - `_claude.ja` - Japanese (日本語)
  - `_claude.zh-CN` - Chinese Simplified (简体中文)
  - `_claude.es` - Spanish (Español)
  - `_claude.fr` - French (Français)
  - `_claude.de` - German (Deutsch)
  - `_claude.ko` - Korean (한국어)
  - `_claude.pt-BR` - Portuguese Brazilian (Português)
- Complete command and subcommand completion
- Option and flag completion with descriptions
- Context-aware argument completion
- Support for all `claude` commands:
  - Main commands: `mcp`, `plugin`, `migrate-installer`, `setup-token`, `doctor`, `update`, `install`
  - MCP commands: `serve`, `add`, `remove`, `list`, `get`, `add-json`, `add-from-claude-desktop`, `reset-project-choices`
  - Plugin commands: `validate`, `marketplace`, `install`, `uninstall`, `enable`, `disable`
