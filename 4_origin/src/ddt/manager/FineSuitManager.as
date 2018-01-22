package ddt.manager
{
   import ddt.data.analyze.FineSuitAnalyze;
   import ddt.data.store.FineSuitVo;
   import road7th.data.DictionaryData;
   
   public class FineSuitManager
   {
      
      private static var _instance:FineSuitManager;
       
      
      private var _model:DictionaryData;
      
      private var _materialIDList:Array;
      
      private var _data:DictionaryData;
      
      private var propertyList:Array;
      
      private var nameList:Array;
      
      public function FineSuitManager()
      {
         propertyList = ["hp","Defence","Luck","Agility","MagicDefence","Armor"];
         nameList = LanguageMgr.GetTranslation("storeFine.effect.contentText").split(",");
         super();
      }
      
      public static function get Instance() : FineSuitManager
      {
         if(_instance == null)
         {
            _instance = new FineSuitManager();
         }
         return _instance;
      }
      
      public function setup(param1:FineSuitAnalyze) : void
      {
         _model = param1.list;
         _materialIDList = param1.materialIDList;
         _data = param1.tipsData;
      }
      
      public function getSuitVoByExp(param1:int) : FineSuitVo
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _model.length)
         {
            _loc2_ = _model[_loc3_.toString()] as FineSuitVo;
            if(param1 < _loc2_.exp)
            {
               _loc2_ = _model[(_loc3_ - 1).toString()] as FineSuitVo;
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getNextLevelSuiteVo(param1:int) : FineSuitVo
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _model.length)
         {
            _loc2_ = _model[_loc3_.toString()] as FineSuitVo;
            if(param1 < _loc2_.exp)
            {
               _loc2_ = _model[_loc3_.toString()] as FineSuitVo;
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getNextSuitVoByExp(param1:int) : FineSuitVo
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _model.length)
         {
            _loc2_ = _model[_loc3_.toString()] as FineSuitVo;
            if(param1 < _loc2_.exp)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function updateFineSuitProperty(param1:int, param2:DictionaryData) : void
      {
         var _loc3_:FineSuitVo = getFineSuitPropertyByExp(param1);
         param2["Defence"]["FineSuit"] = _loc3_.Defence;
         param2["Agility"]["FineSuit"] = _loc3_.Agility;
         param2["Luck"]["FineSuit"] = _loc3_.Luck;
         param2["HP"]["FineSuit"] = _loc3_.hp;
         param2["MagicDefence"]["FineSuit"] = _loc3_.MagicDefence;
         param2["Armor"]["FineSuit"] = _loc3_.Armor;
         param2["MagicAttack"]["FineSuit"] = 0;
         param2["Attack"]["FineSuit"] = 0;
      }
      
      public function getFineSuitPropertyByExp(param1:int) : FineSuitVo
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = getSuitVoByExp(param1).level;
         var _loc3_:FineSuitVo = new FineSuitVo();
         _loc5_ = 1;
         while(_loc5_ <= _loc2_)
         {
            _loc4_ = _model[_loc5_.toString()] as FineSuitVo;
            _loc3_.Defence = _loc3_.Defence + _loc4_.Defence;
            _loc3_.hp = _loc3_.hp + _loc4_.hp;
            _loc3_.Luck = _loc3_.Luck + _loc4_.Luck;
            _loc3_.Agility = _loc3_.Agility + _loc4_.Agility;
            _loc3_.MagicDefence = _loc3_.MagicDefence + _loc4_.MagicDefence;
            _loc3_.Armor = _loc3_.Armor + _loc4_.Armor;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getTipsPropertyInfoList(param1:int, param2:String) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc7_:FineSuitVo = _data[param1][param2] as FineSuitVo;
         var _loc5_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < propertyList.length)
         {
            _loc3_ = propertyList[_loc6_];
            if(_loc7_.hasOwnProperty(_loc3_))
            {
               _loc4_ = _loc7_[_loc3_];
               if(_loc4_ != 0)
               {
                  _loc5_.push(nameList[_loc6_] + _loc4_);
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getTipsPropertyInfoListToString(param1:int, param2:String) : String
      {
         var _loc3_:Array = getTipsPropertyInfoList(param1,param2);
         return _loc3_.toString().replace(/,/g," ");
      }
      
      public function get materialIDList() : Array
      {
         return _materialIDList;
      }
      
      public function get tipsData() : DictionaryData
      {
         return _data;
      }
      
      public function getSuitVoByLevel(param1:int) : FineSuitVo
      {
         return _model[param1];
      }
   }
}
