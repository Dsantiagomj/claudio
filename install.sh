#!/bin/bash

# Claudio - Modo Costeño Installer
# https://github.com/Dsantiagomj/claudio

set -e

REPO_URL="https://raw.githubusercontent.com/Dsantiagomj/claudio/main"
CLAUDE_DIR=".claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"

echo "🌴 Instalando Claudio - Modo Costeño..."
echo ""

# Check if we're in a project directory
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "Cargo.toml" ] && [ ! -f "go.mod" ] && [ ! -f "pyproject.toml" ]; then
    echo "⚠️  No parece ser un directorio de proyecto."
    read -p "¿Continuar de todas formas? (s/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "Instalación cancelada."
        exit 1
    fi
fi

# Ask for installation type
echo "¿Cómo quieres instalar Claudio?"
echo ""
echo "  1) Como CLAUDE.md (siempre activo)"
echo "  2) Como slash command /claudio (activar cuando quieras)"
echo ""
read -p "Opción [1/2]: " -n 1 -r INSTALL_TYPE
echo ""
echo ""

case $INSTALL_TYPE in
    1)
        # Install as CLAUDE.md
        mkdir -p "$CLAUDE_DIR"

        if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
            echo "Ya existe $CLAUDE_DIR/CLAUDE.md"
            read -p "¿Agregar Claudio al inicio del archivo? (s/N) " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Ss]$ ]]; then
                # Prepend to existing file
                curl -sSL "$REPO_URL/CLAUDIO.md" > /tmp/claudio_temp.md
                echo "" >> /tmp/claudio_temp.md
                echo "---" >> /tmp/claudio_temp.md
                echo "" >> /tmp/claudio_temp.md
                cat "$CLAUDE_DIR/CLAUDE.md" >> /tmp/claudio_temp.md
                mv /tmp/claudio_temp.md "$CLAUDE_DIR/CLAUDE.md"
                echo "✅ Claudio agregado al inicio de $CLAUDE_DIR/CLAUDE.md"
            else
                echo "Instalación cancelada."
                exit 1
            fi
        else
            curl -sSL "$REPO_URL/CLAUDIO.md" -o "$CLAUDE_DIR/CLAUDE.md"
            echo "✅ Instalado en $CLAUDE_DIR/CLAUDE.md"
        fi
        ;;
    2)
        # Install as slash command
        mkdir -p "$COMMANDS_DIR"
        curl -sSL "$REPO_URL/.claude/commands/claudio.md" -o "$COMMANDS_DIR/claudio.md"
        echo "✅ Instalado como slash command"
        echo "   Usa /claudio en Claude Code para activar"
        ;;
    *)
        echo "Opción no válida"
        exit 1
        ;;
esac

echo ""
echo "🎉 Listo el pollo! Claudio está instalado."
echo ""
echo "A trabajar llave! 💪"
