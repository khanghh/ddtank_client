package newYearRice
{
   import com.pickgliss.ui.core.Component;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperUIModuleLoad;
   import flash.display.Bitmap;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import newYearRice.model.NewYearRiceModel;
   import road7th.comm.PackageIn;
   
   public class NewYearRiceManager extends CoreManager
   {
      
      private static var _instance:NewYearRiceManager;
      
      public static const NEWYEARRICE_OPENFRAME:String = "newyearrice_openframe";
      
      public static const NEWYEARRICE_INVITE:String = "newyearrice_invite";
      
      public static var IsOpenFrame:Boolean = false;
      
      private static var loadComplete:Boolean = false;
      
      private static var useFirst:Boolean = true;
       
      
      private var _model:NewYearRiceModel;
      
      public function NewYearRiceManager(param1:PrivateClass)
      {
         super();
      }
      
      public static function get instance() : NewYearRiceManager
      {
         if(NewYearRiceManager._instance == null)
         {
            NewYearRiceManager._instance = new NewYearRiceManager(new PrivateClass());
         }
         return NewYearRiceManager._instance;
      }
      
      public function setup() : void
      {
         _model = new NewYearRiceModel();
         SocketManager.Instance.addEventListener("newYearRice",pkgHandler);
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 161)
         {
            case 0:
               openOrclose(_loc4_);
               break;
            case 1:
               openNewYearRiceView(_loc4_);
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("yearFoodEnter",_loc4_);
               break;
            case 3:
               yearFoodRoomInvitePlayer(_loc4_);
               break;
            case 4:
               _loc3_ = new CrazyTankSocketEvent("yearFoodCreateFood",_loc4_);
               break;
            case 5:
               _loc3_ = new CrazyTankSocketEvent("exitYearFoodRoom",_loc4_);
               break;
            case 6:
               _loc3_ = new CrazyTankSocketEvent("yearFoodCook",_loc4_);
               break;
            case 7:
               _loc3_ = new CrazyTankSocketEvent("yearFoodRoomInvite",_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function openOrclose(param1:PackageIn = null) : void
      {
         _model.isOpen = param1.readBoolean();
         showEnterIcon(_model.isOpen);
      }
      
      private function yearFoodRoomInvitePlayer(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _model.roomType = param1.readInt();
         _model.playersLength = param1.readInt();
         if(_model.playersLength > 0)
         {
            _model.playersArray = [];
            _loc3_ = 0;
            while(_loc3_ < _model.playersLength)
            {
               _loc2_ = {};
               _loc2_.ID = param1.readInt();
               _loc2_.Style = param1.readUTF();
               _loc2_.NikeName = param1.readUTF();
               _loc2_.Sex = param1.readBoolean();
               _model.playersArray[_loc3_] = _loc2_;
               _loc3_++;
            }
            openInviteView();
         }
      }
      
      private function openInviteView() : void
      {
         AssetModuleLoader.addModelLoader("newYearRice",6);
         AssetModuleLoader.startCodeLoader(onLoadComplete);
      }
      
      private function onLoadComplete() : void
      {
         dispatchEvent(new Event("newyearrice_invite"));
      }
      
      private function openNewYearRiceView(param1:PackageIn) : void
      {
         _model.yearFoodInfo = param1.readInt();
         initOpenFrame();
      }
      
      override protected function start() : void
      {
         if(StateManager.currentStateType == "main")
         {
            new HelperUIModuleLoad().loadUIModule(["newYearRice"],sendCheckNewYearRiceInfoHandler);
         }
      }
      
      private function sendCheckNewYearRiceInfoHandler() : void
      {
         SocketManager.Instance.out.sendCheckNewYearRiceInfo();
      }
      
      private function initOpenFrame() : void
      {
         dispatchEvent(new Event("newyearrice_openframe"));
      }
      
      public function showEnterIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("newYearRice",param1);
      }
      
      public function returnComponent(param1:Bitmap, param2:String) : Component
      {
         var _loc3_:Component = new Component();
         _loc3_.tipData = param2;
         _loc3_.tipDirctions = "0,1,2";
         _loc3_.tipStyle = "ddt.view.tips.OneLineTip";
         _loc3_.tipGapH = 20;
         _loc3_.width = param1.width;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         param1.x = 0;
         param1.y = 0;
         _loc3_.addChild(param1);
         return _loc3_;
      }
      
      public function get model() : NewYearRiceModel
      {
         return _model;
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         _model.itemInfoList = param1;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
