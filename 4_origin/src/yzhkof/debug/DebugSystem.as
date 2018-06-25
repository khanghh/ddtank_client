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
       
      
      public function DebugSystem()
      {
         super();
      }
      
      public static function init(dobj:DisplayObject, useSample:Boolean = false) : void
      {
         if(useSample)
         {
            startSampling();
         }
         if(dobj.stage)
         {
            _stage = dobj.stage;
            setup();
         }
         else
         {
            dobj.addEventListener(Event.ADDED_TO_STAGE,__addToStage);
         }
      }
      
      protected static function __addToStage(event:Event) : void
      {
         DisplayObject(event.currentTarget).removeEventListener(Event.ADDED_TO_STAGE,__addToStage);
         _stage = DisplayObject(event.currentTarget).stage;
         setup();
      }
      
      private static function setup() : void
      {
         if(_isInited)
         {
            return;
         }
         _isInited = true;
         _mainContainer = new Sprite();
         _stage.addChild(_mainContainer);
         extend_btn = new TextPanel();
         extend_btn.text = "展开";
         _mainContainer.addChild(extend_btn);
         KeyMy.setStage(_stage);
         KeyMy.startListener(_stage);
         _stage.addEventListener(Event.ADDED,onStageAdd);
         logViewer = new DebugLogViewer();
         _mainContainer.addChild(logViewer);
         logViewer.y = 100;
         weakLogViewer = new DebugLogViewer(true);
         _mainContainer.addChild(weakLogViewer);
         weakLogViewer.y = 100;
         watchViewer = new DebugWatcherViewer();
         _mainContainer.addChild(watchViewer);
         watchViewer.y = 100;
         initDisplayObjectViewer();
         scriptViewer = new ScriptViewer();
         _mainContainer.addChild(scriptViewer);
         scriptViewer.x = 420;
         TextTrace.init(_mainContainer);
         FocusViewer.init(_mainContainer,_stage);
         _mainContainer.visible = false;
         logViewer.visible = false;
         weakLogViewer.visible = false;
         watchViewer.visible = false;
         TextTrace.visible = false;
         FocusViewer.visible = false;
         scriptViewer.visible = false;
         TextTrace.view.y = 200;
         FocusViewer.view.x = 500;
         FocusViewer.view.y = 300;
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void
         {
            if(e.ctrlKey && e.altKey)
            {
               switch(e.keyCode)
               {
                  case 13:
                     ScriptRuner.reFreshScript();
                     break;
                  case 84:
                     TextTrace.visible = !TextTrace.visible;
                     break;
                  case 68:
                     displayObjectViewer.visible = !displayObjectViewer.visible;
                     break;
                  case 65:
                     scriptViewer.visible = !scriptViewer.visible;
               }
            }
            switch(e.keyCode)
            {
               case 192:
                  _mainContainer.visible = !_mainContainer.visible;
            }
         });
         extend_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            displayObjectViewer.visible = true;
         });
      }
      
      static function getDebugTextButton(obj:*, text:String) : TextPanel
      {
         return displayObjectViewer.getDebugTextButton(obj,text);
      }
      
      private static function initDisplayObjectViewer() : void
      {
         displayObjectViewer = new DebugDisplayObjectViewer(_stage);
         displayObjectViewer.goto(_stage);
         _mainContainer.addChild(displayObjectViewer);
         displayObjectViewer.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            _stage.focus = e.relatedObject;
            e.preventDefault();
         });
      }
      
      private static function onStageAdd(e:Event) : void
      {
         _stage.setChildIndex(_mainContainer,_stage.numChildren - 1);
      }
      
      public static function get isInited() : Boolean
      {
         return _isInited;
      }
   }
}
