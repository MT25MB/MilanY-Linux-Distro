# Contributing to milanY

Thank you for your interest in contributing to milanY! This guide will help you get started.

## 🚀 Getting Started

### Prerequisites

- **Linux/Unix Environment**: Development requires a POSIX-compatible system
- **Basic Shell Scripting**: Most tools are written in Bash
- **Privacy Knowledge**: Understanding of privacy and security concepts
- **Git**: Version control for contributions

### Development Setup

```bash
# 1. Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/milany-linux.git
cd milany-linux

# 2. Add upstream remote
git remote add upstream https://github.com/milany-linux/milany-linux.git

# 3. Create a feature branch
git checkout -b feature/your-feature-name

# 4. Make scripts executable
chmod +x usr/local/bin/milany-*

# 5. Install development dependencies
# (See DEPENDENCIES.md for requirements)
```

## 📝 Code Style

### Shell Script Guidelines

Follow these conventions for consistency:

```bash
#!/bin/bash
# milanY tool name
# brief description of tool purpose

# Use lowercase for comments
# no periods unless necessary for clarity

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# Function naming: snake_case
function_name() {
    local variable="local variables in lowercase"
    
    # Use 4-space indentation
    if [ "$condition" = "true" ]; then
        echo -e "${GREEN}success${NC}"
    else
        echo -e "${RED}error${NC}"
        return 1
    fi
}

# Error handling
check_dependencies() {
    local deps=("curl" "jq" "tor")
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo -e "${RED}error: $dep not found${NC}"
            exit 1
        fi
    done
}
```

### File Organization

```
MilanY/
├── usr/local/bin/          # User tools
├── usr/share/milany/       # System resources
├── etc/skel/              # Default user configs
├── etc/milany/            # System configuration
├── scripts/               # Build/install scripts
└── usr/share/plymouth/    # Boot themes
```

## 🧪 Testing

### Manual Testing

Before submitting, test your changes:

```bash
# Test basic functionality
./usr/local/bin/milany-tool --help

# Test with different configurations
./usr/local/bin/milany-tool test-config

# Check for syntax errors
bash -n usr/local/bin/milany-tool
```

### Security Testing

Ensure your changes don't compromise security:

```bash
# Check for hardcoded secrets
grep -r "password\|secret\|key\|token" usr/local/bin/

# Verify network calls use HTTPS
grep -r "http://" usr/local/bin/  # Should return nothing

# Check file permissions
ls -la usr/local/bin/milany-*
```

## 📋 Types of Contributions

### 🐛 Bug Reports

When reporting bugs, include:

- **OS/Version**: Linux distribution and version
- **Steps to Reproduce**: Detailed reproduction steps
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happened
- **Error Messages**: Complete error output
- **Configuration**: Relevant config settings

### ✨ Feature Requests

For new features, provide:

- **Use Case**: Why is this needed?
- **Proposed Solution**: How should it work?
- **Alternatives Considered**: Other approaches evaluated
- **Priority**: Low/Medium/High

### 🔧 Code Contributions

#### Adding New Tools

When adding new milany tools:

1. **Create the script** in `usr/local/bin/`
2. **Follow naming convention**: `milany-tool-name`
3. **Add help function**: With usage examples
4. **Include error handling**: Check dependencies and inputs
5. **Update documentation**: Add to README.md
6. **Test thoroughly**: Manual and security testing

#### Example Tool Template

```bash
#!/bin/bash
# milanY-tool-name
# one-line description of tool purpose

# Colors (import from shared config)
source /usr/share/milany/milany-colors.conf

# Help function
show_help() {
    echo -e "${CYAN}milany-tool-name - tool description${NC}"
    echo ""
    echo "usage: milany-tool-name [command] [options]"
    echo ""
    echo "commands:"
    echo "  start                  start the service"
    echo "  stop                   stop the service"
    echo "  status                 show status"
    echo ""
    echo "examples:"
    echo "  milany-tool-name start"
}

# Main function
main() {
    # Check dependencies
    if ! command -v required-tool >/dev/null 2>&1; then
        echo -e "${RED}error: required-tool not found${NC}"
        exit 1
    fi
    
    case "${1:-help}" in
        start)
            echo -e "${BLUE}starting service...${NC}"
            # Implementation here
            ;;
        stop)
            echo -e "${BLUE}stopping service...${NC}"
            # Implementation here
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo -e "${RED}error: unknown command${NC}"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
```

## 📤 Submitting Changes

### Pull Request Process

1. **Update your fork**: Sync with upstream
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Create pull request**: With descriptive title
   - Title: `fix: brief description of fix`
   - Body: Detailed explanation of changes

3. **Fill PR template**: Complete all sections
4. **Wait for review**: Address feedback promptly

### Pull Request Template

```markdown
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested manually
- [ ] Security review completed
- [ ] Documentation updated

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] No hardcoded secrets
- [ ] Error handling implemented
- [ ] Help text updated
```

## 🏆 Recognition

Contributors are recognized through:

- **Contributors List**: In README.md
- **Commit Attribution**: Git commit history
- **Release Notes**: Mentioned in changelog
- **Community Recognition**: Shoutouts in releases

## 🤝 Community

### Code of Conduct

We're committed to a welcoming environment:

- **Respect**: Treat all contributors with respect
- **Inclusive**: Welcome contributions from all backgrounds
- **Constructive**: Provide helpful, constructive feedback
- **Patient**: Understand that not everyone is an expert

### Getting Help

- **Issues**: Report bugs and request features
- **Discussions**: Ask questions and share ideas
- **Discord/Matrix**: Real-time community chat (links in README)

## 📚 Resources

- **Documentation**: [README.md](README.md)
- **Architecture**: [ARCHITECTURE.md](ARCHITECTURE.md)
- **Security**: [SECURITY.md](SECURITY.md)
- **Dependencies**: [DEPENDENCIES.md](DEPENDENCIES.md)

---

**Thank you for contributing to milanY!** 🎉

Your contributions help advance digital privacy and freedom for everyone.
