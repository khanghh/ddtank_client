package ddt.manager{   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.EquipSuitTempleteAnalyzer;   import ddt.data.analyze.GoodCategoryAnalyzer;   import ddt.data.analyze.ItemTempleteAnalyzer;   import ddt.data.analyze.SuitTempleteAnalyzer;   import ddt.data.goods.CateCoryInfo;   import ddt.data.goods.EquipSuitTemplateInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.SuitTemplateInfo;   import ddt.data.player.PlayerInfo;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;      [Event(name="templateReady",type="flash.events.Event")]   public class ItemManager extends EventDispatcher   {            private static var _instance:ItemManager;                   private var _categorys:Vector.<CateCoryInfo>;            private var _goodsTemplates:DictionaryData;            private var _SuitTemplates:Dictionary;            private var _EquipSuit:Dictionary;            private var _playerinfo:PlayerInfo;            private var _EquipTemplates:Dictionary;            private var _storeCateCory:Array;            public function ItemManager() { super(); }
            public static function fill(item:InventoryItemInfo) : InventoryItemInfo { return null; }
            public static function firFill(item:InventoryItemInfo) : InventoryItemInfo { return null; }
            public static function fillByID(templateID:int) : InventoryItemInfo { return null; }
            public static function copy(item:InventoryItemInfo) : InventoryItemInfo { return null; }
            public static function get Instance() : ItemManager { return null; }
            public function setupGoodsTemplates(analyzer:ItemTempleteAnalyzer) : void { }
            public function setupGoodsCategory(analyzer:GoodCategoryAnalyzer) : void { }
            public function addGoodsTemplates(analyzer:ItemTempleteAnalyzer) : void { }
            public function getPropByTypeAndPro() : Array { return null; }
            public function getMinesPropByPro() : Array { return null; }
            public function getTemplateById(templateId:int) : ItemTemplateInfo { return null; }
            public function get categorys() : Vector.<CateCoryInfo> { return null; }
            public function setupSuitTemplates(analyzer:SuitTempleteAnalyzer) : void { }
            public function setupEquipSuitTemplates(analyzer:EquipSuitTempleteAnalyzer) : void { }
            public function get EquipSuit() : Dictionary { return null; }
            public function get playerInfo() : PlayerInfo { return null; }
            public function set playerInfo(value:PlayerInfo) : void { }
            public function getSuitTemplateByID(key:String) : SuitTemplateInfo { return null; }
            public function getEquipSuitbyContainEquip(name:String) : EquipSuitTemplateInfo { return null; }
            public function get storeCateCory() : Array { return null; }
            public function set storeCateCory(value:Array) : void { }
            public function get goodsTemplates() : DictionaryData { return null; }
            public function getFreeTemplateByCategoryId(categoryid:int, sex:int = 0) : ItemTemplateInfo { return null; }
            public function searchGoodsNameByStr(str:String) : Array { return null; }
   }}