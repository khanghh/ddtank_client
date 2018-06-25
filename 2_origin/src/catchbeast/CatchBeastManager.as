package catchbeast
{
   import com.pickgliss.ui.image.MovieImage;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class CatchBeastManager extends CoreManager
   {
      
      public static const CATCHBEAST_OPENVIEW:String = "catchBeastOpenView";
      
      private static var _instance:CatchBeastManager;
       
      
      public var RoomType:int = 0;
      
      private var _isBegin:Boolean;
      
      private var _hallView:HallStateView;
      
      private var _catchBeastIcon:MovieImage;
      
      public function CatchBeastManager()
      {
         super();
      }
      
      public static function get instance() : CatchBeastManager
      {
         if(!_instance)
         {
            _instance = new CatchBeastManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("catchbeast_begin",__addCatchBeastBtn);
      }
      
      protected function __addCatchBeastBtn(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event._cmd;
         var events:CrazyTankSocketEvent = null;
         switch(int(cmd) - 32)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               events = new CrazyTankSocketEvent("catchbeast_viewinfo",pkg);
               break;
            case 2:
               events = new CrazyTankSocketEvent("catchbeast_challenge",pkg);
               break;
            case 3:
               events = new CrazyTankSocketEvent("catchbeast_buybuff",pkg);
               break;
            case 4:
               events = new CrazyTankSocketEvent("catchbeast_getaward",pkg);
         }
         if(events)
         {
            dispatchEvent(events);
         }
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _isBegin = pkg.readBoolean();
         if(_isBegin)
         {
            createCatchBeastBtn();
         }
         else
         {
            deleteCatchBeastBtn();
         }
      }
      
      private function createCatchBeastBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("catchBeast",true);
      }
      
      public function deleteCatchBeastBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("catchBeast",false);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event("catchBeastOpenView"));
      }
      
      public function get catchBeastIcon() : MovieImage
      {
         return _catchBeastIcon;
      }
      
      public function get isBegin() : Boolean
      {
         return _isBegin;
      }
      
      public function set isBegin(value:Boolean) : void
      {
         _isBegin = value;
      }
   }
}
