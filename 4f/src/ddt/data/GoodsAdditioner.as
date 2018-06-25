package ddt.data{   import ddt.data.analyze.GoodsAdditionAnalyer;   import flash.geom.Point;      public class GoodsAdditioner   {            private static var _instance:GoodsAdditioner;                   private var _additionArr:Array;            public function GoodsAdditioner() { super(); }
            public static function get Instance() : GoodsAdditioner { return null; }
            public function addGoodsAddition(analyzer:GoodsAdditionAnalyer) : void { }
            public function getpropertySuccessRate(ItemCatalog:int, SubCatalog:int, StrengthenLevel:int, FailtureTimes:int) : Point { return null; }
   }}