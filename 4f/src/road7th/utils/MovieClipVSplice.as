package road7th.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class MovieClipVSplice extends EventDispatcher implements Disposeable
   {
       
      
      private var _movieSp:Sprite;
      
      private var _movies:Array;
      
      private var _movie:MovieClip;
      
      private var classRef:Class;
      
      public var repeat:Boolean;
      
      private var autoDisappear:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _endFrame:int = -1;
      
      private var _spacing:Number;
      
      private var _rect:Rectangle;
      
      private var _centerDir:String;
      
      public function MovieClipVSplice(param1:MovieClip, param2:int = 1, param3:Number = 0, param4:Function = null, param5:Rectangle = null, param6:String = "center_bottom", param7:Boolean = true, param8:Boolean = false, param9:Boolean = true){super();}
      
      public function exeMovieFun(param1:String, param2:Array = null, param3:int = 0, param4:int = 0) : void{}
      
      private function __onAddStage(param1:Event) : void{}
      
      public function set endFrame(param1:int) : void{}
      
      public function set x(param1:int) : void{}
      
      public function set y(param1:int) : void{}
      
      public function get x() : int{return 0;}
      
      public function get y() : int{return 0;}
      
      public function gotoAndPlay(param1:Object) : void{}
      
      public function gotoAndStop(param1:Object) : void{}
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      private function callFun(param1:Function, param2:Array) : void{}
      
      public function addFrameScriptAt(param1:Number, param2:Function) : void{}
      
      public function play() : void{}
      
      public function stop() : void{}
      
      private function __frameHandler(param1:Event) : void{}
      
      private function __endFrame() : void{}
      
      public function get movie() : Sprite{return null;}
      
      public function get movies() : Array{return null;}
      
      public function dispose() : void{}
   }
}
