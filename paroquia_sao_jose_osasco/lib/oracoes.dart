import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

Map<String, List<String>> temasOpcoesMap = {
  'Orações Comuns': [
    'Ave Maria',
    'Anjo da Guarda',
    'Abri Senhor',
    'À vossa proteção',
    'Credo',
    'Cordeiro de Deus',
    'Glória a Deus nas alturas',
    'Glória ao Pai',
    'Pai Nosso',
    'Salve Rainha',
    'Sinal da Cruz',
    'Divino Pai Eterno',
    'Os Sete Pai Nossos em honra ao Sangue de Jesus',
    'Pai Eterno'
  ],
  'Ocasiões Especiais': [
    'Para antes dos estudos',
    'Para a família',
    'Para obter saúde',
    'Para uma viagem'
  ],
  'Orações para a Família': [
    'Pelos falecidos',
    'Pelos filhos',
    'Pelos mais necessitados',
    'Pelos pais',
    'Pelos parentes ausentes'
  ],
  'Orações dos Santos': [
    'São Benedito',
    'São Brás (Protetor das doenças da garganta)',
    'São Cristóvão',
    'São Gabriel Arcanjo',
    'São João Batista',
    'São Jorge',
    'São Pio X',
    'São Rafael Arcanjo',
    'São Sebastião',
    'São Vicente de Paulo',
    'Santa Clara',
    'Santa Joana dArc',
    'Santa Josefina Bakhita',
    'Santa Luzia (Protetora dos olhos e da visão)',
    'Santa Mônica',
    'Santa Teresinha (Prece à Santa das Rosas)',
    'Santa Teresinha do Menino Jesus',
    'Santo Agostinho',
    'Santo Anjo',
    'Santo Antônio',
    'Santo Inácio de Loyola',
    'Santo Lenho de Nosso Senhor Jesus Cristo'
  ],
  'Orações': [
    'Oração aos três Anjos da Guarda',
    'Oração ao Beato Carlos de Foucauld',
    'Oração atribuída ao Papa Clemente XI',
    'Oração a Nossa Senhora',
    'Oração a Nossa Senhora da Paz',
    'Oração a Nosso Senhor Jesus Cristo Crucificado',
    'Oração a Santa Ana',
    'Oração a Santa Bárbara',
    'Oração a Santo Afonso Maria de Ligório',
    'Oração a São João Bosco - Dom Bosco',
    'Oração a São Lázaro',
    'Oração a São Vicente de Paulo',
    'Oração da Manhã',
    'Oração da Noite',
    'Oração da serenidade',
    'Oração de Santa Edwiges',
    'Oração de Santa Rita de Cássia',
    'Oração de Santo Ambrósio',
    'Oração de Santo Expedito',
    'Oração de Santo Tomás de Aquino',
    'Oração de São Bento',
    'Oração de São Francisco de Assis',
    'Oração de São João Crisóstomo',
    'Oração de São Judas Tadeu',
    'Oração Diária para os Sacerdotes do Beato Carlos de Foucauld',
    'Oração dos Casais',
    'Oração do Músico Cristão',
    'Oração para a família'
  ],
  'Ladainhas': [
    'Ladainha da Divina Misericórdia - Santa Faustina',
    'Ladainha da Humildade',
    'Ladainha de Nossa Senhora',
    'Ladainha de São José',
    'Ladainha de Todos os Santos',
    'Ladainha Do Preciosíssimo Sangue de Jesus',
    'Ladainha do Sagrado Coração de Jesus',
    'Ladainha pelas Almas'
  ],
  'Mistérios': [
    'Mistérios Dolorosos',
    'Mistérios Gloriosos',
    'Mistérios Gozosos',
    'Mistérios Luminosos'
  ],
  'Novenas': [
    'Novena a Imaculada Conceição',
    'Novena a Nossa Senhora das Mercês',
    'Novena a Nossa Senhora de Guadalupe',
    'Novena a Santa Edith Stein',
    'Novena a Santa Rita de Cássia',
    'Novena a São Miguel Arcanjo pela Purificação da Fé',
    'Novena ao Espírito Santo - clamando o Pentecostes',
    'Novena as Mãos Ensanguentadas de Jesus',
    'Novena contra a Depressão',
    'Novena da Medalha Milagrosa',
    'Novena de Frei Galvão',
    'Novena de Jesus Ressuscitado e Misericordioso',
    'Novena de Nossa Senhora Aparecida',
    'Novena de Nossa Senhora das Graças',
    'Novena de Nossa Senhora de Fátima',
    'Novena de Nossa Senhora do Carmo',
    'Novena de Nossa Senhora do Perpétuo Socorro',
    'Novena de Santa Teresinha do Menino Jesus',
    'Novena de Santo Expedito',
    'Novena de São José',
    'Novena de São Rafael',
    'Novena do Sagrado Coração de Jesus',
    'Novena pelas Almas',
    'Novena Santa Marta',
    'Novena à Santa Mônica'
  ],
  'Terços': [
    'Terço a Nossa Senhora Mãe de Jesus',
    'Terço das Lágrimas de Sangue de Maria Rosa Mística',
    'Terço das Santas Chagas de Cristo',
    'Terço da Batalha',
    'Terço da Divina Misericórdia',
    'Terço da Imaculada Conceição',
    'Terço da Libertação',
    'Terço da Nossa Senhora da Assunção',
    'Terço da Nossa Senhora do Santíssimo Sacramento',
    'Terço da Providência',
    'Terço de Nossa Senhora das Graças',
    'Terço de São Miguel Arcanjo',
    'Terço do Desagravo',
    'Terço do Imaculado Coração de Maria'
  ],
  'Maria': [
    'Amado Jesus, José e Maria',
    'Introdução ao Ofício da Imaculada Conceição da Virgem Maria',
    'Lembrai-vos (Virgem Maria)',
    'Maria Passa na Frente',
    'Ó Maria concebida sem pecado',
    'Socorrei Maria'
  ],
  'Orações Marianas': [
    'Nossa Senhora (Medalha Milagrosa)',
    'Nossa Senhora Auxiliadora',
    'Nossa Senhora das Dores',
    'Nossa Senhora das Graças',
    'Nossa Senhora da Cabeça',
    'Nossa Senhora da Conceição',
    'Nossa Senhora da Defesa',
    'Nossa Senhora da Saúde',
    'Nossa Senhora Desatadora de Nós',
    'Nossa Senhora Desatadora dos Nós',
    'Nossa Senhora de Casaluce',
    'Nossa Senhora de Fátima',
    'Nossa Senhora de Guadalupe',
    'Nossa Senhora de Lourdes',
    'Nossa Senhora de Nazaré',
    'Nossa Senhora de Schoenstatt',
    'Nossa Senhora dos Navegantes',
    'Nossa Senhora do bom parto',
    'Nossa Senhora do Bom Remédio',
    'Nossa Senhora do Carmo',
    'Nossa Senhora do Desterro',
    'Nossa Senhora do Perpétuo Socorro'
  ],
  'Consagrações': [
    'Consagração ao Divino Pai Eterno',
    'Consagração ao Imaculado Coração de Maria',
    'Consagração a Nossa Senhora Aparecida',
    'Consagração a Santíssima Virgem Maria',
    'Consagração da Família a Nossa Senhora das Mercês',
    'Desagravo e Consagração ao Coração de Jesus'
  ]
};

