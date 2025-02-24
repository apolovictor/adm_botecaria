class Product {
  // Identificação do Produto ou Serviço
  String? cProd; // Código do produto ou serviço (I02)
  String? cEAN; // GTIN (Global Trade Item Number) do produto (I03)
  String xProd; // Descrição do produto ou serviço (I04)
  String NCM; // Código NCM (Nomenclatura Comum do Mercosul) (I05)
  String?
  EXTIPI; // Código EX_TIPI (Tabela de Incidência do Imposto sobre Produtos Industrializados) (I06)
  String? CFOP; // Código Fiscal de Operações e Prestações (I07)
  String uCom; // Unidade Comercial (I08)
  double qCom; // Quantidade Comercial (I09)
  double vUnCom; // Valor Unitário de Comercialização (I10)
  double vProd; // Valor Total Bruto dos Produtos ou Serviços (I11)

  // Informações adicionais
  String? imageUrl; // URL da imagem do produto
  String categoria; // Categoria do produto
  String gpcCode; // Código GPC (Global Product Classification)
  String marca; // Marca do produto
  String descricao; // Descrição detalhada do produto

  // Tributação (Adicional para Substituição Tributária)
  String? CEST; // Código Especificador da Substituição Tributária (I05b)
  String? indEscala; // Indicador de Escala Relevante (I05d)
  String? CNPJFab; // CNPJ do Fabricante da Mercadoria (I05e)
  String? cBenef; // Código de Benefício Fiscal na UF aplicado ao item (I05f)

  // Medidas (volume, quantidade no lote, etc)
  double? qVol; // Quantidade no Lote
  String? uTrib; // Unidade Tributável (I12)
  double? qTrib; // Quantidade Tributável (I13)
  double? vUnTrib; // Valor Unitário de Tributação (I14a)

  //Rastreabilidade (Seção I80)
  String? nLote; //Número do Lote do produto
  double? qLote; //Quantidade de produto no Lote
  String? dFab; //Data de fabricação/ Produção
  String? dVal; //Data de Validade

  //Preços médios
  double? precoMedioUnitario; // Preço médio unitário calculado
  double? precoMedioVenda; //Preço de venda

  int indTot; //O=não integra, 1=integra

  //Construtor
  Product({
    this.cProd,
    this.cEAN,
    required this.xProd,
    required this.NCM,
    this.EXTIPI,
    this.CFOP,
    required this.uCom,
    required this.qCom,
    required this.vUnCom,
    required this.vProd,
    this.CEST,
    this.indEscala,
    this.CNPJFab,
    this.cBenef,
    this.qVol,
    this.uTrib,
    this.qTrib,
    this.vUnTrib,
    this.nLote,
    this.qLote,
    this.dFab,
    this.dVal,
    required this.categoria,
    required this.gpcCode,
    required this.marca,
    required this.descricao,
    this.indTot = 1,

    this.imageUrl,
    this.precoMedioUnitario,
    this.precoMedioVenda,
  });

  //Monitoramento (estado do preenchimento)
  double get completionPercentage {
    int totalFields = 23; //Quantidade de campos opcionais que podem ser nulos
    int filledFields =
        13; //NCM, xProd, uCom, quantCom, vUnCom, VProd, , categoria, gpcCode, marca, Descricao e campos essenciais
    //Verifica campos adicionais para tributação ST
    if (CEST != null) filledFields++;
    if (indEscala != null) filledFields++;
    if (CNPJFab != null) filledFields++;
    if (cBenef != null) filledFields++;

    if (qVol != null) filledFields++;
    if (uTrib != null) filledFields++;
    if (qTrib != null) filledFields++;
    if (vUnTrib != null) filledFields++;

    if (nLote != null) filledFields++;
    if (qLote != null) filledFields++;
    if (dFab != null) filledFields++;
    if (dVal != null) filledFields++;

    if (imageUrl != null) filledFields++;
    if (precoMedioUnitario != null) filledFields++;
    if (precoMedioVenda != null) filledFields++;

    return (filledFields / totalFields).clamp(0.0, 1.0);
  }

  //Função para exibir valor para monitoramento
  String getCompletionStatus() {
    double percentage = completionPercentage * 100;
    return '${percentage.toStringAsFixed(0)}% Completed';
  }

  //Validação do NCM (agora SEMPRE obrigatório)
  String? validateNCM() {
    if (NCM == null || NCM.length != 8) {
      return 'O campo NCM é obrigatório e deve ter 8 dígitos.';
    }
    return null; // NCM válido
  }

  @override
  String toString() {
    return 'Product{cProd: $cProd, cEAN: $cEAN, xProd: $xProd, NCM: $NCM, EXTIPI: $EXTIPI, CFOP: $CFOP, uCom: $uCom, qCom: $qCom, vUnCom: $vUnCom, vProd: $vProd, CEST: $CEST, indEscala: $indEscala, CNPJFab: $CNPJFab, cBenef: $cBenef, \nimageUrl:$imageUrl,\ncategoria: $categoria, gpcCode: $gpcCode, marca: $marca,\ndescricao: $descricao, precoMedioUnitario: $precoMedioUnitario,precoMedioVenda: $precoMedioVenda}';
  }

  Map<String, dynamic> toJson() => {
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
    'nLote': nLote,
    'qLote': qLote,
    'dFab': dFab,
    'dVal': dVal,

    'imageUrl': imageUrl,
    'categoria': categoria,
    'gpcCode': gpcCode,
    'marca': marca,
    'descricao': descricao,
    'precoMedioUnitario': precoMedioUnitario,
    'precoMedioVenda': precoMedioVenda,
    'completionPercentage': completionPercentage,
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
    tipo: 'String?',
    labelText: 'Código do Produto',
    resumo: 'Código interno ou externo de identificação do produto. Opcional.',
  ),
  ProductSpecification(
    campo: 'cEAN',
    tipo: 'String?',
    labelText: 'GTIN (Código de Barras)',
    resumo: 'Código de barras do produto (EAN, UPC). Use null se não houver.',
  ),
  ProductSpecification(
    campo: 'xProd',
    tipo: 'String',
    labelText: 'Nome do Produto',
    resumo: 'Descrição do produto. *Obrigatório*.',
  ),
  ProductSpecification(
    campo: 'NCM',
    tipo: 'String',
    labelText: 'NCM (8 dígitos)',
    resumo: 'Código da Nomenclatura Comum do Mercosul. *Obrigatório*.',
  ),
  ProductSpecification(
    campo: 'EXTIPI',
    tipo: 'String?',
    labelText: 'Código EX TIPI (Opcional)',
    resumo: 'Código EX da TIPI. Opcional.',
  ),
  ProductSpecification(
    campo: 'CFOP',
    tipo: 'String?',
    labelText: 'CFOP',
    resumo: 'Código Fiscal de Operações e Prestações. Depende da operação.',
  ),
  ProductSpecification(
    campo: 'imageUrl',
    tipo: 'String?',
    labelText: 'Url Imagem',
    resumo: 'Endereço da imagem do produto. Opcional.',
  ),
  ProductSpecification(
    campo: 'categoria',
    tipo: 'String',
    labelText: 'Categoria',
    resumo:
        'Categoria do produto (ex: "Cerveja", "Refrigerante", "Lanche"). *Obrigatório*.',
  ),
  ProductSpecification(
    campo: 'gpcCode',
    tipo: 'String',
    labelText: 'GPC Code',
    resumo: 'Código GPC (Global Product Classification). *Obrigatório*.',
  ),
  ProductSpecification(
    campo: 'marca',
    tipo: 'String',
    labelText: 'Marca',
    resumo: 'Marca do produto. *Obrigatório*.',
  ),
  ProductSpecification(
    campo: 'descricao',
    tipo: 'String',
    labelText: 'Descrição',
    resumo: 'Descrição detalhada do produto. *Obrigatório*.',
  ),
  ProductSpecification(
    campo: 'CEST',
    tipo: 'String?',
    labelText: 'CEST (Opcional)',
    resumo:
        'Código Especificador da Substituição Tributária. Importante para ST.',
  ),
  ProductSpecification(
    campo: 'indEscala',
    tipo: 'String?',
    labelText: 'Indicador Escala (Opcional)',
    resumo: 'Indicador de Produção em escala relevante ou não.',
  ),
  ProductSpecification(
    campo: 'CNPJFab',
    tipo: 'String?',
    labelText: 'CNPJ Fabricante (Opcional)',
    resumo: 'CNPJ do Fabricante da Mercadoria, se a escala não for relevante.',
  ),
  ProductSpecification(
    campo: 'cBenef',
    tipo: 'String?',
    labelText: 'Cod Benef (Opcional)',
    resumo: 'Código de Benefício Fiscal, se aplicável.',
  ),
  ProductSpecification(
    campo: 'qVol',
    tipo: 'double?',
    labelText: 'Quantidade no Lote (Opcional)',
    resumo: 'Quantidade de produto no Lote.',
  ),
  ProductSpecification(
    campo: 'uTrib',
    tipo: 'String?',
    labelText: 'Unidade Tributável (Opcional)',
    resumo: 'Unidade de medida para fins de tributação.',
  ),
  ProductSpecification(
    campo: 'qTrib',
    tipo: 'double?',
    labelText: 'Quantidade Tributável (Opcional)',
    resumo: 'Quantidade para fins de tributação.',
  ),
  ProductSpecification(
    campo: 'vUnTrib',
    tipo: 'double?',
    labelText: 'Valor Unitário Tributação (Opcional)',
    resumo: 'Valor unitário para fins de tributação.',
  ),
  ProductSpecification(
    campo: 'nLote',
    tipo: 'String?',
    labelText: 'NLote (Opcional)',
    resumo: 'Número de série do produto',
  ),
  ProductSpecification(
    campo: 'qLote',
    tipo: 'double?',
    labelText: 'Quantidade no lote (Opcional)',
    resumo: 'Número do lote do produto',
  ),
  ProductSpecification(
    campo: 'dFab',
    tipo: 'String?',
    labelText: 'dFab (Opcional)',
    resumo: 'Data de Fabricação',
  ),
  ProductSpecification(
    campo: 'dVal',
    tipo: 'String?',
    labelText: 'dVal (Opcional)',
    resumo: 'Data de Validade',
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
];
