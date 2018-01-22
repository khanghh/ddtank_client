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
      
      public function ItemManager()
      {
         super();
      }
      
      public static function fill(param1:InventoryItemInfo) : InventoryItemInfo
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.TemplateID);
         ObjectUtils.copyProperties(param1,_loc2_);
         return param1;
      }
      
      public static function firFill(param1:InventoryItemInfo) : InventoryItemInfo
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.TemplateID);
         ObjectUtils.copyProperties(_loc2_,param1);
         return param1;
      }
      
      public static function fillByID(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,ItemManager.Instance.getTemplateById(param1));
         return _loc2_;
      }
      
      public static function copy(param1:InventoryItemInfo) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,param1);
         return _loc2_;
      }
      
      public static function get Instance() : ItemManager
      {
         if(_instance == null)
         {
            _instance = new ItemManager();
         }
         return _instance;
      }
      
      public function setupGoodsTemplates(param1:ItemTempleteAnalyzer) : void
      {
         _goodsTemplates = param1.list;
      }
      
      public function setupGoodsCategory(param1:GoodCategoryAnalyzer) : void
      {
         _categorys = param1.list;
      }
      
      public function addGoodsTemplates(param1:ItemTempleteAnalyzer) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.list;
         for each(var _loc2_ in param1.list)
         {
            if(!_goodsTemplates.hasKey(_loc2_.TemplateID))
            {
               _goodsTemplates.add(_loc2_.TemplateID,_loc2_);
            }
            else
            {
               _goodsTemplates[_loc2_.TemplateID] = _loc2_;
            }
         }
      }
      
      public function getPropByTypeAndPro() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _goodsTemplates;
         for each(var _loc2_ in _goodsTemplates)
         {
            if(_loc2_.CategoryID == 10 && _loc2_.Property8 == "1")
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getMinesPropByPro() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _goodsTemplates;
         for each(var _loc2_ in _goodsTemplates)
         {
            if(_loc2_.CategoryID == 81)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getTemplateById(param1:int) : ItemTemplateInfo
      {
         return _goodsTemplates[param1];
      }
      
      public function get categorys() : Vector.<CateCoryInfo>
      {
         return _categorys.slice(0);
      }
      
      public function setupSuitTemplates(param1:SuitTempleteAnalyzer) : void
      {
         _SuitTemplates = param1.list;
      }
      
      public function setupEquipSuitTemplates(param1:EquipSuitTempleteAnalyzer) : void
      {
         _EquipSuit = param1.dic;
         _EquipTemplates = param1.data;
      }
      
      public function get EquipSuit() : Dictionary
      {
         return _EquipSuit;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerinfo;
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         _playerinfo = param1;
      }
      
      public function getSuitTemplateByID(param1:String) : SuitTemplateInfo
      {
         return _SuitTemplates[param1];
      }
      
      public function getEquipSuitbyContainEquip(param1:String) : EquipSuitTemplateInfo
      {
         return _EquipTemplates[param1];
      }
      
      public function get storeCateCory() : Array
      {
         return _storeCateCory;
      }
      
      public function set storeCateCory(param1:Array) : void
      {
         _storeCateCory = param1;
      }
      
      public function get goodsTemplates() : DictionaryData
      {
         return _goodsTemplates;
      }
      
      public function getFreeTemplateByCategoryId(param1:int, param2:int = 0) : ItemTemplateInfo
      {
         if(param1 != 7)
         {
            return getTemplateById(Number(String(param1) + String(param2) + "01"));
         }
         return getTemplateById(Number(String(param1) + "00" + String(param2)));
      }
      
      public function searchGoodsNameByStr(param1:String) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _goodsTemplates;
         for each(var _loc4_ in _goodsTemplates)
         {
            if(_loc4_.Name.indexOf(param1) > -1)
            {
               if(_loc2_.length == 0)
               {
                  _loc2_.push(_loc4_.Name);
               }
               else
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.length)
                  {
                     if(_loc2_[_loc3_] != _loc4_.Name)
                     {
                        if(_loc3_ == _loc2_.length - 1)
                        {
                           _loc2_.push(_loc4_.Name);
                        }
                        _loc3_++;
                        continue;
                     }
                     break;
                  }
               }
               continue;
            }
         }
         return _loc2_;
      }
   }
}
