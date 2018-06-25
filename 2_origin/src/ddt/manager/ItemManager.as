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
      
      public static function fill(item:InventoryItemInfo) : InventoryItemInfo
      {
         var t:ItemTemplateInfo = ItemManager.Instance.getTemplateById(item.TemplateID);
         ObjectUtils.copyProperties(item,t);
         return item;
      }
      
      public static function firFill(item:InventoryItemInfo) : InventoryItemInfo
      {
         var t:ItemTemplateInfo = ItemManager.Instance.getTemplateById(item.TemplateID);
         ObjectUtils.copyProperties(t,item);
         return item;
      }
      
      public static function fillByID(templateID:int) : InventoryItemInfo
      {
         var item:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(item,ItemManager.Instance.getTemplateById(templateID));
         return item;
      }
      
      public static function copy(item:InventoryItemInfo) : InventoryItemInfo
      {
         var t:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(t,item);
         return t;
      }
      
      public static function get Instance() : ItemManager
      {
         if(_instance == null)
         {
            _instance = new ItemManager();
         }
         return _instance;
      }
      
      public function setupGoodsTemplates(analyzer:ItemTempleteAnalyzer) : void
      {
         _goodsTemplates = analyzer.list;
      }
      
      public function setupGoodsCategory(analyzer:GoodCategoryAnalyzer) : void
      {
         _categorys = analyzer.list;
      }
      
      public function addGoodsTemplates(analyzer:ItemTempleteAnalyzer) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = analyzer.list;
         for each(var obj in analyzer.list)
         {
            if(!_goodsTemplates.hasKey(obj.TemplateID))
            {
               _goodsTemplates.add(obj.TemplateID,obj);
            }
            else
            {
               _goodsTemplates[obj.TemplateID] = obj;
            }
         }
      }
      
      public function getPropByTypeAndPro() : Array
      {
         var result:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _goodsTemplates;
         for each(var info in _goodsTemplates)
         {
            if(info.CategoryID == 10 && info.Property8 == "1")
            {
               result.push(info);
            }
         }
         return result;
      }
      
      public function getMinesPropByPro() : Array
      {
         var result:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _goodsTemplates;
         for each(var info in _goodsTemplates)
         {
            if(info.CategoryID == 81)
            {
               result.push(info);
            }
         }
         return result;
      }
      
      public function getTemplateById(templateId:int) : ItemTemplateInfo
      {
         return _goodsTemplates[templateId];
      }
      
      public function get categorys() : Vector.<CateCoryInfo>
      {
         return _categorys.slice(0);
      }
      
      public function setupSuitTemplates(analyzer:SuitTempleteAnalyzer) : void
      {
         _SuitTemplates = analyzer.list;
      }
      
      public function setupEquipSuitTemplates(analyzer:EquipSuitTempleteAnalyzer) : void
      {
         _EquipSuit = analyzer.dic;
         _EquipTemplates = analyzer.data;
      }
      
      public function get EquipSuit() : Dictionary
      {
         return _EquipSuit;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerinfo;
      }
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         _playerinfo = value;
      }
      
      public function getSuitTemplateByID(key:String) : SuitTemplateInfo
      {
         return _SuitTemplates[key];
      }
      
      public function getEquipSuitbyContainEquip(name:String) : EquipSuitTemplateInfo
      {
         return _EquipTemplates[name];
      }
      
      public function get storeCateCory() : Array
      {
         return _storeCateCory;
      }
      
      public function set storeCateCory(value:Array) : void
      {
         _storeCateCory = value;
      }
      
      public function get goodsTemplates() : DictionaryData
      {
         return _goodsTemplates;
      }
      
      public function getFreeTemplateByCategoryId(categoryid:int, sex:int = 0) : ItemTemplateInfo
      {
         if(categoryid != 7)
         {
            return getTemplateById(Number(String(categoryid) + String(sex) + "01"));
         }
         return getTemplateById(Number(String(categoryid) + "00" + String(sex)));
      }
      
      public function searchGoodsNameByStr(str:String) : Array
      {
         var i:int = 0;
         var result:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _goodsTemplates;
         for each(var info in _goodsTemplates)
         {
            if(info.Name.indexOf(str) > -1)
            {
               if(result.length == 0)
               {
                  result.push(info.Name);
               }
               else
               {
                  i = 0;
                  while(i < result.length)
                  {
                     if(result[i] != info.Name)
                     {
                        if(i == result.length - 1)
                        {
                           result.push(info.Name);
                        }
                        i++;
                        continue;
                     }
                     break;
                  }
               }
               continue;
            }
         }
         return result;
      }
   }
}
