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
       
      
      public function BuffManager(){super();}
      
      public static function creatBuff(param1:int) : FightBuffInfo{return null;}
      
      private static function translateDisplayID(param1:FightBuffInfo) : void{}
      
      public static function startLoadBuffEffect() : void{}
      
      private static function onComplete(param1:LoaderEvent) : void{}
      
      public static function isConsortiaBuff(param1:FightBuffInfo) : Boolean{return false;}
      
      public static function isCardBuff(param1:FightBuffInfo) : Boolean{return false;}
      
      public static function loadBuffTemplate() : void{}
      
      private static function analyzerGameBuff(param1:GameBuffAnalyzer) : void{}
      
      public static function get buffTemplateData() : DictionaryData{return null;}
   }
}

class BuffTemplateInfo
{
    
   
   public var ID:int;
   
   public var Name:String;
   
   public var Description:String;
   
   public var EffectPic:String;
   
   function BuffTemplateInfo(){super();}
}
