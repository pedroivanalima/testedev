Decisões Tomadas

- Agendamentos
Apesar da especificação separar por intervalos de 1h (uma data e um inteiro bastariam), optei por Data e Hora inicial e final para ter flexibilidade.  Lembrando que é um intervalo de inicio fechado e final aberto, ou seja, >= para inicial e < para final.

O teste pediu edição de reservas apenas da semana atual para frente, mantive a regra, mas vale o questionamento se é do dia atual em diante ou na semana mesmo.

A validação de data máxima de alteração está fora do validate para não atrapalhar integrações futuras, devendo ser chamada pelos controllers.  