Map<String, String> caminhosMap = {
  'Ave Maria': 'assets/oracao/ave_maria.txt',
  'Anjo da Guarda': 'assets/oracao/anjo_da_guarda.txt',
  'Credo': 'assets/oracao/credo.txt',
  'Cordeiro de Deus': 'assets/oracao/Cordeiro_de_Deus.txt',
  'Glória a Deus nas alturas': 'assets/oracao/Gloria_a_Deus_nas_alturas.txt',
  'Glória ao Pai': 'assets/oracao/gloria_ao_pai.txt',
  'Pai Nosso': 'assets/oracao/pai_nosso.txt',
  'Salve Rainha': 'assets/oracao/Salve_Rainha.txt',
  'Sinal da Cruz': 'assets/oracao/sinal_da_cruz.txt',
  'São Benedito': 'assets/oracao/Sao_Benedito.txt',
  'São Brás (Protetor das doenças da garganta)':
      'assets/oracao/Sao_Bras_(Protetor_das_doencas_da_garganta).txt',
  'Novena a Imaculada Conceição': 'assets/oracao/Novena_a_Imaculada_Conceicao.txt',
  'Novena a Nossa Senhora das Mercês':
      'assets/oracao/Novena_a_Nossa_Senhora_das_Merces.txt',
  'Novena a Nossa Senhora de Guadalupe':
      'assets/oracao/Novena_a_Nossa_Senhora_de_Guadalupe.txt',
  'Novena a Santa Edith Stein': 'assets/oracao/Novena_a_Santa_Edith_Stein.txt',
  'Novena a Santa Rita de Cássia': 'assets/oracao/Novena_a_Santa_Rita_de_Cassia.txt',
  'Novena a São Miguel Arcanjo pela Purificação da Fé':
      'assets/oracao/Novena_a_Sao_Miguel_Arcanjo_pela_Purificacao_da_Fe.txt',
  'Novena ao Espírito Santo - clamando o Pentecostes':
      'assets/oracao/Novena_ao_Espirito_Santo_-_clamando_o_Pentecostes.txt',
  'Novena as Mãos Ensanguentadas de Jesus':
      'assets/oracao/Novena_as_Maos_Ensanguentadas_de_Jesus.txt',
  'Novena contra a Depressão': 'assets/oracao/Novena_contra_a_Depressao.txt',
  'Novena da Medalha Milagrosa': 'assets/oracao/Novena_da_Medalha_Milagrosa.txt',
  'Novena de Frei Galvão': 'assets/oracao/Novena_de_Frei_Galvao.txt',
  'Novena de Jesus Ressuscitado e Misericordioso':
      'assets/oracao/Novena_de_Jesus_Ressuscitado_e_Misericordioso.txt',
  'Novena de Nossa Senhora Aparecida':
      'assets/oracao/Novena_de_Nossa_Senhora_Aparecida.txt',
  'Novena de Nossa Senhora das Graças':
      'assets/oracao/Novena_de_Nossa_Senhora_das_Gracas.txt',
  'Novena de Nossa Senhora de Fátima':
      'assets/oracao/Novena_de_Nossa_Senhora_de_Fatima.txt',
  'Novena de Nossa Senhora do Carmo':
      'assets/oracao/Novena_de_Nossa_Senhora_do_Carmo.txt',
  'Novena de Nossa Senhora do Perpétuo Socorro':
      'assets/oracao/Novena_de_Nossa_Senhora_do_Perpétuo_Socorro.txt',
  'Novena de Santa Teresinha do Menino Jesus':
      'assets/oracao/Novena_de_Santa_Teresinha_do_Menino_Jesus.txt',
  'Novena de Santo Expedito': 'assets/oracao/Novena_de_Santo_Expedito.txt',
  'Novena de São José': 'assets/oracao/Novena_de_Sao_Jose.txt',
  'Novena de São Rafael': 'assets/oracao/Novena_de_Sao_Rafael.txt',
  'Novena do Sagrado Coração de Jesus':
      'assets/oracao/Novena_do_Sagrado_Coracao_de_Jesus.txt',
  'Novena pelas Almas': 'assets/oracao/Novena_pelas_Almas.txt',
  'Novena Santa Marta': 'assets/oracao/Novena_Santa_Marta.txt',
  'Novena à Santa Mônica': 'assets/oracao/Novena_a_Santa_Monica.txt',
  'Santa Clara': 'assets/oracao/Santa_Clara.txt',
  'Santa Joana dArc': 'assets/oracao/Santa_Joana_dArc.txt',
  'Santa Josefina Bakhita': 'assets/oracao/Santa_Josefina_Bakhita.txt',
  'Santa Luzia (Protetora dos olhos e da visão)':
      'assets/oracao/Santa_Luzia_(Protetora_dos_olhos_e_da_visao).txt',
  'Santa Mônica': 'assets/oracao/Santa_Monica.txt',
  'Santa Teresinha (Prece à Santa das Rosas)':
      'assets/oracao/Santa_Teresinha_(Prece_a_Santa_das_Rosas).txt',
  'Santa Teresinha do Menino Jesus':
      'assets/oracao/Santa_Teresinha_do_Menino_Jesus.txt',
  'Santo Agostinho': 'assets/oracao/Santo_Agostinho.txt',
  'Santo Anjo': 'assets/oracao/Santo_Anjo.txt',
  'Santo Antônio': 'assets/oracao/Santo_Antonio.txt',
  'Santo Inácio de Loyola': 'assets/oracao/Santo_Inacio_de_Loyola.txt',
  'Santo Lenho de Nosso Senhor Jesus Cristo':
      'assets/oracao/Santo_Lenho_de_Nosso_Senhor_Jesus_Cristo.txt',
  'São Cristóvão': 'assets/oracao/Sao_Cristovao.txt',
  'São Gabriel Arcanjo': 'assets/oracao/Sao_Gabriel_Arcanjo.txt',
  'São João Batista': 'assets/oracao/Sao_Joao_Batista.txt',
  'São Jorge': 'assets/oracao/Sao_Jorge.txt',
  'São Pio X': 'assets/oracao/Sao_Pio_X.txt',
  'São Rafael Arcanjo': 'assets/oracao/Sao_Rafael_Arcanjo.txt',
  'São Sebastião': 'assets/oracao/Sao_Sebastiao.txt',
  'São Vicente de Paulo': 'assets/oracao/Oracao_a_Sao_Vicente_de_Paulo.txt',
  'Terço a Nossa Senhora Mãe de Jesus':
      'assets/oracao/Terco_a_Nossa_Senhora_Mae_de_Jesus.txt',
  'Terço das Lágrimas de Sangue de Maria Rosa Mística':
      'assets/oracao/Terco_das_Lagrimas_de_Sangue_de_Maria_Rosa_Mistica.txt',
  'Terço das Santas Chagas de Cristo':
      'assets/oracao/Terco_das_Santas_Chagas_de_Cristo.txt',
  'Terço da Batalha': 'assets/oracao/Terco_da_Batalha.txt',
  'Terço da Divina Misericórdia': 'assets/oracao/Terco_da_Divina_Misericordia.txt',
  'Terço da Imaculada Conceição': 'assets/oracao/Terco_da_Imaculada_Conceicao.txt',
  'Terço da Libertação': 'assets/oracao/Terco_da_Libertacao.txt',
  'Terço da Nossa Senhora da Assunção':
      'assets/oracao/Terco_da_Nossa_Senhora_da_Assuncao.txt',
  'Terço da Nossa Senhora do Santíssimo Sacramento':
      'assets/oracao/Terco_da_Nossa_Senhora_do_Santissimo_Sacramento.txt',
  'Terço da Providência': 'assets/oracao/Terco_da_Providencia.txt',
  'Terço de Nossa Senhora das Graças':
      'assets/oracao/Terco_de_Nossa_Senhora_das_Gracas.txt',
  'Terço de São Miguel Arcanjo': 'assets/oracao/Terco_de_Sao_Miguel_Arcanjo.txt',
  'Terço do Desagravo': 'assets/oracao/Terco_do_Desagravo.txt',
  'Terço do Imaculado Coração de Maria':
      'assets/oracao/Terco_do_Imaculado_Coracao_de_Maria.txt',
  'Nossa Senhora (Medalha Milagrosa)':
      'assets/oracao/Nossa_Senhora_(Medalha_Milagrosa).txt',
  'Nossa Senhora Auxiliadora': 'assets/oracao/Nossa_Senhora_Auxiliadora.txt',
  'Nossa Senhora das Dores': 'assets/oracao/Nossa_Senhora_das_Dores.txt',
  'Nossa Senhora das Graças': 'assets/oracao/Nossa_Senhora_das_Gracas.txt',
  'Nossa Senhora da Cabeça': 'assets/oracao/Nossa_Senhora_da_Cabeca.txt',
  'Nossa Senhora da Conceição': 'assets/oracao/Nossa_Senhora_da_Conceicao.txt',
  'Nossa Senhora da Defesa': 'assets/oracao/Nossa_Senhora_da_Defesa.txt',
  'Nossa Senhora da Saúde': 'assets/oracao/Nossa_Senhora_da_Saude.txt',
  'Nossa Senhora Desatadora de Nós':
      'assets/oracao/Nossa_Senhora_Desatadora_de_Nos.txt',
  'Nossa Senhora Desatadora dos Nós':
      'assets/oracao/Nossa_Senhora_Desatadora_dos_Nos.txt',
  'Nossa Senhora de Casaluce': 'assets/oracao/Nossa_Senhora_de_Casaluce.txt',
  'Nossa Senhora de Fátima': 'assets/oracao/Nossa_Senhora_de_Fatima.txt',
  'Nossa Senhora de Guadalupe': 'assets/oracao/Nossa_Senhora_de_Guadalupe.txt',
  'Nossa Senhora de Lourdes': 'assets/oracao/Nossa_Senhora_de_Lourdes.txt',
  'Nossa Senhora de Nazaré': 'assets/oracao/Nossa_Senhora_de_Nazare.txt',
  'Nossa Senhora de Schoenstatt': 'assets/oracao/Nossa_Senhora_de_Schoenstatt.txt',
  'Nossa Senhora dos Navegantes': 'assets/oracao/Nossa_Senhora_dos_Navegantes.txt',
  'Nossa Senhora do bom parto': 'assets/oracao/Nossa_Senhora_do_bom_parto.txt',
  'Nossa Senhora do Bom Remédio': 'assets/oracao/Nossa_Senhora_do_Bom_Remedio.txt',
  'Nossa Senhora do Carmo': 'assets/oracao/Nossa_Senhora_do_Carmo.txt',
  'Nossa Senhora do Desterro': 'assets/oracao/Nossa_Senhora_do_Desterro.txt',
  'Nossa Senhora do Perpétuo Socorro':
      'assets/oracao/Nossa_Senhora_do_Perpetuo_Socorro.txt',
  'Oração aos três Anjos da Guarda':
      'assets/oracao/Oracao_aos_tres_Anjos_da_Guarda.txt',
  'Oração ao Beato Carlos de Foucauld':
      'assets/oracao/Oracao_ao_Beato_Carlos_de_Foucauld.txt',
  'Oração atribuída ao Papa Clemente XI':
      'assets/oracao/Oracao_atribuida_ao_Papa_Clemente_XI.txt',
  'Oração a Nossa Senhora': 'assets/oracao/Oracao_a_Nossa_Senhora.txt',
  'Oração a Nossa Senhora da Paz': 'assets/oracao/Oracao_a_Nossa_Senhora_da_Paz.txt',
  'Oração a Nosso Senhor Jesus Cristo Crucificado':
      'assets/oracao/Oracao_a_Nosso_Senhor_Jesus_Cristo_Crucificado.txt',
  'Oração a Santa Ana': 'assets/oracao/Oracao_a_Santa_Ana.txt',
  'Oração a Santa Bárbara': 'assets/oracao/Oracao_a_Santa_Barbara.txt',
  'Oração a Santo Afonso Maria de Ligório':
      'assets/oracao/Oracao_a_Santo_Afonso_Maria_de_Ligorio.txt',
  'Oração a São João Bosco - Dom Bosco':
      'assets/oracao/Oracao_a_Sao_Joao_Bosco_-_Dom_Bosco.txt',
  'Oração a São Lázaro': 'assets/oracao/Oracao_a_Sao_Lazaro.txt',
  'Oração a São Vicente de Paulo': 'assets/oracao/Oracao_a_Sao_Vicente_de_Paulo.txt',
  'Oração da Manhã': 'assets/oracao/Oracao_da_Manha.txt',
  'Oração da Noite': 'assets/oracao/Oracao_da_Noite.txt',
  'Oração da serenidade': 'assets/oracao/Oracao_da_serenidade.txt',
  'Oração de Santa Edwiges': 'assets/oracao/Oracao_de_Santa_Edwiges.txt',
  'Oração de Santa Rita de Cássia': 'assets/oracao/Oracao_de_Santa_Rita_de_Cassia.txt',
  'Oração de Santo Ambrósio': 'assets/oracao/Oracao_de_Santo_Ambrosio.txt',
  'Oração de Santo Expedito': 'assets/oracao/Oracao_de_Santo_Expedito.txt',
  'Oração de Santo Tomás de Aquino':
      'assets/oracao/Oracao_de_Santo_Tomas_de_Aquino.txt',
  'Oração de São Bento': 'assets/oracao/Oracao_de_Sao_Bento.txt',
  'Oração de São Francisco de Assis':
      'assets/oracao/Oracao_de_Sao_Francisco_de_Assis.txt',
  'Oração de São João Crisóstomo': 'assets/oracao/Oracao_de_Sao_Joao_Crisostomo.txt',
  'Oração de São Judas Tadeu': 'assets/oracao/Oracao_de_Sao_Judas_Tadeu.txt',
  'Oração Diária para os Sacerdotes do Beato Carlos de Foucauld':
      'assets/oracao/Oracao_Diaria_para_os_Sacerdotes_do_Beato_Carlos_de_Foucauld.txt',
  'Oração dos Casais': 'assets/oracao/Oracao_dos_Casais.txt',
  'Oração do Músico Cristão': 'assets/oracao/Oracao_do_Musico_Cristao.txt',
  'Oração para a família': 'assets/oracao/Oracao_para_a_familia.txt',
  'Consagração ao Divino Pai Eterno':
      'assets/oracao/Consagracao_ao_Divino_Pai_Eterno.txt',
  'Consagração ao Imaculado Coração de Maria':
      'assets/oracao/Consagracao_ao_Imaculado_Coracao_de_Maria.txt',
  'Consagração a Nossa Senhora Aparecida':
      'assets/oracao/Consagracao_a_Nossa_Senhora_Aparecida.txt',
  'Consagração a Santíssima Virgem Maria':
      'assets/oracao/Consagracao_a_Santissima_Virgem_Maria.txt',
  'Consagração da Família a Nossa Senhora das Mercês':
      'assets/oracao/Consagracao_da_Familia_a_Nossa_Senhora_das_Merces.txt',
  'Desagravo e Consagração ao Coração de Jesus':
      'assets/oracao/Desagravo_e_Consagracao_ao_Coracao_de_Jesus.txt',
  'Mistérios Dolorosos': 'assets/oracao/Misterios_Dolorosos.txt',
  'Mistérios Gloriosos': 'assets/oracao/Misterios_Gloriosos.txt',
  'Mistérios Gozosos': 'assets/oracao/Misterios_Gozosos.txt',
  'Mistérios Luminosos': 'assets/oracao/Misterios_Luminosos.txt',
  'Ladainha da Divina Misericórdia - Santa Faustina':
      'assets/oracao/Ladainha_da_Divina_Misericordia_-_Santa_Faustina.txt',
  'Ladainha da Humildade': 'assets/oracao/Ladainha_da_Humildade.txt',
  'Ladainha de Nossa Senhora': 'assets/oracao/Ladainha_de_Nossa_Senhora.txt',
  'Ladainha de São José': 'assets/oracao/Ladainha_de_Sao_Jose.txt',
  'Ladainha de Todos os Santos': 'assets/oracao/Ladainha_de_Todos_os_Santos.txt',
  'Ladainha Do Preciosíssimo Sangue de Jesus':
      'assets/oracao/Ladainha_Do_Preciosissimo_Sangue_de_Jesus.txt',
  'Ladainha do Sagrado Coração de Jesus':
      'assets/oracao/Ladainha_do_Sagrado_Coracao_de_Jesus.txt',
  'Ladainha pelas Almas': 'assets/oracao/Ladainha_pelas_Almas.txt',
  'Amado Jesus, José e Maria': 'assets/oracao/Amado_Jesus_Jose_e_Maria.txt',
  'Introdução ao Ofício da Imaculada Conceição da Virgem Maria':
      'assets/oracao/Introducao_ao_Oficio_da_Imaculada_Conceicao_da_Virgem_Maria.txt',
  'Lembrai-vos (Virgem Maria)': 'assets/oracao/Lembrai-vos_(Virgem_Maria).txt',
  'Maria Passa na Frente': 'assets/oracao/Maria_Passa_na_Frente.txt',
  'Ó Maria concebida sem pecado': 'assets/oracao/O_Maria_concebida_sem_pecado.txt',
  'Socorrei Maria': 'assets/oracao/Socorrei_Maria.txt',
  'Divino Pai Eterno': 'assets/oracao/Divino_Pai_Eterno.txt',
  'Os Sete Pai Nossos em honra ao Sangue de Jesus':
      'assets/oracao/Os_Sete_Pai_Nossos_em_honra_ao_Sangue_de_Jesus.txt',
  'Pai Eterno': 'assets/oracao/Pai_Eterno.txt',
  'Pelos falecidos': 'assets/oracao/Pelos_falecidos.txt',
  'Pelos filhos': 'assets/oracao/Pelos_filhos.txt',
  'Pelos mais necessitados': 'assets/oracao/Pelos_mais_necessitados.txt',
  'Pelos pais': 'assets/oracao/Pelos_pais.txt',
  'Pelos parentes ausentes': 'assets/oracao/Pelos_parentes_ausentes.txt',
  'Abri Senhor': 'assets/oracao/abri_senhor.txt',
  'À vossa proteção': 'assets/oracao/A_vossa_protecao.txt',
  'Para antes dos estudos': 'assets/oracao/Para_antes_dos_estudos.txt',
  'Para a família': 'assets/oracao/Para_a_familia.txt',
  'Para obter saúde': 'assets/oracao/Para_obter_saude.txt',
  'Para uma viagem': 'assets/oracao/Para_uma_viagem.txt'
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OracoesPage(),
    );
  }
}
class OracoesPage extends StatelessWidget {
  const OracoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              // Função para aumentar o tamanho da fonte
              // Pode ser implementada aqui
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              // Função para diminuir o tamanho da fonte
              // Pode ser implementada aqui
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 0, 63, 117), // Definindo a cor de fundo da página
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: temasOpcoesMap.keys.map((tema) {
            return TemaOracaoCard(
              tema: tema,
              opcoes: temasOpcoesMap[tema]!,
            );
          }).toList(),
        ),
      ),
    );
  }
}
class TemaOracaoCard extends StatelessWidget {
  final String tema;
  final List<String> opcoes;

