import 'package:seo_web/feature/data/model/cart/cart_dto.dart';
import 'package:seo_web/feature/data/model/product/mapper/mapper.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';
import 'package:seo_web/feature/domain/entity/cart_offer_entity.dart';

CartEntity dtoToCartMapper(CartDto dto) {
  return CartEntity(
    price: dto.price,
    offers: _mapDtoProductsToOffers(dto.products),
  );
}

List<CartOfferEntity> _mapDtoProductsToOffers(List<ProductDto> dtoProducts) {
  final offerCounts = <int, int>{};

  for (var index = 0; index < dtoProducts.length; index++) {
    final dto = dtoProducts[index];
    final id = dto.id;
    final count = offerCounts[id] ?? 0;
    offerCounts[id] = count + 1;
  }

  List<CartOfferEntity> offers = [];

  final productsUnique = dtoProducts.toSet().toList();

  for (var index = 0; index < productsUnique.length; index++) {
    final dto = productsUnique[index];
    final offer = CartOfferEntity(
      id: dto.id,
      count: offerCounts[dto.id] ?? 0,
      product: dtoToProductMapper(dto),
    );
    offers.add(offer);
  }

  return offers;
}

List<CartOfferEntity> recalculateOffers(List<CartOfferEntity> offerEntities) {
  final offerCounts = <int, int>{};

  for (var index = 0; index < offerEntities.length; index++) {
    final offer = offerEntities[index];
    final id = offer.id;
    final count = offerCounts[id] ?? 0;
    offerCounts[id] = count + 1;
  }

  List<CartOfferEntity> offers = [];

  final offersUnique = offerEntities.toSet().toList();

  for (var index = 0; index < offersUnique.length; index++) {
    final offerEntity = offersUnique[index];
    final offer = CartOfferEntity(
      id: offerEntity.id,
      count: offerCounts[offerEntity.id] ?? 0,
      product: offerEntity.product,
    );
    offers.add(offer);
  }

  return offers;
}
