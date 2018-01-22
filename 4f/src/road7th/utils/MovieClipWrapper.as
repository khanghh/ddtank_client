package road7th.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="complete",type="flash.events.Event")]
   public class MovieClipWrapper extends EventDispatcher implements Disposeable
   {
       
      
      private var _movie:MovieClip;
      
      public var repeat:Boolean;
      
      private var autoDisappear:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _endFrame:int = -1;
      
      public function MovieClipWrapper(param1:MovieClip, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false){super();}
      
      public function set endFrame(param1:int) : void{}
      
      private function __onAddStage(param1:Event) : void{}
      
      public function set x(param1:int) : void{}
      
      public function set y(param1:int) : void{}
      
      public function get x() : int{return 0;}
      
      public function get y() : int{return 0;}
      
      public function gotoAndPlay(param1:Object) : void{}
      
      public function gotoAndStop(param1:Object) : void{}
      
      public function addFrameScriptAt(param1:Number, param2:Function) : void{}
      
      public function play() : void{}
      
      public function get movie() : MovieClip{return null;}
      
      public function stop() : void{}
      
      private function __frameHandler(param1:Event) : void{}
      
      private function __endFrame() : void{}
      
      public function dispose() : void{}
   }
}
