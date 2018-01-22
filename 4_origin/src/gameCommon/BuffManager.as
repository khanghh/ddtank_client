package gameCommon
{
   import calendar.CalendarManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.data.BuffType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameBuffAnalyzer;
   import road7th.data.DictionaryData;
   
   public class BuffManager
   {
      
      private static var _buffTemplateInfo:Dictionary = new Dictionary();
      
      private static var _templateInfoLoaded:Boolean = false;
      
      private static var _effectLoaded:Boolean = false;
      
      private static var _buffTemplateData:DictionaryData;
       
      
      public function BuffManager()
      {
         super();
      }
      
      public static function creatBuff(param1:int) : FightBuffInfo
      {
         var _loc2_:FightBuffInfo = new FightBuffInfo(param1);
         if(isCardBuff(_loc2_))
         {
            _loc2_.type = 4;
            translateDisplayID(_loc2_);
         }
         else if(isConsortiaBuff(_loc2_))
         {
            _loc2_.type = 3;
            translateDisplayID(_loc2_);
         }
         else if(BuffType.isLocalBuffByID(param1))
         {
            _loc2_.type = 1;
            translateDisplayID(_loc2_);
            if(BuffType.isLuckyBuff(param1) && CalendarManager.getInstance().luckyNum >= 0)
            {
               _loc2_.displayid = CalendarManager.getInstance().luckyNum + 40;
            }
         }
         else
         {
            _loc2_.displayid = _loc2_.id;
         }
         return _loc2_;
      }
      
      private static function translateDisplayID(param1:FightBuffInfo) : void
      {
         switch(int(param1.id) - 16)
         {
            case 0:
               param1.displayid = 13;
               break;
            default:
            default:
            default:
               param1.displayid = param1.id;
               break;
            case 4:
               param1.displayid = 12;
               break;
            case 5:
               param1.displayid = 13;
         }
      }
      
      public static function startLoadBuffEffect() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!_effectLoaded)
         {
            if(_templateInfoLoaded)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _buffTemplateInfo;
               for each(var _loc3_ in _buffTemplateInfo)
               {
                  if(_loc3_.EffectPic)
                  {
                     LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(_loc3_.EffectPic),4);
                  }
               }
               _effectLoaded = true;
            }
            else
            {
               _loc2_ = new URLVariables();
               _loc2_["rnd"] = Math.random();
               _loc1_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetSkillElementInfo.xml"),2,_loc2_);
               _loc1_.addEventListener("complete",onComplete);
               LoadResourceManager.Instance.startLoad(_loc1_);
            }
         }
      }
      
      private static function onComplete(param1:LoaderEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc2_:BaseLoader = param1.loader;
         _loc2_.removeEventListener("complete",onComplete);
         if(_loc2_.isSuccess)
         {
            _loc5_ = new XML(_loc2_.content);
            _loc6_ = _loc5_..item;
            var _loc8_:int = 0;
            var _loc7_:* = _loc6_;
            for each(var _loc3_ in _loc6_)
            {
               _loc4_ = new BuffTemplateInfo();
               _loc4_.ID = _loc3_.@ID;
               _loc4_.Name = _loc3_.@Name;
               _loc4_.Description = _loc3_.@Description;
               _loc4_.EffectPic = _loc3_.@EffectPic;
               _buffTemplateInfo[_loc4_.ID] = _loc4_;
            }
            _templateInfoLoaded = true;
            startLoadBuffEffect();
         }
      }
      
      public static function isConsortiaBuff(param1:FightBuffInfo) : Boolean
      {
         switch(int(param1.id) - 101)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
               return true;
         }
      }
      
      public static function isCardBuff(param1:FightBuffInfo) : Boolean
      {
         return param1.id >= 211 && param1.id <= 290;
      }
      
      public static function loadBuffTemplate() : void
      {
         var _loc1_:* = null;
         if(_buffTemplateData == null)
         {
            _loc1_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BuffTemplateInfo.xml"),5);
            _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.gamebuff.LoaderError");
            _loc1_.analyzer = new GameBuffAnalyzer(analyzerGameBuff);
            LoadResourceManager.Instance.startLoad(_loc1_);
         }
      }
      
      private static function analyzerGameBuff(param1:GameBuffAnalyzer) : void
      {
         _buffTemplateData = param1.data;
      }
      
      public static function get buffTemplateData() : DictionaryData
      {
         return _buffTemplateData;
      }
   }
}

class BuffTemplateInfo
{
    
   
   public var ID:int;
   
   public var Name:String;
   
   public var Description:String;
   
   public var EffectPic:String;
   
   function BuffTemplateInfo()
   {
      super();
   }
}
