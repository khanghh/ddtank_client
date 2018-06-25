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
      
      public static function creatBuff(buffid:int) : FightBuffInfo
      {
         var buff:FightBuffInfo = new FightBuffInfo(buffid);
         if(isCardBuff(buff))
         {
            buff.type = 4;
            translateDisplayID(buff);
         }
         else if(isConsortiaBuff(buff))
         {
            buff.type = 3;
            translateDisplayID(buff);
         }
         else if(BuffType.isLocalBuffByID(buffid))
         {
            buff.type = 1;
            translateDisplayID(buff);
            if(BuffType.isLuckyBuff(buffid) && CalendarManager.getInstance().luckyNum >= 0)
            {
               buff.displayid = CalendarManager.getInstance().luckyNum + 40;
            }
         }
         else
         {
            buff.displayid = buff.id;
         }
         return buff;
      }
      
      private static function translateDisplayID(buff:FightBuffInfo) : void
      {
         switch(int(buff.id) - 16)
         {
            case 0:
               buff.displayid = 13;
               break;
            default:
            default:
            default:
               buff.displayid = buff.id;
               break;
            case 4:
               buff.displayid = 12;
               break;
            case 5:
               buff.displayid = 13;
         }
      }
      
      public static function startLoadBuffEffect() : void
      {
         var args:* = null;
         var loader:* = null;
         if(!_effectLoaded)
         {
            if(_templateInfoLoaded)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _buffTemplateInfo;
               for each(var buff in _buffTemplateInfo)
               {
                  if(buff.EffectPic)
                  {
                     LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(buff.EffectPic),4);
                  }
               }
               _effectLoaded = true;
            }
            else
            {
               args = new URLVariables();
               args["rnd"] = Math.random();
               loader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetSkillElementInfo.xml"),2,args);
               loader.addEventListener("complete",onComplete);
               LoadResourceManager.Instance.startLoad(loader);
            }
         }
      }
      
      private static function onComplete(event:LoaderEvent) : void
      {
         var xml:* = null;
         var xmlList:* = null;
         var buff:* = null;
         var loader:BaseLoader = event.loader;
         loader.removeEventListener("complete",onComplete);
         if(loader.isSuccess)
         {
            xml = new XML(loader.content);
            xmlList = xml..item;
            var _loc8_:int = 0;
            var _loc7_:* = xmlList;
            for each(var item in xmlList)
            {
               buff = new BuffTemplateInfo();
               buff.ID = item.@ID;
               buff.Name = item.@Name;
               buff.Description = item.@Description;
               buff.EffectPic = item.@EffectPic;
               _buffTemplateInfo[buff.ID] = buff;
            }
            _templateInfoLoaded = true;
            startLoadBuffEffect();
         }
      }
      
      public static function isConsortiaBuff(buff:FightBuffInfo) : Boolean
      {
         switch(int(buff.id) - 101)
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
      
      public static function isCardBuff(buff:FightBuffInfo) : Boolean
      {
         return buff.id >= 211 && buff.id <= 290;
      }
      
      public static function loadBuffTemplate() : void
      {
         var loader:* = null;
         if(_buffTemplateData == null)
         {
            loader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("BuffTemplateInfo.xml"),5);
            loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.gamebuff.LoaderError");
            loader.analyzer = new GameBuffAnalyzer(analyzerGameBuff);
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      private static function analyzerGameBuff(analyzer:GameBuffAnalyzer) : void
      {
         _buffTemplateData = analyzer.data;
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
