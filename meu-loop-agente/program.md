# Loop Program — redução do bundle inicial (exemplo com Next.js)

> Este arquivo é o CONTRATO do agente. Só o humano altera.
> Os números ficam em `baseline.json`; comandos e medição, em `config_loop.json`.
> Mantenha os três coerentes entre si.

## OBJETIVO

Reduzir o tamanho do bundle inicial da homepage em pelo menos 8%, sem quebrar
funcionalidades críticas.

## BASELINE E META

- Fonte dos números: `baseline.json` (valor inicial, melhor valor, meta).
- Meta de exemplo: 312 kB -> 287 kB (redução de 8%).

## ARQUIVOS PERMITIDOS (o agente só mexe aqui)

- `workspace/app/**`
- `workspace/components/**`
- `workspace/lib/**`
- `workspace/package.json`

## ARQUIVOS PROIBIDOS

- `infra/**`
- `scripts/deploy/**`
- `.github/workflows/**`
- `.env`, segredos, credenciais
- Qualquer caminho fora de `workspace/`

## COMANDOS DE VERIFICAÇÃO (obrigatórios)

- Fonte de máquina: `config_loop.json` -> `verificacao.comandos` (não duplicar aqui, para não divergir).
- Conteúdo atual (exemplo): `npm run lint`, `npm run typecheck`, `npm run test`, `npm run build`.

## MÉTRICA PRINCIPAL

- Nome: tamanho do bundle inicial da homepage (kB).
- Direção: menor é melhor.
- Comando e leitura do número: `config_loop.json` -> `metrica`.

## MÉTRICAS SECUNDÁRIAS (não podem piorar)

- Tamanho do vendor chunk.
- Regressão visual zero nas telas críticas.

## CRITÉRIO DE ACEITE

- Todos os comandos de verificação passam; E
- A métrica principal melhora (menor que o melhor valor registrado).

## CRITÉRIO DE REJEIÇÃO

- Qualquer comando falha; OU
- A métrica fica igual ou pior.

## POLÍTICA DE MUDANÇA

- Uma hipótese por iteração.
- Diff pequeno (menos de 50 linhas).
- Reverter imediatamente o que for rejeitado.
- Registrar cada iteração no `log.md` (hipótese, arquivos, métricas, decisão).

## LIMITES DE PARADA

- Máximo: 20 iterações (fonte de máquina: `config_loop.json` -> `limites`).
- Parada antecipada: meta atingida OU 5 rejeições consecutivas OU falta de
  hipóteses plausíveis.
