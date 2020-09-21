class Product {
  var product_id;

  var item_id;
  var product_name;
  var item_description;
  var description;
  var item;
  var price;

  var sku;

  var images;
  var stock;

  var quantity;
  var food_type;

  var product_type;
  var attribute_sort_order;
  var measure_unit;

  var has_addons;

  var delivery_date;
  var track_inventory;
  var categoryName;
  var previousPrice;
  var count;

  var tax_method;
}

// import { Offer } from './offer.model';

// /**
//  * Product class
//  */
// export class Product {
//    var id;
//    var name;
//    var description;
//    var sku;
//    var price;
//    var images  = [];
//    var stock;
//    var product_type;
//    var food_type = null;
//    var attribute_sort_order;
//    var tax_class;
//    var product_addons  = {};
//    var product_variants;
//    var product_attributes ;
//    var has_addons boolean;
//    var measure_unit boolean;
//    var addon_configurations  = {};
//    var customized_details ;
//    var offers = [];
//    var defaultOffer ;
//    var inventory ;
//    var discounts  = [];
//    var discount = 0;
//    var quantity;
//    var tax_method;
//    var selected_variant;
//    var delivery_date;
//    var track_inventory boolean;
//    var categoryName?;
//    var categories?;
//    var previousPrice?;
//    var count?;

//     updateFrom(src) {
//     this.id = src.product_id ? src.product_id  src.item_id;
//     this.name = src.product_name ? src.product_name  src.item;
//     this.description = src.description ? src.description  src.item_description;
//     this.price = src.price;
//     this.sku = src.sku;
//     this.images = src.images;
//     this.stock = src.stock;
//     this.sku = src.sku;
//     this.quantity = src.quantity;
//     this.food_type = src.food_type;
//     this.product_type = src.product_type;
//     this.attribute_sort_order = src.attribute_sort_order;
//     this.measure_unit = src.measure_unit;
//     this.has_addons = (src.has_addons == 'yes') ? true  false;
//     this.delivery_date = src.delivery_date;
//     this.track_inventory = src.track_inventory;
//     this.categoryName = src.categoryName;
//     this.previousPrice=src.previousPrice;
//     this.count = src.count;
//     this.tax_method = src.tax_method;

//     if (src.tax_class != null) {
//       let tax_class =  Tax();
//       tax_class.updateFrom(src.tax_class);

//       this.tax_class = tax_class;
//     }

//     if (src.product_type == 'configurable') {

//       this.product_variants = src.product_variants.map((i) => {

//         let product_variant = new ProductVariant();
//         product_variant.updateFrom(i);

//         if (product_variant.offers != undefined && product_variant.offers.length > 0) {
//           src.offers.push(...product_variant.offers)
//         }

//         return product_variant;
//       });

//       this.product_attributes = src.product_attributes;

//     }

//     if (('product_addons' in src) && .keys(src.product_addons).length > 0) {

//       this.product_addons = src.product_addons;

//       .keys(src.product_addons).map((value) => {

//         let attribute  = {};

//         src.product_addons[+value].map((i, idx) => {
//           attribute[idx] = { 'item' i.attribute_value, 'price' i.price, 'is_default' i.is_default };
//         });

//         this.product_addons[+value] = attribute;

//         this.addon_configurations = src.addon_configurations;
//         if (this.addon_configurations != undefined)
//           this.addon_configurations['validate'] = true;

//       });
//     }

//     if (('inventory' in src) && src.inventory !== null) {

//       this.inventory = src.inventory;
//     }

//     this.offers = src.offers;

//     if (this.offers != undefined && this.offers.length > 0) {

//       //const offerService = new OfferService();
//       this.defaultOffer = OfferService.getDefaultOffer(src.offers);
//     }
//   }
// }

// /**
//  * Tax class
//  */
// export class {
//    tax_class_id;
//    tax_class_name;
//    tax_rules TaxRule[];

//    updateFrom(src) void {

//     this.tax_class_id = src.tax_class_id;
//     this.tax_class_name = src.tax_class_name;
//     this.tax_rules = src.tax_rules.map((i) => {
//       let tax_rules = new TaxRule();
//       tax_rules.updateFrom(i);
//       return tax_rules;
//     });
//   }

// }

// /**
//  * Tax Rule class
//  */
// export class TaxRule {
//    tax_rule_id;
//    tax_rule_name;
//    rate;
//    rate_type;

//    updateFrom(src) void {
//     this.tax_rule_id = src.tax_rule_id;
//     this.tax_rule_name = src.rule_name;
//     this.rate = src.rate;
//     this.rate_type = src.rate_type;
//   }

// }

// /**
//  * Product variant class
//  */
// export class ProductVariant {
//    product_variant_id;
//    variant_name;
//    variant_sku;
//    variant_attributes;
//    price;
//    status;
//    product_addons  = {};
//    addon_configurations  = {};
//    has_addons;
//    offers <Offer>;
//    defaultOffer Offer;

//    updateFrom(src) void {
//     this.product_variant_id = src.product_variant_id;
//     this.variant_name = src.variant_name;
//     this.variant_sku = src.sku;
//     this.price = src.price;
//     this.status = src.status;
//     this.variant_attributes = src.variant_attributes;
//     this.has_addons = src.has_addons;
//     src.product_addons = (src.product_addons == []) ? {}  src.product_addons;

//     if (('product_addons' in src) && .keys(src.product_addons).length > 0) {

//       this.product_addons = src.product_addons;

//       .keys(src.product_addons).map((value) => {

//         let attribute  = {};

//         src.product_addons[value].map((i, idx) => {
//           attribute[idx] = { 'item' i.attribute_value, 'price' i.price, 'is_default' i.is_default };
//         });

//         this.product_addons[value] = attribute;

//         this.addon_configurations = src.addon_configurations;
//         if (this.addon_configurations != undefined)
//           this.addon_configurations['validate'] = true;
//       });
//     }

//     this.offers = src.offers;

//     if (this.offers != undefined && this.offers.length > 0) {
//       this.defaultOffer = OfferService.getDefaultOffer(src.offers);
//     }

//   }
// }
