class Product {
  // Identificação do Produto (Iremos buscar parametrizar todos os campos)
  String cProd; // Obrigatorio tambem para Informações do laioute  da NFC-e
  String? cEAN; // Obrigatorio tambem para Informações do laioute  da NFC-e
  String? xProd;
  String? NCM; // Obrigatorio tambem para Informações do laioute  da NFC-e

  // Informações adicionais
  String? imageUrl;
  String? categoria; // Categoria do produto
  String? gpcCode; // Código GPC (Global Product Classification) -
  String? marca; // Marca do produto
  String? descricao; // Descrição detalhada do produto
  List<dynamic>? CNPJFab;

  //Preços médios - Informações adicionais
  double? precoMedioUnitario; // Preço médio unitário calculado
  double? precoMedioVenda; //Preço de venda

  //Informações do laioute e Regras de Validação da NFC-e (obrigatorios)
  int CFOP = 5102;
  String? uCom; //unidade comercial
  String? CEST;

  // Tributação - Informações adicionais inicializados com null
  String? indEscala;
  String? cBenef;
  double? qCom;
  double? vUnCom;
  double? vProd;
  String? EXTIPI;

  // Frete, Seguro e Outras Despesas, inicializados com null
  double? vFrete; // Valor do Frete
  double? vSeg; // Valor do Seguro
  double? vOutro; // Outras Despesas Acessórias
  int indTot; //O=não integra, 1=integra

  // Medidas (volume, quantidade no lote, etc)
  double? qVol;
  String? uTrib;
  double? qTrib;
  double? vUnTrib;

  // Informações de desconto para vendas, inicializados com null
  double? vDesc; //Valor de Desconto

  // Rastreabilidade (Seção I80)
  String? nLote; // Número do Lote do produto
  double? qLote; // Quantidade de produto no Lote
  String? dFab; // Data de fabricação/ Produção
  String? dVal; // Data de Validade

  Product({
    required this.cProd,
    this.cEAN,
    this.xProd,
    this.NCM,
    this.imageUrl,
    this.categoria,
    this.gpcCode,
    this.marca,
    this.CNPJFab,
    this.descricao,
    this.precoMedioUnitario,
    this.precoMedioVenda,
    this.uCom,
    this.CEST,
    this.indTot = 1,
  });
  //Validação do NCM (agora SEMPRE obrigatório se cProd não for nulo)
  String? validateNCM() {
    if (cProd == null || cProd.isEmpty) {
      return null; //Nao executa validações
    } else if (NCM == null || NCM!.isEmpty) {
      return 'O campo NCM é obrigatório e deve ter 8 dígitos.';
    }
    return null; // NCM válido
  }

  //Validação dos campos
  String? validateField(String? value) {
    if (cProd != null) {
      if (value == null || value.isEmpty) {
        return 'O campo é obrigatório para emissão da NFe.';
      }
    }
    return null; // Valido quando o codeProduct for valido
  }

  //Monitora se todos os campos essenciais estão preenchidos
  bool allEssentialFieldsFilled() {
    return (xProd != null &&
        NCM != null &&
        uCom != null &&
        categoria != null &&
        gpcCode != null &&
        marca != null &&
        qCom != null &&
        vUnCom != null &&
        vProd != null);
  }

  //Retorna estado com base no allEssetialFieldsFilled
  String? validateState() {
    if (allEssentialFieldsFilled()) {
      return 'Produto completo';
    }
    return "Produto incompleto";
  }

