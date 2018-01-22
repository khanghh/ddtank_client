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
      
      protected function __addCatchBeastBtn(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 32)
         {
            case 0:
               openOrclose(_loc4_);
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("catchbeast_viewinfo",_loc4_);
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("catchbeast_challenge",_loc4_);
               break;
            case 3:
               _loc3_ = new CrazyTankSocketEvent("catchbeast_buybuff",_loc4_);
               break;
            case 4:
               _loc3_ = new CrazyTankSocketEvent("catchbeast_getaward",_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _isBegin = param1.readBoolean();
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
      
      public function set isBegin(param1:Boolean) : void
      {
         _isBegin = param1;
      }
   }
}
