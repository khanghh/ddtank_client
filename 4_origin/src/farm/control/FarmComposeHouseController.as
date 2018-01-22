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
      
      public function FarmComposeHouseController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function instance() : FarmComposeHouseController
      {
         if(!_instance)
         {
            _instance = new FarmComposeHouseController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         composeHouseModel = new ComposeHouseModel();
      }
      
      public function getResultPages(param1:int = 10) : int
      {
         var _loc2_:Vector.<InventoryItemInfo> = getAllItems();
         var _loc3_:int = Math.ceil(_loc2_.length / param1);
         _loc3_ = _loc3_ == 0?1:_loc3_;
         return _loc3_ == 0?1:_loc3_;
      }
      
      public function getAllItems() : Vector.<InventoryItemInfo>
      {
         var _loc1_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         var _loc4_:int = 0;
         var _loc3_:* = composeHouseModel.items;
         for each(var _loc2_ in composeHouseModel.items)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getItemsByPage(param1:int, param2:int = 10) : Vector.<InventoryItemInfo>
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         var _loc5_:Vector.<InventoryItemInfo> = getAllItems();
         var _loc7_:int = Math.ceil(_loc5_.length / param2);
         if(param1 > 0 && param1 <= _loc7_)
         {
            _loc4_ = 0 + param2 * (param1 - 1);
            _loc6_ = Math.min(_loc5_.length - _loc4_,param2);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc3_.push(_loc5_[_loc4_ + _loc8_]);
               _loc8_++;
            }
         }
         return _loc3_;
      }
      
      public function setupFoodComposeList(param1:FoodComposeListAnalyzer) : void
      {
         composeHouseModel.foodComposeList = param1.list;
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc3_:String = param1.loader.loadErrorMessage;
         if(param1.loader.analyzer)
         {
            if(param1.loader.analyzer.message != null)
            {
               _loc3_ = param1.loader.loadErrorMessage + "\n" + param1.loader.analyzer.message;
            }
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),_loc3_,LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"),"",false,false,false,0,null,"farmSimpleAlert");
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function getComposeDetailByID(param1:int) : Vector.<FoodComposeListTemplateInfo>
      {
         return composeHouseModel.foodComposeList[param1];
      }
      
      public function getNextUpdatePetTimes() : String
      {
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc3_:Number = 24 - _loc2_.getHours();
         var _loc1_:* = 0;
         if(_loc2_.getMinutes() > 0)
         {
            _loc3_--;
            _loc1_ = Number(60 - _loc2_.getMinutes());
         }
         return String(_loc3_) + LanguageMgr.GetTranslation("hour") + String(_loc1_) + LanguageMgr.GetTranslation("minute") + LanguageMgr.GetTranslation("ddt.farms.refreshPetsLastTimes");
      }
      
      public function isFourStarPet(param1:Array) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.StarLevel == 4)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      public function refreshVolume() : String
      {
         return String(PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(PetconfigAnalyzer.PetCofnig.FreeRefereshID));
      }
   }
}