  //Função para monitorar quais os campos estão faltando para que se torne valido
  List<String> checkPending() {
    List<String> pendencias = [];

    if (xProd == null || xProd!.isEmpty) {
      pendencias.add("Campo xProd Obrigatório");
    }
    if (NCM == null || NCM!.isEmpty) {
      pendencias.add("Campo NCM Obrigatório");
    }
    if (uCom == null || uCom!.isEmpty) {
      pendencias.add("Campo uCom Obrigatório");
    }
    if (categoria == null || categoria!.isEmpty) {
      pendencias.add("Campo Categoria Obrigatório");
    }
    if (gpcCode == null || gpcCode!.isEmpty) {
      pendencias.add("Campo GpcCode Obrigatório");
    }
    if (marca == null || marca!.isEmpty) {
      pendencias.add("Campo marca Obrigatório");
    }
    if (vProd == null) {
      pendencias.add("Campo valor total Obrigatório");
    }

    return pendencias;
  }

  //Retorna texto
  String textoPending() {
    List<String> pendencias = checkPending();
    String result = "";
    for (String pendencia in pendencias) {
      result += " - " + pendencia;
    }
    return result;
  }

  //Monitoramento (estado do preenchimento)
  double get completionPercentage {
    int totalFields = 25; //Total de campos essenciais
    int filledFields = 1; //Total de campos preenchidos

    if (xProd != null && xProd!.isNotEmpty) filledFields++;
    if (NCM != null && NCM!.isNotEmpty) filledFields++;

    if (categoria != null && categoria!.isNotEmpty) filledFields++;
    if (gpcCode != null && gpcCode!.isNotEmpty) filledFields++;
    if (marca != null && marca!.isNotEmpty) filledFields++;

    //Verifica campos adicionais e opcionais para tributação ST
    if (CEST != null) {
      filledFields++;
      totalFields++;
    }
    if (indEscala != null) {
      filledFields++;
      totalFields++;
    }
    if (CNPJFab != null) {
      filledFields++;
      totalFields++;
    }
    if (cBenef != null) {
      filledFields++;
      totalFields++;
    }

    if (qVol != null) {
      filledFields++;
      totalFields++;
    }
    if (uTrib != null) {
      filledFields++;
      totalFields++;
    }
    if (qTrib != null) {
      filledFields++;
      totalFields++;
    }
    if (vUnTrib != null) {
      filledFields++;
      totalFields++;
    }
    if (imageUrl != null) {
      filledFields++;
      totalFields++;
    }
    if (precoMedioUnitario != null) {
      filledFields++;
      totalFields++;
    }
    if (precoMedioVenda != null) {
      filledFields++;
      totalFields++;
    }

    return (filledFields / totalFields).clamp(0.0, 1.0);
  }

  //Função para exibir valor para monitoramento
  String getCompletionStatus() {
    double percentage = completionPercentage * 100;
    return '${percentage.toStringAsFixed(0)}% preenchidos ${textoPending()}';
  }

  @override
  String toString() {
    return 'Product{cProd: $cProd, cEAN: $cEAN, xProd: $xProd, NCM: $NCM, EXTIPI: $EXTIPI, CFOP: $CFOP, CEST: $CEST, indEscala: $indEscala, CNPJFab: $CNPJFab, cBenef: $cBenef, \nimageUrl:$imageUrl,\ncategoria: $categoria, gpcCode: $gpcCode, marca: $marca,\ndescricao: $descricao, precoMedioUnitario: $precoMedioUnitario,precoMedioVenda: $precoMedioVenda,}';
  }

  Map<String, dynamic> toMap() => {
    'cProd': cProd,
    'cEAN': cEAN,
    'xProd': xProd,
    'NCM': NCM,
    'EXTIPI': EXTIPI,
    'CFOP': CFOP,
    'uCom': uCom,
    'qCom': qCom,
    'vUnCom': vUnCom,
    'vProd': vProd,
    'CEST': CEST,
    'indEscala': indEscala,
    'CNPJFab': CNPJFab,
    'cBenef': cBenef,
    'qVol': qVol,
    'uTrib': uTrib,
    'qTrib': qTrib,
    'vUnTrib': vUnTrib,
    'imageUrl': imageUrl,
    'categoria': categoria,
    'gpcCode': gpcCode,
    'marca': marca,
    'descricao': descricao,
    'precoMedioUnitario': precoMedioUnitario,
    'precoMedioVenda': precoMedioVenda,
    'completionPercentage': completionPercentage,
    'textoPending': textoPending(),
    'nLote': nLote,
    'dFab': dFab,
    'dVal': dVal,
    'VFrete': vFrete,
    'vSeg': vSeg,
    'vOutro': vOutro,
    'vDesc': vDesc,
  };
}

