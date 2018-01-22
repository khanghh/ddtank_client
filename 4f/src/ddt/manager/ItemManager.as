package ddt.manager
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.EquipSuitTempleteAnalyzer;
   import ddt.data.analyze.GoodCategoryAnalyzer;
   import ddt.data.analyze.ItemTempleteAnalyzer;
   import ddt.data.analyze.SuitTempleteAnalyzer;
   import ddt.data.goods.CateCoryInfo;
   import ddt.data.goods.EquipSuitTemplateInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.SuitTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   [Event(name="templateReady",type="flash.events.Event")]
   public class ItemManager extends EventDispatcher
   {
      
      private static var _instance:ItemManager;
       
      
      private var _categorys:Vector.<CateCoryInfo>;
      
      private var _goodsTemplates:DictionaryData;
      
      private var _SuitTemplates:Dictionary;
      
      private var _EquipSuit:Dictionary;
      
      private var _playerinfo:PlayerInfo;
      
      private var _EquipTemplates:Dictionary;
      
      private var _storeCateCory:Array;
      
      public function ItemManager(){super();}
      
      public static function fill(param1:InventoryItemInfo) : InventoryItemInfo{return null;}
      
      public static function firFill(param1:InventoryItemInfo) : InventoryItemInfo{return null;}
      
      public static function fillByID(param1:int) : InventoryItemInfo{return null;}
      
      public static function copy(param1:InventoryItemInfo) : InventoryItemInfo{return null;}
      
      public static function get Instance() : ItemManager{return null;}
      
      public function setupGoodsTemplates(param1:ItemTempleteAnalyzer) : void{}
      
      public function setupGoodsCategory(param1:GoodCategoryAnalyzer) : void{}
      
      public function addGoodsTemplates(param1:ItemTempleteAnalyzer) : void{}
      
      public function getPropByTypeAndPro() : Array{return null;}
      
      public function getMinesPropByPro() : Array{return null;}
      
      public function getTemplateById(param1:int) : ItemTemplateInfo{return null;}
      
      public function get categorys() : Vector.<CateCoryInfo>{return null;}
      
      public function setupSuitTemplates(param1:SuitTempleteAnalyzer) : void{}
      
      public function setupEquipSuitTemplates(param1:EquipSuitTempleteAnalyzer) : void{}
      
      public function get EquipSuit() : Dictionary{return null;}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      public function getSuitTemplateByID(param1:String) : SuitTemplateInfo{return null;}
      
      public function getEquipSuitbyContainEquip(param1:String) : EquipSuitTemplateInfo{return null;}
      
      public function get storeCateCory() : Array{return null;}
      
      public function set storeCateCory(param1:Array) : void{}
      
      public function get goodsTemplates() : DictionaryData{return null;}
      
      public function getFreeTemplateByCategoryId(param1:int, param2:int = 0) : ItemTemplateInfo{return null;}
      
      public function searchGoodsNameByStr(param1:String) : Array{return null;}
   }
}
