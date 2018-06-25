package petsBag.petsAdvanced
{
   import ddt.CoreManager;
   import ddt.data.analyze.PetMoePropertyAnalyzer;
   import ddt.data.analyze.PetsEvolutionDataAnalyzer;
   import ddt.data.analyze.PetsFormDataAnalyzer;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import petsBag.data.PetFightPropertyData;
   import petsBag.data.PetMoePropertyInfo;
   import petsBag.data.PetStarExpData;
   import petsBag.data.PetsFormData;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   
   public class PetsAdvancedManager extends CoreManager
   {
      
      public static const DEFAULT:int = 0;
      
      public static const PETS_FORM:int = 2;
      
      public static const PETSADVANCE_FRAME_CLOSE:String = "petsAdvanceFrameClose";
      
      private static var _instance:PetsAdvancedManager;
       
      
      public var risingStarDataList:Vector.<PetStarExpData>;
      
      public var evolutionDataList:Vector.<PetFightPropertyData>;
      
      public var formDataList:Vector.<PetsFormData>;
      
      public var isPetsAdvancedViewShow:Boolean;
      
      public var petMoePropertyList:Vector.<PetMoePropertyInfo>;
      
      private var _openType:int = 0;
      
      private var _isLock:Boolean;
      
      public function PetsAdvancedManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : PetsAdvancedManager
      {
         if(_instance == null)
         {
            _instance = new PetsAdvancedManager();
         }
         return _instance;
      }
      
      public function isActivated(templeteID:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = formDataList;
         for each(var data in formDataList)
         {
            if(data.TemplateID == templeteID)
            {
               return data.ShowBtn == 1 || data.ShowBtn == 2;
            }
         }
         return false;
      }
      
      public function risingStarDataComplete(analyzer:PetsRisingStarDataAnalyzer) : void
      {
         risingStarDataList = analyzer.list;
      }
      
      public function evolutionDataComplete(analyzer:PetsEvolutionDataAnalyzer) : void
      {
         evolutionDataList = analyzer.list;
      }
      
      public function formDataComplete(analyzer:PetsFormDataAnalyzer) : void
      {
         formDataList = analyzer.list;
      }
      
      public function moePropertyComplete(analyzer:PetMoePropertyAnalyzer) : void
      {
         petMoePropertyList = analyzer.list;
      }
      
      public function getPetDataByTempId(id:int) : PetsFormData
      {
         var i:int = 0;
         var info:PetsFormData = null;
         if(formDataList)
         {
            for(i = 0; i < formDataList.length; )
            {
               info = formDataList[i];
               if(info.TemplateID != id)
               {
                  i++;
                  continue;
               }
               break;
            }
         }
         return info;
      }
      
      public function getFormDataIndexByTempId(id:int) : int
      {
         var i:int = 0;
         var index:* = -1;
         if(formDataList)
         {
            for(i = 0; i < formDataList.length; )
            {
               if(id == formDataList[i].TemplateID)
               {
                  index = i;
                  break;
               }
               i++;
            }
         }
         return index;
      }
      
      public function getPetsResourceByID(id:int) : String
      {
         var index:int = getFormDataIndexByTempId(id);
         return formDataList[index].Resource;
      }
      
      public function showFrame(type:int = 0, isLock:Boolean = false) : void
      {
         _openType = type;
         _isLock = isLock;
         show();
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["petsBag"],function():void
         {
            dispatchEvent(new PetsAdvancedEvent("petsAdvanceOpenView"));
         });
      }
   }
}
