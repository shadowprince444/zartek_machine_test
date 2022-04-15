class RestaurantMenuModel {
  RestaurantMenuModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.tableId,
    required this.tableName,
    required this.branchName,
    required this.nexturl,
    required this.tableMenuList,
  });
  late final String restaurantId;
  late final String restaurantName;
  late final String restaurantImage;
  late final String tableId;
  late final String tableName;
  late final String branchName;
  late final String nexturl;
  late final List<TableMenuList> tableMenuList;

  RestaurantMenuModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    restaurantImage = json['restaurant_image'];
    tableId = json['table_id'];
    tableName = json['table_name'];
    branchName = json['branch_name'];
    nexturl = json['nexturl'];
    tableMenuList = List.from(json['table_menu_list']).map((e) => TableMenuList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['restaurant_id'] = restaurantId;
    _data['restaurant_name'] = restaurantName;
    _data['restaurant_image'] = restaurantImage;
    _data['table_id'] = tableId;
    _data['table_name'] = tableName;
    _data['branch_name'] = branchName;
    _data['nexturl'] = nexturl;
    _data['table_menu_list'] = tableMenuList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TableMenuList {
  TableMenuList({
    required this.menuCategory,
    required this.menuCategoryId,
    required this.menuCategoryImage,
    required this.nexturl,
    required this.categoryDishes,
  });
  late final String menuCategory;
  late final String menuCategoryId;
  late final String menuCategoryImage;
  late final String nexturl;
  late final List<CategoryDishes> categoryDishes;

  TableMenuList.fromJson(Map<String, dynamic> json) {
    menuCategory = json['menu_category'];
    menuCategoryId = json['menu_category_id'];
    menuCategoryImage = json['menu_category_image'];
    nexturl = json['nexturl'];
    categoryDishes = List.from(json['category_dishes']).map((e) => CategoryDishes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['menu_category'] = menuCategory;
    _data['menu_category_id'] = menuCategoryId;
    _data['menu_category_image'] = menuCategoryImage;
    _data['nexturl'] = nexturl;
    _data['category_dishes'] = categoryDishes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CategoryDishes {
  CategoryDishes({
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.dishImage,
    required this.dishCurrency,
    required this.dishCalories,
    required this.dishDescription,
    required this.dishAvailability,
    required this.dishType,
    required this.nexturl,
    required this.addonCat,
  });
  late final String dishId;
  late final String dishName;
  late final double? dishPrice;
  late final String dishImage;
  late final String dishCurrency;
  late final int dishCalories;
  late final String dishDescription;
  late final bool dishAvailability;
  late final int dishType;
  late final String nexturl;
  late final List<AddonCat> addonCat;

  CategoryDishes.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishPrice = json['dish_price'];
    dishImage = json['dish_image'];
    dishCurrency = json['dish_currency'];
    dishCalories = json['dish_calories'];
    dishDescription = json['dish_description'];
    dishAvailability = json['dish_Availability'];
    dishType = json['dish_Type'];
    nexturl = json['nexturl'];
    addonCat = List.from(json['addonCat']).map((e) => AddonCat.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dish_id'] = dishId;
    _data['dish_name'] = dishName;
    _data['dish_price'] = dishPrice;
    _data['dish_image'] = dishImage;
    _data['dish_currency'] = dishCurrency;
    _data['dish_calories'] = dishCalories;
    _data['dish_description'] = dishDescription;
    _data['dish_Availability'] = dishAvailability;
    _data['dish_Type'] = dishType;
    _data['nexturl'] = nexturl;
    _data['addonCat'] = addonCat.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AddonCat {
  AddonCat({
    required this.addonCategory,
    required this.addonCategoryId,
    required this.addonSelection,
    required this.nexturl,
    required this.addons,
  });
  late final String addonCategory;
  late final String addonCategoryId;
  late final int addonSelection;
  late final String nexturl;
  late final List<Addons> addons;

  AddonCat.fromJson(Map<String, dynamic> json) {
    addonCategory = json['addon_category'];
    addonCategoryId = json['addon_category_id'];
    addonSelection = json['addon_selection'];
    nexturl = json['nexturl'];
    addons = List.from(json['addons']).map((e) => Addons.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addon_category'] = addonCategory;
    _data['addon_category_id'] = addonCategoryId;
    _data['addon_selection'] = addonSelection;
    _data['nexturl'] = nexturl;
    _data['addons'] = addons.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Addons {
  Addons({
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.dishImage,
    required this.dishCurrency,
    required this.dishCalories,
    required this.dishDescription,
    required this.dishAvailability,
    required this.dishType,
  });
  late final String dishId;
  late final String dishName;
  late final int dishPrice;
  late final String dishImage;
  late final String dishCurrency;
  late final int dishCalories;
  late final String dishDescription;
  late final bool dishAvailability;
  late final int dishType;

  Addons.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishPrice = json['dish_price'];
    dishImage = json['dish_image'];
    dishCurrency = json['dish_currency'];
    dishCalories = json['dish_calories'];
    dishDescription = json['dish_description'];
    dishAvailability = json['dish_Availability'];
    dishType = json['dish_Type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dish_id'] = dishId;
    _data['dish_name'] = dishName;
    _data['dish_price'] = dishPrice;
    _data['dish_image'] = dishImage;
    _data['dish_currency'] = dishCurrency;
    _data['dish_calories'] = dishCalories;
    _data['dish_description'] = dishDescription;
    _data['dish_Availability'] = dishAvailability;
    _data['dish_Type'] = dishType;
    return _data;
  }
}