class DeclarationOfImport {
  String nDI; // Número do Documento de Importação (DI, DSI, DIRE, ...) (I19)
  String dDI; // Data de Registro do documento (I20)
  String xLocDesemb; // Local de desembaraço (I21)
  String UFDesemb; // UF de desembaraço (I22)
  String dDesemb; // Data de Desembaraço Aduaneiro (I23)
  //construtor
  DeclarationOfImport({
    required this.nDI,
    required this.dDI,
    required this.xLocDesemb,
    required this.UFDesemb,
    required this.dDesemb,
  });
}

class ProductSpecification {
  final String campo;
  final String tipo;
  final String labelText;
  final String resumo;

  ProductSpecification({
    required this.campo,
    required this.tipo,
    required this.labelText,
    required this.resumo,
  });
}

final List<ProductSpecification> productSpecifications = [
  ProductSpecification(
    campo: 'cProd',
    tipo: 'String',
    labelText: 'Código do Produto',
    resumo: 'Código interno de identificação do produto. Obrigatório.',
  ),
  ProductSpecification(
    campo: 'xProd',
    tipo: 'String?',
    labelText: 'Nome do Produto',
    resumo:
        'Nome do produto. Pode ser o mesmo do campo acima. Deixe em branco se não houver.',
  ),
  ProductSpecification(
    campo: 'cEAN',
    tipo: 'String?',
    labelText: 'GTIN (Código de Barras)',
    resumo:
        'Código de barras do produto (EAN, GTIN, UPC). Deixe em branco se não houver.',
  ),
  ProductSpecification(
    campo: 'NCM',
    tipo: 'String',
    labelText: 'NCM (8 dígitos)',
    resumo:
        'Código da Nomenclatura Comum do Mercosul. Deixe em branco se não houver',
  ),
  ProductSpecification(
    campo: 'gpcCode',
    tipo: 'String?',
    labelText: 'GPC Code',
    resumo:
        'Código GPC (Global Product Classification). Deixe em branco se não houver.',
  ),
  ProductSpecification(
    campo: 'categoria',
    tipo: 'String?',
    labelText: 'Categoria',
    resumo:
        'Categoria do produto (ex: "Cerveja", "Refrigerante", "Lanche"). Deixe em branco se não houver',
  ),
  ProductSpecification(
    campo: 'uCom',
    tipo: 'String?',
    labelText: 'Unidade Comercial',
    resumo:
        'Informar a unidade de comercialização do produto. Deixe em branco se não houver.',
  ),
  ProductSpecification(
    campo: 'marca',
    tipo: 'String?',
    labelText: 'Marca',
    resumo:
        'Marca do produto. Deixe em branco se não houver ou cadastre uma nova. **CNPJ obrigatorio para o cadastro.',
  ),
  ProductSpecification(
    campo: 'CEST',
    tipo: 'String?',
    labelText: 'CEST (Opcional)',
    resumo:
        'Código Especificador da Substituição Tributária. Importante para ST. Deixe em branco se não houver.',
  ),
  ProductSpecification(
    campo: 'precoMedioUnitario',
    tipo: 'double?',
    labelText: 'Preço médio unitário',
    resumo: 'Preço médio unitário calculado',
  ),
  ProductSpecification(
    campo: 'precoMedioVenda',
    tipo: 'double?',
    labelText: 'Preço médio de venda',
    resumo: 'Preço médio de venda',
  ),
  ProductSpecification(
    campo: 'descricao',
    tipo: 'String?',
    labelText: 'Descrição',
    resumo: 'Descrição detalhada do produto. *Obrigatório*.',
  ),
];
