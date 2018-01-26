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
      
      public function NewYearRiceManager(param1:PrivateClass){super();}
      
      public static function get instance() : NewYearRiceManager{return null;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function openOrclose(param1:PackageIn = null) : void{}
      
      private function yearFoodRoomInvitePlayer(param1:PackageIn) : void{}
      
      private function openInviteView() : void{}
      
      private function onLoadComplete() : void{}
      
      private function openNewYearRiceView(param1:PackageIn) : void{}
      
      override protected function start() : void{}
      
      private function sendCheckNewYearRiceInfoHandler() : void{}
      
      private function initOpenFrame() : void{}
      
      public function showEnterIcon(param1:Boolean) : void{}
      
      public function returnComponent(param1:Bitmap, param2:String) : Component{return null;}
      
      public function get model() : NewYearRiceModel{return null;}
      
      public function templateDataSetup(param1:Array) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
