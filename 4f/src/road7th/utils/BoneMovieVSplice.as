package road7th.utils
{
   import bones.display.BoneMovieStarling;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class BoneMovieVSplice extends EventDispatcher implements Disposeable
   {
       
      
      private var _movieSp:Sprite;
      
      private var _movies:Array;
      
      private var _movie:BoneMovieWrapper;
      
      private var className:String;
      
      public var repeat:Boolean;
      
      private var autoDisappear:Boolean;
      
      private var _isDispose:Boolean = false;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _spacing:Number;
      
      private var _rect:Rectangle;
      
      private var _centerDir:String;
      
      public function BoneMovieVSplice(param1:BoneMovieStarling, param2:int = 1, param3:Number = 0, param4:Function = null, param5:Rectangle = null, param6:String = "center_bottom", param7:Boolean = true, param8:Boolean = false, param9:Boolean = true){super();}
      
      public function exeMovieFun(param1:String, param2:Array = null, param3:int = 0, param4:int = 0) : void{}
      
      private function __onAddStage(param1:Event) : void{}
      
      public function set x(param1:int) : void{}
      
      public function set y(param1:int) : void{}
      
      public function get x() : int{return 0;}
      
      public function get y() : int{return 0;}
      
      public function gotoAndPlay(param1:Object) : void{}
      
      public function gotoAndStop(param1:Object) : void{}
      
      public function playAction(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      private function callFun(param1:Function, param2:Array) : void{}
      
      public function play(param1:String = "") : void{}
      
      public function stop() : void{}
      
      public function get movie() : Sprite{return null;}
      
      public function get movies() : Array{return null;}
      
      public function get boneMovie() : BoneMovieStarling{return null;}
      
      public function dispose() : void{}
   }
}
