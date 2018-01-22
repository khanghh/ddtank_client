package texpSystem.controller
{
   import ddt.data.BuffInfo;
   import ddt.data.analyze.TexpExpAnalyze;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import texpSystem.TexpEvent;
   import texpSystem.data.TexpExp;
   import texpSystem.data.TexpInfo;
   
   public class TexpManager extends EventDispatcher
   {
      
      private static const MAX_LV:int = 75;
      
      private static var _instance:TexpManager;
      
      public static const TEXP_VIEW:String = "texpView";
      
      public static const INFO_VIEW:String = "infoView";
      
      public static const CHAGNE_INFO:String = "changeinfo";
      
      public static const CHAGNE_VISIBLE:String = "changevisible";
      
      public static const SHINE:String = "shine";
      
      public static const CLEAN_INFO:String = "cleaninfo";
       
      
      private var _texpExp:Dictionary;
      
      private var cevent:CEvent;
      
      private var _isShow:Dictionary;
      
      public var texpType:int = 20;
      
      public function TexpManager(param1:TexpManagerEnforcer)
      {
         super();
      }
      
      public static function get Instance() : TexpManager
      {
         if(!_instance)
         {
            _instance = new TexpManager(new TexpManagerEnforcer());
         }
         return _instance;
      }
      
      public function setup(param1:TexpExpAnalyze) : void
      {
         _texpExp = param1.list;
         PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
         _isShow = new Dictionary();
      }
      
      public function showTexpView(param1:String, param2:Sprite) : void
      {
         cevent = new CEvent(param1,{
            "type":"openview",
            "parent":param2
         });
         AssetModuleLoader.addModelLoader("ddttexpsystem",6);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function loadComplete() : void
      {
         dispatchEvent(Event(cevent));
         _isShow[cevent.type] = true;
      }
      
      public function closeTexpView(param1:String) : void
      {
         dispatchEvent(new CEvent(param1,{"type":"closeView"}));
      }
      
      public function changeInfo(param1:String, param2:*) : void
      {
         dispatchEvent(new CEvent(param1,{
            "type":"changeinfo",
            "info":param2
         }));
      }
      
      public function changeVisible(param1:String, param2:Boolean) : void
      {
         dispatchEvent(new CEvent(param1,{
            "type":"changevisible",
            "visible":param2
         }));
      }
      
      public function shine(param1:Boolean) : void
      {
         dispatchEvent(new CEvent("texpView",{
            "type":"shine",
            "shine":param1
         }));
      }
      
      public function cleanInfo() : void
      {
         dispatchEvent(new CEvent("texpView",{"type":"cleaninfo"}));
      }
      
      public function isShow(param1:String) : Boolean
      {
         return _isShow[param1];
      }
      
      public function getLv(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _loc4_ = 1;
         while(_loc4_ <= 75)
         {
            _loc2_ = _texpExp[_loc4_];
            if(param1 >= _loc2_.GP)
            {
               _loc3_ = _loc4_;
               _loc4_++;
               continue;
            }
            break;
         }
         return _loc3_;
      }
      
      public function getInfo(param1:int, param2:int) : TexpInfo
      {
         var _loc4_:TexpInfo = new TexpInfo();
         var _loc3_:int = getLv(param2);
         _loc4_.type = param1;
         _loc4_.lv = _loc3_;
         if(_loc3_ == 0)
         {
            _loc4_.currExp = param2;
            _loc4_.currEffect = 0;
            _loc4_.upExp = _texpExp[1].GP;
            _loc4_.upEffect = getEffect(param1,_texpExp[_loc3_ + 1]);
         }
         else if(_loc3_ == 75)
         {
            _loc4_.currExp = 0;
            _loc4_.currEffect = getEffect(param1,_texpExp[_loc3_]);
            _loc4_.upExp = 0;
            _loc4_.upEffect = 0;
         }
         else
         {
            _loc4_.currExp = param2 - _texpExp[_loc3_].GP;
            _loc4_.currEffect = getEffect(param1,_texpExp[_loc3_]);
            _loc4_.upExp = _texpExp[_loc3_ + 1].GP - _texpExp[_loc3_].GP;
            _loc4_.upEffect = getEffect(param1,_texpExp[_loc3_ + 1]);
         }
         return _loc4_;
      }
      
      public function getName(param1:int) : String
      {
         switch(int(param1))
         {
            case 0:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.hp");
            case 1:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.att");
            case 2:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.def");
            case 3:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.spd");
            case 4:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.luk");
            case 5:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.magicAtk");
            case 6:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.magicDef");
         }
      }
      
      public function getExp(param1:int) : int
      {
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         switch(int(param1))
         {
            case 0:
               return _loc2_.hpTexpExp;
            case 1:
               return _loc2_.attTexpExp;
            case 2:
               return _loc2_.defTexpExp;
            case 3:
               return _loc2_.spdTexpExp;
            case 4:
               return _loc2_.lukTexpExp;
            case 5:
               return _loc2_.magicAtkTexpExp;
            case 6:
               return _loc2_.magicDefTexpExp;
         }
      }
      
      public function isXiuLianDaShi(param1:DictionaryData) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_ && _loc3_.buffItemInfo && _loc3_.buffItemInfo.TemplateID == 11911)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      private function getEffect(param1:int, param2:TexpExp) : int
      {
         switch(int(param1))
         {
            case 0:
               return param2.ExerciseH;
            case 1:
               return param2.ExerciseA;
            case 2:
               return param2.ExerciseD;
            case 3:
               return param2.ExerciseAG;
            case 4:
               return param2.ExerciseL;
            case 5:
               return param2.ExerciseMA;
            case 6:
               return param2.ExerciseMD;
         }
      }
      
      private function isUp(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = getExp(param1);
         if(getLv(_loc3_) > getLv(param2))
         {
            return true;
         }
         return false;
      }
      
      private function __onChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["hpTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpHp"));
            if(isUp(0,param1.lastValue["hpTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(0)));
            }
         }
         if(param1.changedProperties["attTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpAtt"));
            if(isUp(1,param1.lastValue["attTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(1)));
            }
         }
         if(param1.changedProperties["defTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpDef"));
            if(isUp(2,param1.lastValue["defTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(2)));
            }
         }
         if(param1.changedProperties["spdTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpSpd"));
            if(isUp(3,param1.lastValue["spdTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(3)));
            }
         }
         if(param1.changedProperties["lukTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpLuk"));
            if(isUp(4,param1.lastValue["lukTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(4)));
            }
         }
         if(param1.changedProperties["magicAtkTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpMagicAtk"));
            if(isUp(5,param1.lastValue["magicAtkTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(5)));
            }
         }
         if(param1.changedProperties["magicDefTexpExp"])
         {
            dispatchEvent(new TexpEvent("texpMagicDef"));
            if(isUp(6,param1.lastValue["magicDefTexpExp"]))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(6)));
            }
         }
      }
   }
}

class TexpManagerEnforcer
{
    
   
   function TexpManagerEnforcer()
   {
      super();
   }
}
