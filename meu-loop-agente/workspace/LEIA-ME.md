# workspace — campo de ação do agente

Somente o que estiver DENTRO desta pasta pode ser lido e modificado pelo agente
de Loop Engineering.

- `app/`, `components/` e `lib/` são pastas de exemplo (padrão de projeto web/Next.js).
  Substitua pelas pastas reais do projeto alvo e ajuste `program.md` + `config_loop.json`.
- Tudo aqui pode ser alterado ou revertido a cada iteração. Use Git para ter pontos
  de retorno (commit antes de cada iteração).
- Não coloque segredos (`.env`, chaves, credenciais) aqui.
