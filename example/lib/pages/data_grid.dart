import 'package:flutter/material.dart';

class DataGrid extends StatefulWidget {
  @override
  _DataGridState createState() => _DataGridState();
}

bool isSorted = false;

class _DataGridState extends State<DataGrid> {
  Widget bodyData() => DataTable(
      columnSpacing: 0,
      sortColumnIndex: 0,
      sortAscending: true,
      onSelectAll: (b) {},
      columns: <DataColumn>[
        DataColumn(
          label: Text("Hierarchy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onSort: (i, b) {
            sortColumn(1);
          },
        ),
        DataColumn(
          label: Text("Position",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onSort: (i, b) {
            sortColumn(2);
          },
        ),
        DataColumn(
          label: Text("BNLMDT",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onSort: (i, b) {
            sortColumn(3);
          },
        ),
        DataColumn(
          label: Text("BNLTYD",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onSort: (i, b) {
            sortColumn(4);
          },
        ),
        DataColumn(
          label: Text("MMV",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onSort: (i, b) {
            sortColumn(5);
          },
        ),
        DataColumn(
          label: Text("EPD",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onSort: (i, b) {
            sortColumn(6);
          },
        ),
      ],
      rows: sampledata
          .map(
            (data) => DataRow(
              cells: [
                DataCell(
                  Text(data.Hierarchy,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  placeholder: true,
                ),
                DataCell(
                  Text(data.Position.toString(),
                      style: TextStyle(
                          color: setColor(data.Position.toInt()),
                          fontSize: 14)),
                  placeholder: false,
                ),
                DataCell(
                  Text(data.BNL_MDT.toString(),
                      style: TextStyle(
                          color: setColor(data.Position.toInt()),
                          fontSize: 14)),
                  placeholder: false,
                ),
                DataCell(
                  Text(data.BNL_TYD.toString(),
                      style: TextStyle(
                          color: setColor(data.Position.toInt()),
                          fontSize: 14)),
                  placeholder: false,
                ),
                DataCell(
                  Text(data.MMV.toString(),
                      style: TextStyle(
                          color: setColor(data.Position.toInt()),
                          fontSize: 14)),
                  placeholder: false,
                ),
                DataCell(
                  Text(data.EPD$.toString(),
                      style: TextStyle(
                          color: setColor(data.Position.toInt()),
                          fontSize: 14)),
                  placeholder: false,
                )
              ],
            ),
          )
          .toList());

  void sortColumn(int columnIndex) {
    setState(() {
      if(isSorted == false) {
        if (columnIndex == 1) {
          sampledata.sort((a, b) => a.Hierarchy.compareTo(b.Hierarchy));
        }
        if (columnIndex == 2) {
          sampledata.sort((a, b) => a.Position.compareTo(b.Position));
        }
        if (columnIndex == 3) {
          sampledata.sort((a, b) => a.BNL_MDT.compareTo(b.BNL_MDT));
        }
        if (columnIndex == 4) {
          sampledata.sort((a, b) => a.BNL_TYD.compareTo(b.BNL_TYD));
        }
        if (columnIndex == 5) {
          sampledata.sort((a, b) => a.MMV.compareTo(b.MMV));
        }
        if (columnIndex == 6) {
          sampledata.sort((a, b) => a.EPD$.compareTo(b.EPD$));
        }
        isSorted = true;
      } else {
        if (columnIndex == 1) {
          sampledata.sort((a, b) => b.Hierarchy.compareTo(a.Hierarchy));
        }
        if (columnIndex == 2) {
          sampledata.sort((a, b) => b.Position.compareTo(a.Position));
        }
        if (columnIndex == 3) {
          sampledata.sort((a, b) => b.BNL_MDT.compareTo(a.BNL_MDT));
        }
        if (columnIndex == 4) {
          sampledata.sort((a, b) => b.BNL_TYD.compareTo(a.BNL_TYD));
        }
        if (columnIndex == 5) {
          sampledata.sort((a, b) => b.MMV.compareTo(a.MMV));
        }
        if (columnIndex == 6) {
          sampledata.sort((a, b) => b.EPD$.compareTo(a.EPD$));
        }
        isSorted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meteorite Mobile"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: bodyData(),
          ),
        ));
  }
}

MaterialColor setColor(int num) {
  if (num == 0) {
    return Colors.amber;
  } else if (num < 0) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}

class GridData {
  String Hierarchy;
  int Position;
  int BNL_MDT;
  int BNL_TYD;
  int MMV;
  int EPD$;

//  GridData({this.Hierarchy, this.Position, this.BNLMDT, this.BNLTYD});
  GridData(
      {this.Hierarchy,
      this.Position,
      this.BNL_MDT,
      this.BNL_TYD,
      this.MMV,
      this.EPD$});
}

var sampledata = <GridData>[
  GridData(
      Hierarchy: "Grand Total",
      Position: 1003992,
      BNL_MDT: 435,
      BNL_TYD: 2332,
      MMV: 345345,
      EPD$: -34543),
  GridData(
      Hierarchy: "JGLOBAL",
      Position: 3884783,
      BNL_MDT: -454466,
      BNL_TYD: 5654654,
      MMV: 3453466,
      EPD$: -333883),
  GridData(
      Hierarchy: "ADOWING",
      Position: -5994,
      BNL_MDT: 0,
      BNL_TYD: -399,
      MMV: 2333,
      EPD$: 234),
  GridData(
      Hierarchy: "STATINDIGO",
      Position: 399489,
      BNL_MDT: -33,
      BNL_TYD: 6644,
      MMV: 2343234,
      EPD$: 634534),
  GridData(
      Hierarchy: "Capital Trust, Inc",
      Position: 399489,
      BNL_MDT: -33,
      BNL_TYD: 6644,
      MMV: 2343234,
      EPD$: 634534),
  GridData(
      Hierarchy: "STATALPHA",
      Position: -66556,
      BNL_MDT: 13003992,
      BNL_TYD: -23423,
      MMV: 44433,
      EPD$: -4443),
  GridData(
      Hierarchy: "Jupai Holdings Limited",
      Position: 0,
      BNL_MDT: 33345,
      BNL_TYD: 23233,
      MMV: 4353543,
      EPD$: -34534),
  GridData(
      Hierarchy: "MICRO",
      Position: 0,
      BNL_MDT: 33345,
      BNL_TYD: 23233,
      MMV: 4353543,
      EPD$: -34534),
  GridData(
      Hierarchy: "Kennametal Inc.",
      Position: 0,
      BNL_MDT: 33345,
      BNL_TYD: 23233,
      MMV: 4353543,
      EPD$: -34534),
  GridData(
      Hierarchy: "Fifth Street Finance Corp.",
      Position: 38829,
      BNL_MDT: -59955,
      BNL_TYD: 3465363,
      MMV: 5435,
      EPD$: 23432),
  GridData(
      Hierarchy: "MORTGAGESTAT",
      Position: 38829,
      BNL_MDT: -59955,
      BNL_TYD: 3465363,
      MMV: 5435,
      EPD$: 23432),
  GridData(
      Hierarchy: "CBL & Associates Properties, Inc.",
      Position: 4,
      BNL_MDT: 0,
      BNL_TYD: -449,
      MMV: 33444,
      EPD$: 654),
  GridData(
      Hierarchy: "CAPITALSUNNINGS",
      Position: 4,
      BNL_MDT: 0,
      BNL_TYD: -449,
      MMV: 33444,
      EPD$: 654),
];

class SampleData {
  String hiearchy;
  double pos;
  double bNLMDT;
  double bNLTYD;
  double mMV;
  double ePD;

  SampleData(
      {this.hiearchy, this.pos, this.bNLMDT, this.bNLTYD, this.mMV, this.ePD});

  SampleData.fromJson(Map<String, dynamic> json) {
    hiearchy = json['Hiearchy'];
    pos = json['Pos'];
    bNLMDT = json['BNLMDT'];
    bNLTYD = json['BNLTYD'];
    mMV = json['MMV'];
    ePD = json['EPD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hiearchy'] = this.hiearchy;
    data['Pos'] = this.pos;
    data['BNLMDT'] = this.bNLMDT;
    data['BNLTYD'] = this.bNLTYD;
    data['MMV'] = this.mMV;
    data['EPD'] = this.ePD;
    return data;
  }
}

final String jsonSample =
    '[{"Hiearchy":"Capital Trust, Inc.","Pos":-5504397.0999,"BNLMDT":4541942.3117,"BNLTYD":-6412865.3461,"MMV":6268940.2463,"EPD":5582295.5627},'
    '{"Hiearchy":"Commerce Union Bancshares, Inc.","Pos":3333637.5324,"BNLMDT":-2421640.9077,"BNLTYD":-7485936.936,"MMV":-1640833.8788,"EPD":2276000.4794},'
    '{"Hiearchy":"National Instruments Corporation","Pos":-8528154.7479,"BNLMDT":-301358.3215,"BNLTYD":7335940.5987,"MMV":8324928.1209,"EPD":-5468727.28},'
    '{"Hiearchy":"Woodward, Inc.","Pos":-1049056.8052,"BNLMDT":-8523392.7486,"BNLTYD":-9652112.5973,"MMV":-6770010.9561,"EPD":-9671632.7946},'
    '{"Hiearchy":"WisdomTree Japan Hedged SmallCap Equity Fund","Pos":7994012.0056,"BNLMDT":1043642.5999,"BNLTYD":2562390.0518,"MMV":-1637666.7912,"EPD":3996105.2648},'
    '{"Hiearchy":"Regeneron Pharmaceuticals, Inc.","Pos":-808350.315,"BNLMDT":4649948.9451,"BNLTYD":-4093085.537,"MMV":-8897660.3614,"EPD":-9936103.4103},'
    '{"Hiearchy":"Home Bancorp, Inc.","Pos":-6932640.052,"BNLMDT":5118482.5683,"BNLTYD":-1088196.1759,"MMV":2801485.3296,"EPD":8697574.5814},'
    '{"Hiearchy":"On Deck Capital, Inc.","Pos":9384375.5957,"BNLMDT":-2654485.5962,"BNLTYD":-7049454.7939,"MMV":-7879656.4729,"EPD":-9687509.3205},'
    '{"Hiearchy":"Ryerson Holding Corporation","Pos":-9861828.4177,"BNLMDT":1049283.0264,"BNLTYD":4856451.2043,"MMV":-788546.4308,"EPD":1510340.1304},'
    '{"Hiearchy":"V.F. Corporation","Pos":-7005422.7823,"BNLMDT":1027852.3971,"BNLTYD":-3279389.0225,"MMV":2327328.0514,"EPD":-7510814.5618},'
    '{"Hiearchy":"LiNiu Technology Group","Pos":-9319321.0622,"BNLMDT":-2542470.9872,"BNLTYD":-9285360.8624,"MMV":8277293.8622,"EPD":8833514.0929},'
    '{"Hiearchy":"Heat Biologics, Inc.","Pos":7626556.5443,"BNLMDT":-1033083.5505,"BNLTYD":3625945.0714,"MMV":9765308.0095,"EPD":-8152557.1445},'
    '{"Hiearchy":"Ferrari N.V.","Pos":-5539683.4216,"BNLMDT":7111696.1396,"BNLTYD":5775503.8336,"MMV":-9468276.3873,"EPD":-9592779.5223},'
    '{"Hiearchy":"Novo Nordisk A/S","Pos":1575583.1319,"BNLMDT":3567527.4484,"BNLTYD":7546453.583,"MMV":-1044040.4823,"EPD":960324.045},'
    '{"Hiearchy":"National American University Holdings, Inc.","Pos":6761422.1012,"BNLMDT":7334706.6486,"BNLTYD":-1001277.7685,"MMV":7113397.3617,"EPD":6497098.161},'
    '{"Hiearchy":"Kennametal Inc.","Pos":3331327.8631,"BNLMDT":-7692510.7467,"BNLTYD":-1450470.2973,"MMV":8974538.1156,"EPD":1002745.3285},'
    '{"Hiearchy":"Verizon Communications Inc.","Pos":7777983.9241,"BNLMDT":9987785.502,"BNLTYD":-2912122.4671,"MMV":2333875.8347,"EPD":-4479598.646},'
    '{"Hiearchy":"Ryerson Holding Corporation","Pos":-3277492.0923,"BNLMDT":8282400.7948,"BNLTYD":5036748.8895,"MMV":5212799.5548,"EPD":-1300229.7488},'
    '{"Hiearchy":"Midland States Bancorp, Inc.","Pos":5845912.4858,"BNLMDT":1354159.2585,"BNLTYD":2753875.166,"MMV":-6634822.1031,"EPD":4635272.5902},'
    '{"Hiearchy":"Niagara Mohawk Holdings, Inc.","Pos":6512259.3315,"BNLMDT":-5976226.4836,"BNLTYD":-457601.0819,"MMV":8946129.0992,"EPD":-8161549.3771},'
    '{"Hiearchy":"W&T Offshore, Inc.","Pos":-1306985.0558,"BNLMDT":-9003189.7361,"BNLTYD":4713135.0817,"MMV":4861885.6944,"EPD":8367732.9326},'
    '{"Hiearchy":"CRISPR Therapeutics AG","Pos":8618521.0018,"BNLMDT":-5923844.6538,"BNLTYD":-5858299.1239,"MMV":-5665718.7025,"EPD":6087450.7757},'
    '{"Hiearchy":"Jupai Holdings Limited","Pos":5634864.5956,"BNLMDT":-8295368.3366,"BNLTYD":2266262.535,"MMV":-1153025.2199,"EPD":-6164219.495},'
    '{"Hiearchy":"Lincoln National Corporation","Pos":7464571.7325,"BNLMDT":1899464.3969,"BNLTYD":-2932277.154,"MMV":9319058.4517,"EPD":9789177.0199},'
    '{"Hiearchy":"Baker Hughes Incorporated","Pos":2538933.0968,"BNLMDT":6370454.1789,"BNLTYD":-2390739.876,"MMV":7847320.5517,"EPD":-8005178.7006},'
    '{"Hiearchy":"United States Cellular Corporation","Pos":2031751.1483,"BNLMDT":-7897901.5415,"BNLTYD":-5144772.5634,"MMV":-1046330.5501,"EPD":388554.6692},'
    '{"Hiearchy":"Hersha Hospitality Trust","Pos":-8898212.8124,"BNLMDT":7085442.9241,"BNLTYD":-6922284.0575,"MMV":-4038070.1336,"EPD":4975714.3515},'
    '{"Hiearchy":"Citizens Community Bancorp, Inc.","Pos":-1911775.313,"BNLMDT":-1397986.7733,"BNLTYD":753151.9203,"MMV":8861708.6125,"EPD":-6711047.3171},'
    '{"Hiearchy":"Midatech Pharma PLC","Pos":-1792881.4006,"BNLMDT":6005112.061,"BNLTYD":-2121051.3751,"MMV":9697792.3905,"EPD":9578643.8227},'
    '{"Hiearchy":"Wheeler Real Estate Investment Trust, Inc.","Pos":3876056.9861,"BNLMDT":-8596146.1311,"BNLTYD":8880148.6232,"MMV":-9440266.0702,"EPD":-6736341.8013},'
    '{"Hiearchy":"Fifth Street Finance Corp.","Pos":6658037.9204,"BNLMDT":-8480188.9007,"BNLTYD":-2856491.754,"MMV":-5483751.0426,"EPD":9721802.946},'
    '{"Hiearchy":"Resource Capital Corp.","Pos":5727924.4664,"BNLMDT":-9178747.0727,"BNLTYD":-7606223.9634,"MMV":-9511978.0676,"EPD":-8684812.9177},'
    '{"Hiearchy":"Investar Holding Corporation","Pos":-7936037.5619,"BNLMDT":-4989931.1062,"BNLTYD":-982112.1818,"MMV":2877450.1867,"EPD":-4668925.6971},'
    '{"Hiearchy":"Hersha Hospitality Trust","Pos":5744324.5314,"BNLMDT":-7155556.9514,"BNLTYD":2896567.3452,"MMV":1526853.5113,"EPD":-8718899.0556},'
    '{"Hiearchy":"Adobe Systems Incorporated","Pos":-315347.5389,"BNLMDT":6600319.1776,"BNLTYD":587273.7797,"MMV":5659370.2291,"EPD":-9547126.2471},'
    '{"Hiearchy":"CBL & Associates Properties, Inc.","Pos":-9960431.5192,"BNLMDT":-8190870.7227,"BNLTYD":4037327.1671,"MMV":-2353686.531,"EPD":2459100.0254},'
    '{"Hiearchy":"Wintrust Financial Corporation","Pos":-7988264.1107,"BNLMDT":6438204.9656,"BNLTYD":7206930.3622,"MMV":7229315.5869,"EPD":9682789.4698},'
    '{"Hiearchy":"Investors Title Company","Pos":-1612816.2164,"BNLMDT":5433050.7458,"BNLTYD":-6229712.6601,"MMV":7612386.1782,"EPD":9538488.7882},'
    '{"Hiearchy":"Toll Brothers Inc.","Pos":-4685810.7698,"BNLMDT":2235868.0619,"BNLTYD":7703034.3089,"MMV":5519842.4724,"EPD":-5920947.3134},'
    '{"Hiearchy":"United Security Bancshares","Pos":-6831695.4907,"BNLMDT":8940300.6463,"BNLTYD":8936572.2226,"MMV":2359754.6087,"EPD":5125096.4973},'
    '{"Hiearchy":"Uranium Resources, Inc.","Pos":2804316.8937,"BNLMDT":-8868622.2233,"BNLTYD":-3045359.3929,"MMV":9836047.5403,"EPD":7967263.1945},'
    '{"Hiearchy":"Otelco Inc.","Pos":3942929.1238,"BNLMDT":-8173114.4593,"BNLTYD":-3161728.5469,"MMV":-3940657.4778,"EPD":5540535.3653},'
    '{"Hiearchy":"DaVita Inc.","Pos":-4494433.332,"BNLMDT":8219304.9478,"BNLTYD":6701215.5742,"MMV":-8698867.3335,"EPD":-948084.5476},'
    '{"Hiearchy":"Summit Therapeutics plc","Pos":3876742.098,"BNLMDT":-5004642.2695,"BNLTYD":1534696.3135,"MMV":4334598.068,"EPD":3437356.6516},'
    '{"Hiearchy":"Nuance Communications, Inc.","Pos":1330829.5863,"BNLMDT":7289166.9074,"BNLTYD":4039552.4646,"MMV":3192801.8371,"EPD":97870.0},'
    '{"Hiearchy":"Varonis Systems, Inc.","Pos":-1021198.1516,"BNLMDT":-1884506.4852,"BNLTYD":2367657.3738,"MMV":-2577146.9378,"EPD":1944763.8892},'
    '{"Hiearchy":"Fidus Investment Corporation","Pos":9328124.6818,"BNLMDT":9408385.8482,"BNLTYD":-325403.1026,"MMV":3243610.515,"EPD":5877117.6336},'
    '{"Hiearchy":"Entergy Arkansas, Inc.","Pos":-4337375.2245,"BNLMDT":-1704031.7859,"BNLTYD":8004138.8346,"MMV":-6562092.2688,"EPD":5460601.167},'
    '{"Hiearchy":"J & J Snack Foods Corp.","Pos":9876017.8494,"BNLMDT":-8185186.7279,"BNLTYD":-7874520.5132,"MMV":8610881.4074,"EPD":-5504457.566},'
    '{"Hiearchy":"Capstone Turbine Corporation","Pos":-9968538.0663,"BNLMDT":-7497466.1193,"BNLTYD":-5331284.778,"MMV":5657514.652,"EPD":5692362.6703},'
    '{"Hiearchy":"Capital One Financial Corporation","Pos":-9019813.294,"BNLMDT":5511814.6683,"BNLTYD":8762862.6184,"MMV":618371.1665,"EPD":-2207048.4742},'
    '{"Hiearchy":"IF Bancorp, Inc.","Pos":-3400746.6166,"BNLMDT":5791997.5441,"BNLTYD":-8834934.2559,"MMV":4249773.6006,"EPD":-7884370.5341},'
    '{"Hiearchy":"Texas Capital Bancshares, Inc.","Pos":-6020253.8267,"BNLMDT":-7453979.94,"BNLTYD":-3606867.3639,"MMV":1482688.3273,"EPD":5662240.663},'
    '{"Hiearchy":"Kemper Corporation","Pos":1231842.4392,"BNLMDT":5830065.341,"BNLTYD":6033073.9522,"MMV":4596899.5023,"EPD":4892316.2494},'
    '{"Hiearchy":"Belden Inc","Pos":3833384.2456,"BNLMDT":-5393529.6691,"BNLTYD":4291180.8433,"MMV":5091763.2386,"EPD":-5248579.2376},'
    '{"Hiearchy":"WisdomTree Negative Duration High Yield Bond Fund","Pos":5045629.6992,"BNLMDT":-6513968.6873,"BNLTYD":-2454398.702,"MMV":190832.2657,"EPD":-2326677.5989},'
    '{"Hiearchy":"Mobile Mini, Inc.","Pos":-9675888.9969,"BNLMDT":9789535.0449,"BNLTYD":-1371253.8682,"MMV":806309.6415,"EPD":-502967.539},'
    '{"Hiearchy":"The Joint Corp.","Pos":-8252285.163,"BNLMDT":8491253.6835,"BNLTYD":-9771673.3097,"MMV":-8166807.7876,"EPD":4774447.6047},'
    '{"Hiearchy":"Fox Factory Holding Corp.","Pos":-7976932.5694,"BNLMDT":7276528.5347,"BNLTYD":9744524.2211,"MMV":8898839.6433,"EPD":-7462198.9386},'
    '{"Hiearchy":"Rocky Brands, Inc.","Pos":8192631.3149,"BNLMDT":649157.9095,"BNLTYD":3337996.2781,"MMV":4528438.7437,"EPD":-8185562.4654},'
    '{"Hiearchy":"Bio-Rad Laboratories, Inc.","Pos":1587182.5844,"BNLMDT":-1523382.7922,"BNLTYD":2688761.8989,"MMV":-1439805.3613,"EPD":8560628.1237},'
    '{"Hiearchy":"Molson Coors Brewing  Company","Pos":-576409.8657,"BNLMDT":2964220.7586,"BNLTYD":-2203139.2795,"MMV":8602986.116,"EPD":-253057.1951},'
    '{"Hiearchy":"TrueBlue, Inc.","Pos":1573150.6183,"BNLMDT":-1053173.939,"BNLTYD":8660601.6595,"MMV":-3448093.1283,"EPD":-6482434.991},'
    '{"Hiearchy":"Surgery Partners, Inc.","Pos":9282949.9756,"BNLMDT":-5781774.956,"BNLTYD":-2516841.3857,"MMV":9180648.6512,"EPD":-3890454.3884},'
    '{"Hiearchy":"Voya Global Equity Dividend and Premium Opportunity Fund","Pos":3244178.1578,"BNLMDT":-9006860.5658,"BNLTYD":1677493.0792,"MMV":2205873.9267,"EPD":9631377.1046},'
    '{"Hiearchy":"Analogic Corporation","Pos":-1971007.0975,"BNLMDT":5069211.9473,"BNLTYD":1185536.9662,"MMV":9342103.3501,"EPD":-875126.3156},'
    '{"Hiearchy":"West Marine, Inc.","Pos":6313691.8089,"BNLMDT":5265500.8801,"BNLTYD":7461761.2073,"MMV":-9243023.293,"EPD":3933609.9356},'
    '{"Hiearchy":"Southern California Edison Company","Pos":1324715.4055,"BNLMDT":5631737.8385,"BNLTYD":4862956.5436,"MMV":6739658.9269,"EPD":-4888021.0549},'
    '{"Hiearchy":"Crawford & Company","Pos":513300.9489,"BNLMDT":-591156.4765,"BNLTYD":-4902075.7718,"MMV":375772.6925,"EPD":-8123332.1806},'
    '{"Hiearchy":"OceanFirst Financial Corp.","Pos":-9281297.4139,"BNLMDT":-2889723.2251,"BNLTYD":723391.7615,"MMV":2815258.9069,"EPD":-2799079.0862},'
    '{"Hiearchy":"Bankrate, Inc.","Pos":2018032.7912,"BNLMDT":840303.7634,"BNLTYD":9872518.6662,"MMV":-893545.8145,"EPD":-2903018.8251},'
    '{"Hiearchy":"Eaton vance Floating-Rate Income Plus Fund","Pos":8704422.8934,"BNLMDT":-2882060.2929,"BNLTYD":908576.1903,"MMV":-1476909.0603,"EPD":-189962.0081},'
    '{"Hiearchy":"Mattel, Inc.","Pos":8331792.4651,"BNLMDT":1626013.3548,"BNLTYD":4391753.9448,"MMV":-1256395.9106,"EPD":-1583664.7452},'
    '{"Hiearchy":"Fidelity National Information Services, Inc.","Pos":-4414998.1794,"BNLMDT":-1654599.9902,"BNLTYD":-1936281.3818,"MMV":1500046.629,"EPD":-1986292.7147},'
    '{"Hiearchy":"Neff Corporation","Pos":-747517.3751,"BNLMDT":6270350.7448,"BNLTYD":912597.588,"MMV":5970739.219,"EPD":9247740.4813},'
    '{"Hiearchy":"Opko Health, Inc.","Pos":5699245.9769,"BNLMDT":4600341.6559,"BNLTYD":520045.7503,"MMV":9973966.1335,"EPD":-4594426.8075},'
    '{"Hiearchy":"Brooks Automation, Inc.","Pos":429050.772,"BNLMDT":9012583.782,"BNLTYD":-1674445.1664,"MMV":-8447699.7471,"EPD":-604111.4459},'
    '{"Hiearchy":"Hillenbrand Inc","Pos":3867202.8618,"BNLMDT":-839781.2612,"BNLTYD":375857.1635,"MMV":-4357570.8935,"EPD":1466976.3193},'
    '{"Hiearchy":"Intersect ENT, Inc.","Pos":-1294575.428,"BNLMDT":-9361966.8041,"BNLTYD":-245018.2707,"MMV":-4303678.6766,"EPD":-8689743.9963},'
    '{"Hiearchy":"Janus Henderson SG Global Quality Income ETF","Pos":-7106440.7712,"BNLMDT":-7474153.7151,"BNLTYD":-5563656.3172,"MMV":-7036145.9999,"EPD":2549997.0986},'
    '{"Hiearchy":"SenesTech, Inc.","Pos":7393695.2853,"BNLMDT":3801896.1794,"BNLTYD":-9072535.4408,"MMV":-469640.0844,"EPD":300473.6543},'
    '{"Hiearchy":"Masimo Corporation","Pos":8522830.9365,"BNLMDT":646942.1306,"BNLTYD":7802370.5673,"MMV":2739284.9558,"EPD":-1035353.4838},'
    '{"Hiearchy":"Semiconductor  Manufacturing International Corporation","Pos":3792462.8344,"BNLMDT":1218209.8885,"BNLTYD":-4308259.7204,"MMV":-7703716.0899,"EPD":-5521154.0673},'
    '{"Hiearchy":"Cellectar Biosciences, Inc.","Pos":-6368747.5825,"BNLMDT":2805919.5205,"BNLTYD":-6185696.633,"MMV":-5957614.0006,"EPD":6926376.3492},'
    '{"Hiearchy":"South Jersey Industries, Inc.","Pos":-5508220.4968,"BNLMDT":-4062735.837,"BNLTYD":-9590762.8078,"MMV":8858398.1638,"EPD":-1481842.5027},'
    '{"Hiearchy":"PowerShares Water Resources Portfolio","Pos":-2286472.2686,"BNLMDT":8406049.9144,"BNLTYD":560171.7191,"MMV":2404069.0092,"EPD":6992904.6927},'
    '{"Hiearchy":"LifePoint Health, Inc.","Pos":2616526.4711,"BNLMDT":3920623.253,"BNLTYD":4825228.44,"MMV":1874328.3273,"EPD":-6432593.1874},'
    '{"Hiearchy":"Aradigm Corporation","Pos":1405440.2606,"BNLMDT":4409470.3311,"BNLTYD":-2685809.5819,"MMV":2641265.3678,"EPD":9193918.4684},'
    '{"Hiearchy":"Boston Beer Company, Inc. (The)","Pos":-7173105.9401,"BNLMDT":-3845872.6025,"BNLTYD":-1733591.6213,"MMV":-5952638.7346,"EPD":8980878.2432},'
    '{"Hiearchy":"Berkshire Hathaway Inc.","Pos":313850.6439,"BNLMDT":3134082.8517,"BNLTYD":4916867.028,"MMV":-1420124.5578,"EPD":-3438113.5372},'
    '{"Hiearchy":"Principal Millennials Index ETF","Pos":4052755.2156,"BNLMDT":5542611.8302,"BNLTYD":8160357.7157,"MMV":-3540853.5822,"EPD":-8251205.115},'
    '{"Hiearchy":"AAC Holdings, Inc.","Pos":5801956.9731,"BNLMDT":8583008.4669,"BNLTYD":5755001.4628,"MMV":-399650.7008,"EPD":-5879656.1882},'
    '{"Hiearchy":"Southern California Edison Company","Pos":-1870162.3352,"BNLMDT":-4094677.096,"BNLTYD":-8284611.5012,"MMV":-7409186.5217,"EPD":4041550.1255},'
    '{"Hiearchy":"FIRST REPUBLIC BANK","Pos":9800414.861,"BNLMDT":9029170.9683,"BNLTYD":-3868895.4875,"MMV":4683242.4878,"EPD":-819055.1589},'
    '{"Hiearchy":"Yield10 Bioscience, Inc.","Pos":4696045.3587,"BNLMDT":902608.7577,"BNLTYD":-8641584.9033,"MMV":8134501.4635,"EPD":-9086594.1121},'
    '{"Hiearchy":"TCP Capital Corp.","Pos":4580247.4095,"BNLMDT":993710.5282,"BNLTYD":-2853477.871,"MMV":8854199.1996,"EPD":7784376.6678},'
    '{"Hiearchy":"Madison Covered Call & Equity Strategy Fund","Pos":247776.9797,"BNLMDT":5350510.6886,"BNLTYD":4548090.0069,"MMV":-4190365.4794,"EPD":-8057168.7892},'
    '{"Hiearchy":"GCP Applied Technologies Inc.","Pos":-8000288.4808,"BNLMDT":7902926.9547,"BNLTYD":-6452932.37,"MMV":-4385327.8462,"EPD":-751262.1397},'
    '{"Hiearchy":"Griffin Industrial Realty, Inc.","Pos":3529446.1867,"BNLMDT":6336582.808,"BNLTYD":4204392.1133,"MMV":2728186.3899,"EPD":1752470.7439},'
    '{"Hiearchy":"Kite Realty Group Trust","Pos":-4755640.0302,"BNLMDT":-6088098.4579,"BNLTYD":-1094945.8854,"MMV":3726856.9815,"EPD":-9422451.019}]';
