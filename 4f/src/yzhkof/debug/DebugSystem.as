package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.sampler.startSampling;
   import yzhkof.KeyMy;
   import yzhkof.guxi.FocusViewer;
   import yzhkof.ui.TextPanel;
   
   public class DebugSystem
   {
      
      static var _mainContainer:Sprite;
      
      static var _stage:Stage;
      
      static var displayObjectViewer:DebugDisplayObjectViewer;
      
      static var scriptViewer:ScriptViewer;
      
      static var logViewer:DebugLogViewer;
      
      static var weakLogViewer:DebugLogViewer;
      
      static var watchViewer:DebugWatcherViewer;
      
      private static var extend_btn:TextPanel;
      
      private static var _isInited:Boolean = false;
       
      
      public function DebugSystem(){super();}
      
      public static function init(param1:DisplayObject, param2:Boolean = false) : void{}
      
      protected static function __addToStage(param1:Event) : void{}
      
      private static function setup() : void{}
      
      static function getDebugTextButton(param1:*, param2:String) : TextPanel{return null;}
      
      private static function initDisplayObjectViewer() : void{}
      
      private static function onStageAdd(param1:Event) : void{}
      
      public static function get isInited() : Boolean{return false;}
   }
}
