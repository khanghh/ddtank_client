package morn.core.components
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import morn.core.events.UIEvent;
   import morn.core.handlers.Handler;
   import morn.core.utils.ObjectUtils;
   import morn.core.utils.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class Button extends Component implements ISelect
   {
      
      protected static var stateMap:Object = {
         "rollOver":1,
         "rollOut":0,
         "mouseDown":2,
         "mouseUp":1,
         "selected":2
      };
       
      
      protected var _content:Sprite;
      
      protected var _bitmap:AutoBitmap;
      
      protected var _btnLabel:Label;
      
      protected var _clickHandler:Handler;
      
      protected var _labelColors:Array;
      
      protected var _labelMargin:Array;
      
      protected var _state:int;
      
      protected var _toggle:Boolean;
      
      protected var _selected:Boolean;
      
      protected var _skin:String;
      
      protected var _autoSize:Boolean = true;
      
      protected var _stateNum:int;
      
      protected var _threeURLs:Array;
      
      protected var _twoURLs:Array;
      
      protected var _imageLabel:String;
      
      protected var _imageLabelSizeGrid:String;
      
      protected var _imageLabelSkins:Array;
      
      protected var _imageLabelClip:AutoBitmap;
      
      protected var _imageLabelX:int;
      
      protected var _imageLabelY:int;
      
      protected var _imageLabelRect:Rectangle;
      
      protected var _enableClickMoveDownEffect:Boolean = true;
      
      protected var _enableRollOverLightEffect:Boolean = true;
      
      protected var _clickInterval:int;
      
      private var _lastClickTime:int;
      
      protected var _showClickTooQuickTip:Boolean = false;
      
      public function Button(param1:String = null, param2:String = ""){super();}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function onMouse(param1:MouseEvent) : void{}
      
      private function onStageMouseUp(param1:MouseEvent) : void{}
      
      public function set threeURLs(param1:String) : void{}
      
      public function set twoURLs(param1:String) : void{}
      
      public function set checkButtonSkin(param1:String) : void{}
      
      public function get label() : String{return null;}
      
      public function set label(param1:String) : void{}
      
      public function set labelHtml(param1:String) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      protected function changeClips() : void{}
      
      override public function commitMeasure() : void{}
      
      protected function changeLabelSize() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      protected function get state() : int{return 0;}
      
      protected function set state(param1:int) : void{}
      
      protected function changeState() : void{}
      
      public function get toggle() : Boolean{return false;}
      
      public function set toggle(param1:Boolean) : void{}
      
      override public function set disabled(param1:Boolean) : void{}
      
      public function get labelColors() : String{return null;}
      
      public function set labelColors(param1:String) : void{}
      
      public function get labelMargin() : String{return null;}
      
      public function set labelMargin(param1:String) : void{}
      
      public function get labelStroke() : String{return null;}
      
      public function set labelStroke(param1:String) : void{}
      
      public function get labelSize() : Object{return null;}
      
      public function set labelSize(param1:Object) : void{}
      
      public function get labelBold() : Object{return null;}
      
      public function set labelBold(param1:Object) : void{}
      
      public function get letterSpacing() : Object{return null;}
      
      public function set letterSpacing(param1:Object) : void{}
      
      public function get labelFont() : String{return null;}
      
      public function set labelFont(param1:String) : void{}
      
      public function get labelLeading() : Object{return null;}
      
      public function set labelLeading(param1:Object) : void{}
      
      public function get clickHandler() : Handler{return null;}
      
      public function set clickHandler(param1:Handler) : void{}
      
      public function get btnLabel() : Label{return null;}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      public function get stateNum() : int{return 0;}
      
      public function set stateNum(param1:int) : void{}
      
      public function get imageLabel() : String{return null;}
      
      public function set imageLabel(param1:String) : void{}
      
      public function get imageLabelX() : int{return 0;}
      
      public function set imageLabelX(param1:int) : void{}
      
      public function get imageLabelY() : int{return 0;}
      
      public function set imageLabelY(param1:int) : void{}
      
      public function get bitmap() : AutoBitmap{return null;}
      
      public function get imageLabelClip() : AutoBitmap{return null;}
      
      override public function dispose() : void{}
      
      public function get enableClickMoveDownEffect() : Boolean{return false;}
      
      public function set enableClickMoveDownEffect(param1:Boolean) : void{}
      
      public function get enableRollOverLightEffect() : Boolean{return false;}
      
      public function set enableRollOverLightEffect(param1:Boolean) : void{}
      
      public function get clickInterval() : int{return 0;}
      
      public function set clickInterval(param1:int) : void{}
      
      public function get showClickTooQuickTip() : Boolean{return false;}
      
      public function set showClickTooQuickTip(param1:Boolean) : void{}
      
      public function get imageLabelSizeGrid() : String{return null;}
      
      public function set imageLabelSizeGrid(param1:String) : void{}
      
      public function get imageLabelRect() : String{return null;}
      
      public function set imageLabelRect(param1:String) : void{}
   }
}
