#!/bin/bash

# Script para automatizar release com versionamento semântico
# Uso: ./scripts/release.sh [major|minor|patch]

set -e

# Verificar se foi fornecido o tipo de release
if [ -z "$1" ]; then
    echo "Uso: $0 [major|minor|patch]"
    exit 1
fi

RELEASE_TYPE=$1

# Ler versão atual do pubspec.yaml
CURRENT_VERSION=$(grep "version:" pubspec.yaml | sed 's/version: //')
CURRENT_VERSION_NUMBER=$(echo $CURRENT_VERSION | cut -d'+' -f1)
CURRENT_BUILD_NUMBER=$(echo $CURRENT_VERSION | cut -d'+' -f2)

# Separar versão em MAJOR, MINOR, PATCH
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION_NUMBER"

# Incrementar versão baseada no tipo
case $RELEASE_TYPE in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
    *)
        echo "Tipo de release inválido: $RELEASE_TYPE"
        echo "Use: major, minor, ou patch"
        exit 1
        ;;
esac

# Nova versão
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
NEW_BUILD_NUMBER=$((CURRENT_BUILD_NUMBER + 1))
NEW_VERSION_STRING="${NEW_VERSION}+${NEW_BUILD_NUMBER}"

echo "==================================="
echo "Release: $RELEASE_TYPE"
echo "Versão atual: $CURRENT_VERSION"
echo "Nova versão: $NEW_VERSION_STRING"
echo "==================================="

# Atualizar pubspec.yaml
sed -i "s/version: $CURRENT_VERSION/version: $NEW_VERSION_STRING/" pubspec.yaml

# Commit changes
git add pubspec.yaml
git commit -m "chore(release): bump version to $NEW_VERSION_STRING"

# Criar tag
git tag -a "v${NEW_VERSION}" -m "Release v${NEW_VERSION}"

echo "✅ Versão atualizada para $NEW_VERSION_STRING"
echo "✅ Tag criada: v${NEW_VERSION}"
echo "📝 Execute 'git push --follow-tags' para enviar as mudanças"