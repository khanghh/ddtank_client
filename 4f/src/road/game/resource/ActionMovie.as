package road.game.resource
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class ActionMovie extends MovieClip
   {
      
      public static var LEFT:String = "left";
      
      public static var RIGHT:String = "right";
      
      public static var DEFAULT_ACTION:String = "stand";
      
      public static var STAND_ACTION:String = "stand";
       
      
      private var _labelLastFrames:Array;
      
      private var _soundControl:SoundTransform;
      
      private var _labelLastFrame:Dictionary;
      
      private var _currentAction:String;
      
      private var lastAction:String = "";
      
      private var _callBacks:Dictionary;
      
      private var _argsDic:Dictionary;
      
      private var _actionEnded:Boolean = true;
      
      protected var _actionRelative:Object;
      
      public var labelMapping:Dictionary;
      
      private var _soundEffectInstance;
      
      private var _shouldReplace:Boolean = true;
      
      private var _die:MovieClip;
      
      private var _isMute:Boolean = false;
      
      public function ActionMovie(){super();}
      
      public function get shouldReplace() : Boolean{return false;}
      
      public function set shouldReplace(param1:Boolean) : void{}
      
      private function initMovie() : void{}
      
      private function addEvent() : void{}
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      private function hasThisAction(param1:String) : Boolean{return false;}
      
      private function loop(param1:Event) : void{}
      
      private function callCallBack(param1:String) : void{}
      
      private function deleteFun(param1:String) : void{}
      
      private function callFun(param1:Function, param2:Array) : void{}
      
      public function get currentAction() : String{return null;}
      
      public function setActionRelative(param1:Object) : void{}
      
      public function get popupPos() : Point{return null;}
      
      public function get popupDir() : Point{return null;}
      
      public function set direction(param1:String) : void{}
      
      public function get direction() : String{return null;}
      
      public function setActionMapping(param1:String, param2:String) : void{}
      
      private function stopMovieClip(param1:MovieClip) : void{}
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void{}
      
      protected function endAction() : void{}
      
      protected function startAction() : void{}
      
      protected function send(param1:String) : void{}
      
      protected function sendCommand(param1:String, param2:Object = null) : void{}
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void{}
      
      public function MCGotoAndPlay(param1:Object) : void{}
      
      private function __onActionEnd(param1:ActionMovieEvent) : void{}
      
      public function get versionTag() : String{return null;}
      
      public function doSomethingSpecial() : void{}
      
      public function mute() : void{}
      
      public function dispose() : void{}
   }
}
