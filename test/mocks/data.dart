final authStub = {
  "access_token": "accessToken",
  "request_token": "requestToken",
};

final List<Map<String, dynamic>> productStub = [
  {
    "id": 2,
    "image":
        "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "description":
        '''Slim-fitting style, contrast raglan long sleeve, three-button henley placket,
              light weight & soft fabric for breathable and comfortable wearing. And Solid 
             stitched shirts with round neck made for durability and a great fit for casual
              fashion wear and diehard baseball fans. The Henley style round neckline inclu
             des a three-button placket.''',
    "title": "Mens Casual Premium Slim Fit T-Shirts ",
    "price": 22.3,
    "category": "men's clothing"
  },
  {
    "id": 3,
    "image": "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "description":
        '''great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions
             , such as working, hiking, camping, mountain/rock climbing, cycling, traveling
              or other outdoors. Good gift choice for you or your family member. A warm hea
             rted love to Father, husband or son in this thanksgiving or Christmas Day.''',
    "title": "Mens Cotton Jacket",
    "price": 55.99,
    "category": "men's clothing"
  }
];

final productAddedStub = [
  {
    "id": 2,
    "image":
        "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "description":
        '''Slim-fitting style, contrast raglan long sleeve, three-button henley placket,
              light weight & soft fabric for breathable and comfortable wearing. And Solid 
             stitched shirts with round neck made for durability and a great fit for casual
              fashion wear and diehard baseball fans. The Henley style round neckline inclu
             des a three-button placket.''',
    "title": "Mens Casual Premium Slim Fit T-Shirts ",
    "price": 22.3,
    "category": "men's clothing"
  },
  {
    "id": 3,
    "image": "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "description":
        '''great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions
             , such as working, hiking, camping, mountain/rock climbing, cycling, traveling
              or other outdoors. Good gift choice for you or your family member. A warm hea
             rted love to Father, husband or son in this thanksgiving or Christmas Day.''',
    "title": "Mens Cotton Jacket",
    "price": 55.99,
    "category": "men's clothing"
  },
  {
    "id": 1,
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "description":
        '''Your perfect pack for everyday use and walks in the forest. Stash your laptop
              (up to 15 inches) in the padded sleeve, your everyday
''',
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "category": "men's clothing"
  },
];

final cartStub = {
  "id": 1,
  "price": '100',
  "products": productStub,
};

final cartAddStub = {
  "id": 1,
  "price": '100',
  "products": productAddedStub,
};
