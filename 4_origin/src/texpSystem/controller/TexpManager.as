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
      
      private var _changeProperties:Array;
      
      private var _texpType:Array;
      
      public function TexpManager(enforcer:TexpManagerEnforcer)
      {
         _changeProperties = ["hpTexpExp","attTexpExp","defTexpExp","spdTexpExp","lukTexpExp","magicAtkTexpExp","magicDefTexpExp","critTexpExp","sunderArmorTexpExp","critDmgTexpExp","speedTexpExp","uniqueSkillTexpExp","dmgTexpExp","armorDefTexpExp"];
         _texpType = [0,1,2,3,4,5,6,7,8,9,10,11,12,13];
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
      
      public function setup(analyzer:TexpExpAnalyze) : void
      {
         _texpExp = analyzer.list;
         PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
         _isShow = new Dictionary();
      }
      
      public function showTexpView($type:String, $parent:Sprite) : void
      {
         cevent = new CEvent($type,{
            "type":"openview",
            "parent":$parent
         });
         AssetModuleLoader.addModelLoader("ddttexpsystem",7);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function loadComplete() : void
      {
         dispatchEvent(Event(cevent));
         _isShow[cevent.type] = true;
      }
      
      public function closeTexpView($type:String) : void
      {
         dispatchEvent(new CEvent($type,{"type":"closeView"}));
      }
      
      public function changeInfo($type:String, data:*) : void
      {
         dispatchEvent(new CEvent($type,{
            "type":"changeinfo",
            "info":data
         }));
      }
      
      public function changeVisible($type:String, value:Boolean) : void
      {
         dispatchEvent(new CEvent($type,{
            "type":"changevisible",
            "visible":value
         }));
      }
      
      public function shine(value:Boolean) : void
      {
         dispatchEvent(new CEvent("texpView",{
            "type":"shine",
            "shine":value
         }));
      }
      
      public function cleanInfo() : void
      {
         dispatchEvent(new CEvent("texpView",{"type":"cleaninfo"}));
      }
      
      public function isShow(type:String) : Boolean
      {
         return _isShow[type];
      }
      
      public function getLv(exp:int) : int
      {
         var i:int = 0;
         var lv:* = 0;
         var t:* = null;
         for(i = 1; i <= 75; )
         {
            t = _texpExp[i];
            if(exp >= t.GP)
            {
               lv = i;
               i++;
               continue;
            }
            break;
         }
         return lv;
      }
      
      public function getInfo(type:int, exp:int) : TexpInfo
      {
         var info:TexpInfo = new TexpInfo();
         var lv:int = getLv(exp);
         info.type = type;
         info.lv = lv;
         if(lv == 0)
         {
            info.currExp = exp;
            info.currEffect = 0;
            info.upExp = _texpExp[1].GP;
            info.upEffect = getEffect(type,_texpExp[lv + 1]);
         }
         else if(lv == 75)
         {
            info.currExp = 0;
            info.currEffect = getEffect(type,_texpExp[lv]);
            info.upExp = 0;
            info.upEffect = 0;
         }
         else
         {
            info.currExp = exp - _texpExp[lv].GP;
            info.currEffect = getEffect(type,_texpExp[lv]);
            info.upExp = _texpExp[lv + 1].GP - _texpExp[lv].GP;
            info.upEffect = getEffect(type,_texpExp[lv + 1]);
         }
         return info;
      }
      
      public function getName(type:int) : String
      {
         switch(int(type))
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
            case 7:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.crit");
            case 8:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.sunderArmor");
            case 9:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.critDmg");
            case 10:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.speed");
            case 11:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.uniqueSkill");
            case 12:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.dmg");
            case 13:
               return LanguageMgr.GetTranslation("texpSystem.view.TexpView.armorDef");
         }
      }
      
      public function getExp(type:int) : int
      {
         var self:SelfInfo = PlayerManager.Instance.Self;
         switch(int(type))
         {
            case 0:
               return self.hpTexpExp;
            case 1:
               return self.attTexpExp;
            case 2:
               return self.defTexpExp;
            case 3:
               return self.spdTexpExp;
            case 4:
               return self.lukTexpExp;
            case 5:
               return self.magicAtkTexpExp;
            case 6:
               return self.magicDefTexpExp;
            case 7:
               return self.critTexpExp;
            case 8:
               return self.sunderArmorTexpExp;
            case 9:
               return self.critDmgTexpExp;
            case 10:
               return self.speedTexpExp;
            case 11:
               return self.uniqueSkillTexpExp;
            case 12:
               return self.dmgTexpExp;
            case 13:
               return self.armorDefTexpExp;
         }
      }
      
      public function isXiuLianDaShi(buffInfoData:DictionaryData) : Boolean
      {
         var resultBool:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = buffInfoData;
         for each(var buff in buffInfoData)
         {
            if(buff && buff.buffItemInfo && buff.buffItemInfo.TemplateID == 11911)
            {
               resultBool = true;
               break;
            }
         }
         return resultBool;
      }
      
      private function getEffect(type:int, exp:TexpExp) : int
      {
         switch(int(type))
         {
            case 0:
               return exp.ExerciseH;
            case 1:
               return exp.ExerciseA;
            case 2:
               return exp.ExerciseD;
            case 3:
               return exp.ExerciseAG;
            case 4:
               return exp.ExerciseL;
            case 5:
               return exp.ExerciseMA;
            case 6:
               return exp.ExerciseMD;
            case 7:
               return exp.TrainCrit;
            case 8:
               return exp.TrainSunder;
            case 9:
               return exp.TrainCritDmg;
            case 10:
               return exp.TrainSpeed;
            case 11:
               return exp.TrainTricKill;
            case 12:
               return exp.TrainDmg;
            case 13:
               return exp.TrainArmor;
         }
      }
      
      private function isUp(type:int, oldExp:int) : Boolean
      {
         var exp:int = getExp(type);
         if(getLv(exp) > getLv(oldExp))
         {
            return true;
         }
         return false;
      }
      
      private function __onChange(evt:PlayerPropertyEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < _changeProperties.length; )
         {
            if(evt.changedProperties[_changeProperties[i]])
            {
               dispatchEvent(new TexpEvent("texpproperty",_texpType[i]));
               if(isUp(_texpType[i],evt.lastValue[_changeProperties[i]]))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpView.up",getName(_texpType[i])));
               }
            }
            i++;
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
