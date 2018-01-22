package morn.core.components
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import flash.display.BitmapData;
   import flash.events.Event;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   import morn.editor.core.IClip;
   
   [Event(name="frameChanged",type="morn.core.events.UIEvent")]
   [Event(name="imageLoaded",type="morn.core.events.UIEvent")]
   public class Clip extends Component implements IClip
   {
       
      
      protected var _autoStopAtRemoved:Boolean = true;
      
      protected var _bitmap:AutoBitmap;
      
      protected var _clipX:int = 1;
      
      protected var _clipY:int = 1;
      
      protected var _clipWidth:Number;
      
      protected var _clipHeight:Number;
      
      protected var _url:String;
      
      protected var _autoPlay:Boolean;
      
      protected var _interval:int;
      
      protected var _from:int = -1;
      
      protected var _to:int = -1;
      
      protected var _complete:Handler;
      
      protected var _isPlaying:Boolean;
      
      protected var _clipsUrl:String;
      
      protected var _bitmapLoader:BitmapLoader;
      
      public function Clip(param1:String = null, param2:int = 1, param3:int = 1){super();}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function onAddedToStage(param1:Event) : void{}
      
      protected function onRemovedFromStage(param1:Event) : void{}
      
      public function get url() : String{return null;}
      
      public function set url(param1:String) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function get clipX() : int{return 0;}
      
      public function set clipX(param1:int) : void{}
      
      public function get clipY() : int{return 0;}
      
      public function set clipY(param1:int) : void{}
      
      public function get clipWidth() : Number{return 0;}
      
      public function set clipWidth(param1:Number) : void{}
      
      public function get clipHeight() : Number{return 0;}
      
      public function set clipHeight(param1:Number) : void{}
      
      protected function changeClip() : void{}
      
      private function __onLoaderComplete(param1:LoaderEvent) : void{}
      
      private function __onLoaderError(param1:LoaderEvent) : void{}
      
      private function clearBitmapLoader() : void{}
      
      protected function loadComplete(param1:String, param2:Boolean, param3:BitmapData) : void{}
      
      public function get clips() : Vector.<BitmapData>{return null;}
      
      public function set clips(param1:Vector.<BitmapData>) : void{}
      
      public function get clipsUrl() : String{return null;}
      
      public function set clipsUrl(param1:String) : void{}
      
      public function set clipsUrlSimple(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function commitMeasure() : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
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
      
      public function playFromTo(param1:int = -1, param2:int = -1, param3:Handler = null) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get smoothing() : Boolean{return false;}
      
      public function set smoothing(param1:Boolean) : void{}
      
      public function get anchorX() : Number{return 0;}
      
      public function set anchorX(param1:Number) : void{}
      
      public function get anchorY() : Number{return 0;}
      
      public function set anchorY(param1:Number) : void{}
      
      public function get bitmap() : AutoBitmap{return null;}
      
      override public function dispose() : void{}
      
      public function destroy(param1:Boolean = false) : void{}
   }
}