  const TemaOracaoCard({Key? key, required this.tema, required this.opcoes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color:Color.fromARGB(255, 148, 203, 252),
      child: ExpansionTile(
        backgroundColor: Color.fromARGB(255, 221, 240, 255), // Alterando a cor de fundo do menu que expande para amarelo
        title: Text(
          tema,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: opcoes.map((opcao) {
          return OpcaoOracaoTile(
            opcao: opcao,
            arquivo: caminhosMap[opcao]!,
          );
        }).toList(),
      ),
    );
  }
}
class OpcaoOracaoTile extends StatelessWidget {
  final String opcao;
  final String arquivo;

  const OpcaoOracaoTile({Key? key, required this.opcao, required this.arquivo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(opcao),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OracaoPage(arquivo: arquivo)),
        );
      },
    );
  }
}
class OracaoPage extends StatefulWidget {
  final String arquivo;

  const OracaoPage({Key? key, required this.arquivo}) : super(key: key);

  @override
  _OracaoPageState createState() => _OracaoPageState();
}

class _OracaoPageState extends State<OracaoPage> {
  double _fontSize = 16.0;

  void _increaseFontSize() {
    setState(() {
      _fontSize += 1.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 1.0) {
        _fontSize -= 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oração'),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 0, 63, 117), // Definindo a cor de fundo da página
      body: FutureBuilder(
        future: rootBundle.loadString(widget.arquivo),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            final texto = snapshot.data!;
            final linhas = texto.split('\n');
            final primeiraLinha = linhas.isNotEmpty ? linhas[0] : '';
            final restante = linhas.skip(1).join('\n');

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 248, 255),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          primeiraLinha,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8), // Espaçamento entre as linhas
                        if (restante.isNotEmpty) ...[
                          const SizedBox(
                              height:
                                  8), // Espaçamento antes do restante do texto
                          Text(
                            restante,
                            style: TextStyle(fontSize: _fontSize),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
