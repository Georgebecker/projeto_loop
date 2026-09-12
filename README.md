# Projeto Loop

Base genérica e enxuta para estudos e projetos de dados.
Ponto de partida com documentação, regras de ouro e configuração (`.env`).

---

**Autor:** George Herman Becker
**Gestor em TI — Estácio**
**Início:** 11/09/2026

**Apoie o autor:**
- **PIX:** `a8b68e14-edfe-4450-88f2-c2af4aca2a6c`
- **Buy Me a Coffee:** <https://buymeacoffee.com/georgehbecker>
- **LinkedIn:** <https://www.linkedin.com/in/georgehbecker/>

---

## O que tem aqui (por enquanto)

- `docs/REGRAS_DE_OURO.md` — as melhores regras, sintetizadas, para todo projeto de dados (Python + SQL + arquitetura moderna).
- `meu-loop-agente/` — estrutura de Loop Engineering: contrato, métrica, log e verificador para ciclos de melhoria contínua (o agente só mexe em `meu-loop-agente/workspace/`).
- `.env` / `.env.example` — configuração pronta (caminhos, banco de dados, APIs), sem segredo no repositório.
- Pastas-base prontas para crescer: `data/raw`, `data/processed`, `data/descartados`, `notebooks`.

## Estrutura prevista (vai evoluir com o projeto)

```
projeto_loop/
├── .env / .env.example        # configuração (nunca commitar o .env)
├── README.md                  # este arquivo
├── docs/                      # documentação e regras de ouro
├── meu-loop-agente/           # agente de Loop Engineering (contrato, log, workspace, verificador)
├── data/
│   ├── raw/                   # dados brutos (nunca alterar)
│   ├── processed/             # dados tratados/limpos
│   └── descartados/           # fora de circulação (nunca apagar)
├── notebooks/                 # análises exploratórias (.ipynb)
├── src/                       # código reutilizável (cresce depois)
└── sql/                       # consultas e schemas SQL (cresce depois)
```

## Comece por aqui

1. Leia [`docs/REGRAS_DE_OURO.md`](docs/REGRAS_DE_OURO.md) — é o contrato do projeto.
2. O `.env` já está criado neste projeto (e nunca vai ao git); em um clone novo, copie `.env.example` para `.env` e ajuste os valores (caminhos, banco, chaves).
3. Use `data/raw` para o que vier bruto e `data/processed` só para o que for tratado e validado.
4. Nunca apague dado: se não servir mais, mova para uma pasta de descarte (ex.: `data/descartados/`).

---
