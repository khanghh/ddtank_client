package farm.control
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import farm.analyzer.FoodComposeListAnalyzer;
   import farm.view.compose.model.ComposeHouseModel;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import pet.data.PetTemplateInfo;
   
   public class FarmComposeHouseController extends EventDispatcher
   {
      
      private static var _instance:FarmComposeHouseController;
       
      
      public var composeHouseModel:ComposeHouseModel;
      
      public function FarmComposeHouseController(param1:IEventDispatcher = null){super(null);}
      
      public static function instance() : FarmComposeHouseController{return null;}
      
      public function setup() : void{}
      
      public function getResultPages(param1:int = 10) : int{return 0;}
      
      public function getAllItems() : Vector.<InventoryItemInfo>{return null;}
      
      public function getItemsByPage(param1:int, param2:int = 10) : Vector.<InventoryItemInfo>{return null;}
      
      public function setupFoodComposeList(param1:FoodComposeListAnalyzer) : void{}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      public function getComposeDetailByID(param1:int) : Vector.<FoodComposeListTemplateInfo>{return null;}
      
      public function getNextUpdatePetTimes() : String{return null;}
      
      public function isFourStarPet(param1:Array) : Boolean{return false;}
      
      public function refreshVolume() : String{return null;}
   }
}
