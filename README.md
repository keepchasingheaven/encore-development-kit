# encore development kit (edk)

o kit de desenvolvimento encore (edk) instala o encore na sua estação de trabalho. o edk gerencia as necessidades, ferramentas de desenvolvimento e bancos de dados do encore.

o edk é utilizado pelos membros dos times de encore e contribuidores para testar mudanças localmente para agilizar o tempo de realizar contribuições da forma correta.

## objetivos

- fornecer ferramentas para instalar, atualizar e desenvolver uma instância encore local.
- automatizar a instalação de [software necessário](https://docs.encore.com/install/requirements/#software-requirements).
- apenas gerenciar projetos, software, e serviços que possam ser necessários para rodar uma instância encore.
- fora da caixa, apenas habilita os serviços que o encore necessita para funcionar.
- suporta sistemas operacionais nativos como listados.

## instalação

você pode instalar o edk utilizando os seguintes métodos:

- suportado e frequentemente testado.
- não suportado, mas merge requests bem vindos para melhoria.

## métodos suportados

os seguintes métodos de instalação são suportados, reparados ativamente, e testados:

### local

requer pelo menos 16gb de ram e 30gb de disco disponível. disponível para plataformas suportadas.

- [instalação de uma linha](https://github.com/keepchasingheaven/encore-development-kit/#one-line-installation).
- [instalação simples](https://github.com/keepchasingheaven/encore-development-kit/#simple-installation).
- [edk-in-a-box](https://github.com/keepchasingheaven/encore-development-kit/edk_in_a_box/). (requer pelo menos 30gb de espaço de disco).

### remoto

não há métodos de instalação remotos ativamente suportados.

## plataformas suportadas

| sistema operacional | versões |
|---------------------|---------|
| macos | 15, 14, 13 (1) |
| ubuntu | 24.04, 22.04 |
| fedora | 40 |
| debian | 13, 12 |
| arch | latest |
| manjaro | latest |

- (1) são seguidas as [versões suportadas pela apple](https://endoflife.date/macos). macos em intel é suportado pelo edk mas não aproveita todos os recursos como pulo de compilação de certos serviços em favor de binários pré-compilados.

a lista de plataformas incluem sistemas operacionais que rodam com um ambiente windows subsystem for linux (wsl).
