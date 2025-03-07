import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/utils/const.dart';

class Product {
  // Identificação do Produto (Iremos buscar parametrizar todos os campos)
  String cProd; // Obrigatorio tambem para Informações do laioute  da NFC-e
  int? cEAN; // Obrigatorio tambem para Informações do laioute  da NFC-e
  String? xProd;
  int? NCM; // Obrigatorio tambem para Informações do laioute  da NFC-e

  // Informações adicionais
  String? imageUrl;
  String? category; // Category do produto
  String? categoryName; // Category do produto
  int? gpcSegmentCode; // Código GPC (Global Product Classification) -
  String? gpcSegmentDescription; // Código GPC (Global Product Classification) -
  int? gpcFamilyCode; // Código GPC (Global Product Classification) -
  String? gpcFamilyDescription; // Código GPC (Global Product Classification) -
  int? gpcClassCode; // Código GPC (Global Product Classification) -
  String? gpcClassDescription; // Código GPC (Global Product Classification) -
  int? gpcBrickCode; // Código GPC (Global Product Classification) -
  String? gpcBrickDescription; // Código GPC (Global Product Classification) -
  String? gpcBrickDefinition; // Código GPC (Global Product Classification) -
  String? manufacturerBrand; // Marca do produto
  List<dynamic>? CNPJFab;
  String? manufacturerImageUrl;
  String? description; // Descrição detalhada do produto
  double? completionPercentage; // Add this line

  //Preços médios - Informações adicionais
  double? precoMedioUnitario; // Preço médio unitário calculado
  double? precoMedioVenda; //Preço de venda

