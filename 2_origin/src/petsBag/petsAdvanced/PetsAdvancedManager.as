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
      
      public function PetsAdvancedManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : PetsAdvancedManager
      {
         if(_instance == null)
         {
            _instance = new PetsAdvancedManager();
         }
         return _instance;
      }
      
      public function isActivated(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = formDataList;
         for each(var _loc2_ in formDataList)
         {
            if(_loc2_.TemplateID == param1)
            {
               return _loc2_.ShowBtn == 1 || _loc2_.ShowBtn == 2;
            }
         }
         return false;
      }
      
      public function risingStarDataComplete(param1:PetsRisingStarDataAnalyzer) : void
      {
         risingStarDataList = param1.list;
      }
      
      public function evolutionDataComplete(param1:PetsEvolutionDataAnalyzer) : void
      {
         evolutionDataList = param1.list;
      }
      
      public function formDataComplete(param1:PetsFormDataAnalyzer) : void
      {
         formDataList = param1.list;
      }
      
      public function moePropertyComplete(param1:PetMoePropertyAnalyzer) : void
      {
         petMoePropertyList = param1.list;
      }
      
      public function getPetDataByTempId(param1:int) : PetsFormData
      {
         var _loc2_:int = 0;
         var _loc3_:PetsFormData = null;
         if(formDataList)
         {
            _loc2_ = 0;
            while(_loc2_ < formDataList.length)
            {
               _loc3_ = formDataList[_loc2_];
               if(_loc3_.TemplateID != param1)
               {
                  _loc2_++;
                  continue;
               }
               break;
            }
         }
         return _loc3_;
      }
      
      public function getFormDataIndexByTempId(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = -1;
         if(formDataList)
         {
            _loc3_ = 0;
            while(_loc3_ < formDataList.length)
            {
               if(param1 == formDataList[_loc3_].TemplateID)
               {
                  _loc2_ = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function getPetsResourceByID(param1:int) : String
      {
         var _loc2_:int = getFormDataIndexByTempId(param1);
         return formDataList[_loc2_].Resource;
      }
      
      public function showFrame(param1:int = 0, param2:Boolean = false) : void
      {
         _openType = param1;
         _isLock = param2;
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
