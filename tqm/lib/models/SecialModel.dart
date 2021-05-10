class SocialModel{
   String id;
   String nameSite;
   String url ;
   String icone ;
   String catalog ;

   SocialModel(
      {this.id,this.nameSite,this.url,this.icone,this.catalog, });


factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      id: json['id'],
     
      nameSite: json['name'],
      url:json['city'],
      icone:json['country'],
      catalog:json['address'],
     
    );
  }

}
//

///////////////
///
///
///
///
///
///