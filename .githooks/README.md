# Ganchos de protecao do git

## O que protege

- `pre-commit` — bloqueia qualquer commit que tente incluir `.env` ou variantes
  (`.env.local`, `.env.prod` etc.). O unico arquivo `.env*` permitido e o
  `.env.example` (modelo sem segredos).

Isso e a camada mais forte da regra "o `.env` nunca vai para o git": funciona
mesmo se alguem usar `git add -f` ou `git add .` sem conferir.

## Como ativar (uma vez so)

Repositorio ainda nao criado:

```powershell
powershell -ExecutionPolicy Bypass -File .githooks\instalar.ps1
```

Repositorio ja criado, so ativar os ganchos:

```powershell
git config core.hooksPath .githooks
```

## Como conferir se esta ativo

```powershell
git config core.hooksPath
```

Tem que responder `.githooks`. Tambem vale conferir que o arquivo
`.githooks\pre-commit` existe.

## Teste rapido (opcional)

Crie um arquivo `.env` de mentira, tente `git add .env` + `git commit`:
o commit tem que ser recusado com a mensagem "BLOQUEADO".
