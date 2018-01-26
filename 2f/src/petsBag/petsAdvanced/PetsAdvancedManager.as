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
      
      public function PetsAdvancedManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : PetsAdvancedManager{return null;}
      
      public function isActivated(param1:int) : Boolean{return false;}
      
      public function risingStarDataComplete(param1:PetsRisingStarDataAnalyzer) : void{}
      
      public function evolutionDataComplete(param1:PetsEvolutionDataAnalyzer) : void{}
      
      public function formDataComplete(param1:PetsFormDataAnalyzer) : void{}
      
      public function moePropertyComplete(param1:PetMoePropertyAnalyzer) : void{}
      
      public function getPetDataByTempId(param1:int) : PetsFormData{return null;}
      
      public function getFormDataIndexByTempId(param1:int) : int{return 0;}
      
      public function getPetsResourceByID(param1:int) : String{return null;}
      
      public function showFrame(param1:int = 0, param2:Boolean = false) : void{}
      
      public function get openType() : int{return 0;}
      
      public function get isLock() : Boolean{return false;}
      
      override protected function start() : void{}
   }
}
