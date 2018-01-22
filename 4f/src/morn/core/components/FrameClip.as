package morn.core.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.editor.core.IClip;
   
   [Event(name="frameChanged",type="morn.core.events.UIEvent")]
   public class FrameClip extends Component implements IClip
   {
       
      
      protected var _autoStopAtRemoved:Boolean = true;
      
      protected var _mc:MovieClip;
      
      protected var _skin:String;
      
      protected var _frame:int;
      
      protected var _autoPlay:Boolean;
      
      protected var _interval:int;
      
      protected var _to:Object;
      
      protected var _complete:Handler;
      
      protected var _isPlaying:Boolean;
      
      public function FrameClip(param1:String = null){super();}
      
      override protected function initialize() : void{}
      
      protected function onAddedToStage(param1:Event) : void{}
      
      protected function onRemovedFromStage(param1:Event) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function get mc() : MovieClip{return null;}
      
      public function set mc(param1:MovieClip) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function get frame() : int{return 0;}
      
      public function set frame(param1:int) : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function get totalFrame() : int{return 0;}
      
      public function get autoStopAtRemoved() : Boolean{return false;}
      
      public function set autoStopAtRemoved(param1:Boolean) : void{}
      
      public function get autoPlay() : Boolean{return false;}
      
      public function set autoPlay(param1:Boolean) : void{}
      
      public function get interval() : int{return 0;}
      
      public function set interval(param1:int) : void{}
      
      public function get isPlaying() : Boolean{return false;}
      
      public function set isPlaying(param1:Boolean) : void{}
      
      public function play() : void{}
      
      protected function loop() : void{}
      
      public function stop() : void{}
      
      public function gotoAndPlay(param1:int) : void{}
      
      public function gotoAndStop(param1:int) : void{}
      
      public function playFromTo(param1:Object = null, param2:Object = null, param3:Handler = null) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      private function clear() : void{}
      
      override public function dispose() : void{}
   }
}
