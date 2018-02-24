package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import morn.core.handlers.Handler;
   import morn.core.utils.ObjectUtils;
   import morn.core.utils.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class ComboBox extends Component
   {
      
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
       
      
      protected var _visibleNum:int = 6;
      
      protected var _button:Button;
      
      protected var _listBg:Image;
      
      protected var _list:List;
      
      protected var _isOpen:Boolean;
      
      protected var _scrollBar:VScrollBar;
      
      protected var _itemColors:Array;
      
      protected var _itemSize:int;
      
      protected var _labels:Array;
      
      protected var _selectedIndex:int = -1;
      
      protected var _selectHandler:Handler;
      
      protected var _itemHeight:Number;
      
      protected var _itemH:Number;
      
      protected var _itemLabelMargin:String = "";
      
      protected var _itemLabelStroke:String = "";
      
      protected var _listHeight:Number;
      
      protected var _itemClipUrl:String;
      
      protected var _itemSteateNum:int = 1;
      
      protected var _itemSizeGride:String;
      
      public var canForceChange:Boolean;
      
      public function ComboBox(param1:String = null, param2:String = null){super();}
      
      override protected function preinitialize() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      private function onButtonMouseDown(param1:MouseEvent) : void{}
      
      protected function onListChange(param1:Event) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function set imageLabel(param1:String) : void{}
      
      public function set imageLabelX(param1:int) : void{}
      
      public function set imageLabelY(param1:int) : void{}
      
      public function set imageLabelSizeGrid(param1:String) : void{}
      
      public function set imageLabelRect(param1:String) : void{}
      
      public function set enableClickMoveDownEffect(param1:Boolean) : void{}
      
      public function set listSkin(param1:String) : void{}
      
      public function set listSizeGrid(param1:String) : void{}
      
      public function set itemSizeGride(param1:String) : void{}
      
      public function set itemSteateNum(param1:int) : void{}
      
      public function set itemClipUrl(param1:String) : void{}
      
      public function set itemHeight(param1:Number) : void{}
      
      public function set itemLabelMargin(param1:String) : void{}
      
      public function set itemLabelStroke(param1:String) : void{}
      
      protected function changeList() : void{}
      
      protected function onlistItemMouse(param1:MouseEvent, param2:int) : void{}
      
      protected function changeOpen() : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function get labels() : String{return null;}
      
      public function set labels(param1:String) : void{}
      
      protected function changeItem() : void{}
      
      public function get selectedIndex() : int{return 0;}
      
      public function set selectedIndex(param1:int) : void{}
      
      public function resetSelect() : void{}
      
      public function get selectHandler() : Handler{return null;}
      
      public function set selectHandler(param1:Handler) : void{}
      
      public function get selectedLabel() : String{return null;}
      
      public function set selectedLabel(param1:String) : void{}
      
      public function get visibleNum() : int{return 0;}
      
      public function set visibleNum(param1:int) : void{}
      
      public function get itemColors() : String{return null;}
      
      public function set itemColors(param1:String) : void{}
      
      public function get itemSize() : int{return 0;}
      
      public function set itemSize(param1:int) : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set isOpen(param1:Boolean) : void{}
      
      protected function removeList(param1:Event) : void{}
      
      public function get scrollBarSkin() : String{return null;}
      
      public function set scrollBarSkin(param1:String) : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      public function get scrollBar() : VScrollBar{return null;}
      
      public function get button() : Button{return null;}
      
      public function get list() : List{return null;}
      
      override public function set dataSource(param1:Object) : void{}
      
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
      
      public function get labelFont() : String{return null;}
      
      public function set labelFont(param1:String) : void{}
      
      public function set buttonLabel(param1:String) : void{}
      
      public function get stateNum() : int{return 0;}
      
      public function set stateNum(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
