package godsRoads
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import godsRoads.manager.GodsRoadsManager;
   import godsRoads.view.GodsRoadsView;
   
   public class GodRoadsController extends EventDispatcher
   {
      
      private static var _instance:GodRoadsController;
       
      
      public var _view:GodsRoadsView;
      
      public var lastStep:int = 0;
      
      public var lastMssion:int = 0;
      
      public function GodRoadsController(param1:PrivateClass){super();}
      
      public static function get instance() : GodRoadsController{return null;}
      
      public function setup() : void{}
      
      private function __onGodsRoadsChangeSteps(param1:Event) : void{}
      
      private function __onGodsRoadsOpenFrame(param1:Event) : void{}
      
      private function disposeView(param1:Event) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
