package DDPlay
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class DDPlayManaer extends EventDispatcher
   {
      
      public static const UPDATE_SCORE:String = "update_score";
      
      private static var loadComplete:Boolean = false;
      
      private static var useFirst:Boolean = true;
      
      private static var _instance:DDPlayManaer;
       
      
      public var isOpen:Boolean;
      
      public var DDPlayScore:int;
      
      public var DDPlayMoney:int;
      
      public var exchangeFold:int;
      
      public var beginDate:Date;
      
      public var endDate:Date;
      
      private var _ddPlayView:DDPlayView;
      
      public function DDPlayManaer(param1:DDPlayInstance, param2:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : DDPlayManaer{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      protected function __addDDPlayBtn(param1:CrazyTankSocketEvent) : void{}
      
      private function openOrClose(param1:PackageIn) : void{}
      
      public function createDDPlayBtn() : void{}
      
      public function deleteDDPlayBtn() : void{}
      
      public function show() : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function showDDPlayView() : void{}
   }
}

class DDPlayInstance
{
    
   
   function DDPlayInstance(){super();}
}
