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
      
      public function NewYearRiceManager(pct:PrivateClass)
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
      
      private function pkgHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 161)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               openNewYearRiceView(pkg);
               break;
            case 2:
               event = new CrazyTankSocketEvent("yearFoodEnter",pkg);
               break;
            case 3:
               yearFoodRoomInvitePlayer(pkg);
               break;
            case 4:
               event = new CrazyTankSocketEvent("yearFoodCreateFood",pkg);
               break;
            case 5:
               event = new CrazyTankSocketEvent("exitYearFoodRoom",pkg);
               break;
            case 6:
               event = new CrazyTankSocketEvent("yearFoodCook",pkg);
               break;
            case 7:
               event = new CrazyTankSocketEvent("yearFoodRoomInvite",pkg);
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      private function openOrclose(pkg:PackageIn = null) : void
      {
         _model.isOpen = pkg.readBoolean();
         showEnterIcon(_model.isOpen);
      }
      
      private function yearFoodRoomInvitePlayer(pkg:PackageIn) : void
      {
         var i:int = 0;
         var obj:* = null;
         _model.roomType = pkg.readInt();
         _model.playersLength = pkg.readInt();
         if(_model.playersLength > 0)
         {
            _model.playersArray = [];
            for(i = 0; i < _model.playersLength; )
            {
               obj = {};
               obj.ID = pkg.readInt();
               obj.Style = pkg.readUTF();
               obj.NikeName = pkg.readUTF();
               obj.Sex = pkg.readBoolean();
               _model.playersArray[i] = obj;
               i++;
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
      
      private function openNewYearRiceView(pkg:PackageIn) : void
      {
         _model.yearFoodInfo = pkg.readInt();
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
      
      public function showEnterIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("newYearRice",flag);
      }
      
      public function returnComponent(cell:Bitmap, tipName:String) : Component
      {
         var compoent:Component = new Component();
         compoent.tipData = tipName;
         compoent.tipDirctions = "0,1,2";
         compoent.tipStyle = "ddt.view.tips.OneLineTip";
         compoent.tipGapH = 20;
         compoent.width = cell.width;
         compoent.x = cell.x;
         compoent.y = cell.y;
         cell.x = 0;
         cell.y = 0;
         compoent.addChild(cell);
         return compoent;
      }
      
      public function get model() : NewYearRiceModel
      {
         return _model;
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         _model.itemInfoList = dataList;
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
