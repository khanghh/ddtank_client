package newYearRice
{
   import cloudBuyLottery.loader.LoaderUIModule;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import newYearRice.view.NewYearRiceMainView;
   import newYearRice.view.NewYearRiceOpenFrameView;
   
   public class NewYearRiceController extends EventDispatcher
   {
      
      private static var _instance:NewYearRiceController;
      
      public static const UPDATEVIEW:String = "updateView";
       
      
      private var _main:NewYearRiceMainView;
      
      private var _openFrameView:NewYearRiceOpenFrameView;
      
      public function NewYearRiceController(param1:PrivateClass){super();}
      
      public static function get instance() : NewYearRiceController{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:Event) : void{}
      
      private function __onInviteView(param1:Event) : void{}
      
      private function addOpenFrameView() : void{}
      
      public function get openFrameView() : NewYearRiceOpenFrameView{return null;}
      
      public function set openFrameView(param1:NewYearRiceOpenFrameView) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
