class DocsModel{
   String id;
   String name;
   String path ;
   String typefile ;
   String catalog ;

   DocsModel(
      {this.id,this.name,this.path,this.typefile,this.catalog, });


factory DocsModel.fromJson(Map<String, dynamic> json) {
    return DocsModel(
      id: json['id'].toString(),
     
      name: json['doc'],
      path:json['doc'],
      typefile:json['type'],
      catalog:json['emp'],
     
    );
  }

}
//


////////////////////////////////
///
///
///
///
///
///
///
///
///
///
///
///
