  //Informações do laioute e Regras de Validação da NFC-e (obrigatorios)
  int CFOP = 5102;
  String? uCom; //unidade comercial
  int? CEST;

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
    this.category,
    this.categoryName,
    this.gpcSegmentCode,
    this.gpcSegmentDescription,
    this.gpcFamilyCode,
    this.gpcFamilyDescription,
    this.gpcClassCode,
    this.gpcClassDescription,
    this.gpcBrickCode,
    this.gpcBrickDescription,
    this.gpcBrickDefinition,
    this.manufacturerBrand,
    this.CNPJFab,
    this.manufacturerImageUrl,
    this.description,
    this.completionPercentage,
    this.precoMedioUnitario,
    this.precoMedioVenda,
    this.uCom,
    this.CEST,
    this.indTot = 1,
  });

  //Monitora se todos os campos essenciais estão preenchidos
  bool allEssentialFieldsFilled() {
    return (xProd != null &&
        NCM != null &&
        uCom != null &&
        category != null &&
        gpcSegmentCode != null &&
        gpcFamilyCode != null &&
        gpcClassCode != null &&
        gpcBrickCode != null &&
        manufacturerBrand != null &&
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
    if (NCM == null) {
      pendencias.add("Campo NCM Obrigatório");
    }
    if (uCom == null || uCom!.isEmpty) {
      pendencias.add("Campo uCom Obrigatório");
    }
    if (category == null || category!.isEmpty) {
      pendencias.add("Campo Category Obrigatório");
    }

    if (gpcFamilyCode == null) {
      pendencias.add("Campo Gpc Família Obrigatório");
    }
    if (gpcClassCode == null) {
      pendencias.add("Campo Gpc Classe Obrigatório");
    }
    if (gpcBrickCode == null) {
      pendencias.add("Campo GPC Brick Obrigatório");
    }
    if (manufacturerBrand == null || manufacturerBrand!.isEmpty) {
      pendencias.add("Campo marca Obrigatório");
    }

    return pendencias;
  }

  //Monitoramento campos obrigatórios (estado do preenchimento)
  double get getCompletionPercentage {
    int totalFields = requiredFields; //Total de campos essenciais
    int filledFields = 1; //Total de campos preenchidos
    if (imageUrl != null) {
      filledFields++;
    }
    if (xProd != null && xProd!.isNotEmpty) {
      filledFields++;
    }
    if (cEAN != null) {
      filledFields++;
    }
    if (NCM != null) {
      filledFields++;
    }
    if (gpcFamilyCode != null) {
      filledFields++;
    }
    if (gpcClassCode != null) {
      filledFields++;
    }
    if (gpcBrickCode != null) {
      filledFields++;
    }
    if (category != null && category!.isNotEmpty) {
      filledFields++;
    }
    if (uCom != null && uCom!.isNotEmpty) {
      filledFields++;
    }

    if ((manufacturerBrand != null && manufacturerBrand!.isNotEmpty) ||
        (CNPJFab != null)) {
      filledFields++;
    }
    //Verifica campos adicionais e opcionais para tributação ST
    if (CEST != null) {
      filledFields++;
    }

    if (precoMedioUnitario != null) {
      filledFields++;
    }
    if (precoMedioVenda != null) {
      filledFields++;
    }

    print('filledFields === $filledFields');
    print('totalFields === $totalFields');

    return (filledFields / totalFields).clamp(0.0, 1.0);
  }

  @override
  String toString() {
    return 'Product{cProd: $cProd, cEAN: $cEAN, xProd: $xProd, NCM: $NCM, EXTIPI: $EXTIPI, CFOP: $CFOP, CEST: $CEST, indEscala: $indEscala, CNPJFab: $CNPJFab, cBenef: $cBenef, \nimageUrl:$imageUrl,\ncategory: $category, categoryName: $categoryName, gpcSegmentCode: $gpcSegmentCode, gpcFamilyCode: $gpcFamilyCode, gpcClassCode: $gpcClassCode, gpcBrickCode: $gpcBrickCode, manufacturerBrand: $manufacturerBrand,\ndescription: $description, precoMedioUnitario: $precoMedioUnitario,precoMedioVenda: $precoMedioVenda,}';
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
    'manufacturerImageUrl': manufacturerImageUrl,
    'category': category,
    'categoryName': categoryName,
    'gpcSegmentCode': 50000000,
    'gpcSegmentDescription': 'Alimentos Bebidas',
    'gpcFamilyCode': gpcFamilyCode,
    'gpcFamilyDescription': gpcFamilyDescription,
    'gpcClassCode': gpcClassCode,
    'gpcClassDescription': gpcClassDescription,
    'gpcBrickCode': gpcBrickCode,
    'gpcBrickDescription': gpcBrickDescription,
    'gpcBrickDefinition': gpcBrickDefinition,
    'manufacturerBrand': manufacturerBrand,
    'description': description,
    'precoMedioUnitario': precoMedioUnitario,
    'precoMedioVenda': precoMedioVenda,
    'completionPercentage': getCompletionPercentage,
    'nLote': nLote,
    'dFab': dFab,
    'dVal': dVal,
    'VFrete': vFrete,
    'vSeg': vSeg,
    'vOutro': vOutro,
    'vDesc': vDesc,
  };

  factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!; // Use ! to assert that data is not null

    return Product(
      cProd: data['cProd'] as String, // Ensure correct casting
      cEAN: data['cEAN'] as int?,
      xProd: data['xProd'] as String?,
      NCM: data['NCM'] as int?,
      imageUrl: data['imageUrl'] as String?,
      category: data['category'] as String?,
      categoryName: data['categoryName'] as String?,
      gpcSegmentCode: data['gpcSegmentCode'] as int?,
      gpcSegmentDescription: data['gpcSegmentDescription'] as String?,
      gpcFamilyCode: data['gpcFamilyCode'] as int?,
      gpcFamilyDescription: data['gpcFamilyDescription'] as String?,
      gpcClassCode: data['gpcClassCode'] as int?,
      gpcClassDescription: data['gpcClassDescription'] as String?,
      gpcBrickCode: data['gpcBrickCode'] as int?,
      gpcBrickDescription: data['gpcBrickDescription'] as String?,
      gpcBrickDefinition: data['gpcBrickDefinition'] as String?,
      manufacturerBrand: data['manufacturerBrand'] as String?,
      CNPJFab: data['CNPJFab'] as List<dynamic>?,
      manufacturerImageUrl: data['manufacturerImageUrl'] as String?,
      description: data['description'] as String?,
      precoMedioUnitario: data['precoMedioUnitario'] as double?,
      precoMedioVenda: data['precoMedioVenda'] as double?,
      completionPercentage: data['completionPercentage'] as double?,
      uCom: data['uCom'] as String?,
      CEST: data['CEST'] as int?,
      indTot:
          (data['indTot'] as num?)?.toInt() ?? 1, // Ensure int and handle null
    );
  }
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
    campo: 'category',
    tipo: 'String?',
    labelText: 'Category',
    resumo:
        'Category do produto (ex: "Cerveja", "Refrigerante", "Lanche"). Deixe em branco se não houver',
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


//  //Monitoramento (estado do preenchimento)
//   double get completionPercentage {
//     int totalFields = 25; //Total de campos essenciais
//     int filledFields = 1; //Total de campos preenchidos

//     if (xProd != null && xProd!.isNotEmpty) filledFields++;
//     if (NCM != null) filledFields++;

//     if (category != null && category!.isNotEmpty) filledFields++;
//     if (gpcSegmentCode != null) filledFields++;
//     if (gpcFamilyCode != null) filledFields++;
//     if (gpcClassCode != null) filledFields++;
//     if (gpcBrickCode != null) filledFields++;
//     if (manufacturerBrand != null && manufacturerBrand!.isNotEmpty)
//       filledFields++;

//     //Verifica campos adicionais e opcionais para tributação ST
//     if (CEST != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (indEscala != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (CNPJFab != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (cBenef != null) {
//       filledFields++;
//       totalFields++;
//     }

//     if (qVol != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (uTrib != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (qTrib != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (vUnTrib != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (imageUrl != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (precoMedioUnitario != null) {
//       filledFields++;
//       totalFields++;
//     }
//     if (precoMedioVenda != null) {
//       filledFields++;
//       totalFields++;
//     }

//     return (filledFields / totalFields).clamp(0.0, 1.0);
//   }