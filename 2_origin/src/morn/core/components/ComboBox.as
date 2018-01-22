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
      
      public function ComboBox(param1:String = null, param2:String = null)
      {
         this._itemColors = Styles.comboBoxItemColors;
         this._itemSize = Styles.fontSize;
         this._labels = [];
         super();
         this.skin = param1;
         this.labels = param2;
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._button = new Button());
         this._listBg = new Image();
         this._list = new List();
         this._list.mouseHandler = new Handler(this.onlistItemMouse);
         this._scrollBar = new VScrollBar();
         this._list.addChild(this._scrollBar);
      }
      
      override protected function initialize() : void
      {
         this._button.btnLabel.align = "left";
         this._button.enableClickMoveDownEffect = false;
         this._button.labelMargin = "5";
         this._button.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDown);
         this._list.addEventListener(Event.CHANGE,this.onListChange);
         this._scrollBar.name = "scrollBar";
         this._scrollBar.y = 1;
      }
      
      private function onButtonMouseDown(param1:MouseEvent) : void
      {
         callLater(this.changeOpen);
      }
      
      protected function onListChange(param1:Event) : void
      {
         this.selectedIndex = this._list.selectedIndex;
      }
      
      public function get skin() : String
      {
         return this._button.skin;
      }
      
      public function set skin(param1:String) : void
      {
         if(this._button.skin != param1)
         {
            this._button.skin = param1;
            _contentWidth = this._button.width;
            _contentHeight = this._button.height;
            callLater(this.changeList);
         }
      }
      
      public function set imageLabel(param1:String) : void
      {
         this._button.imageLabel = param1;
      }
      
      public function set imageLabelX(param1:int) : void
      {
         this._button.imageLabelX = param1;
      }
      
      public function set imageLabelY(param1:int) : void
      {
         this._button.imageLabelY = param1;
      }
      
      public function set imageLabelSizeGrid(param1:String) : void
      {
         this._button.imageLabelSizeGrid = param1;
      }
      
      public function set imageLabelRect(param1:String) : void
      {
         this._button.imageLabelRect = param1;
      }
      
      public function set enableClickMoveDownEffect(param1:Boolean) : void
      {
         this._button.enableClickMoveDownEffect = param1;
      }
      
      public function set listSkin(param1:String) : void
      {
         this._listBg.skin = param1;
         callLater(this.changeList);
      }
      
      public function set listSizeGrid(param1:String) : void
      {
         this._listBg.sizeGrid = param1;
         callLater(this.changeList);
      }
      
      public function set itemSizeGride(param1:String) : void
      {
         this._itemSizeGride = param1;
         callLater(this.changeList);
      }
      
      public function set itemSteateNum(param1:int) : void
      {
         this._itemSteateNum = param1;
         callLater(this.changeList);
      }
      
      public function set itemClipUrl(param1:String) : void
      {
         this._itemClipUrl = param1;
         callLater(this.changeList);
      }
      
      public function set itemHeight(param1:Number) : void
      {
         this._itemH = param1;
         callLater(this.changeList);
      }
      
      public function set itemLabelMargin(param1:String) : void
      {
         this._itemLabelMargin = param1;
         callLater(this.changeList);
      }
      
      public function set itemLabelStroke(param1:String) : void
      {
         this._itemLabelStroke = param1;
         callLater(this.changeList);
      }
      
      protected function changeList() : void
      {
         var _loc1_:Number = width - 2;
         var _loc2_:Number = this._itemColors[2];
         var _loc3_:Boolean = Boolean(this._itemSteateNum > 1);
         this._itemHeight = Number(this._itemH) || Number(ObjectUtils.getTextField(new TextFormat(Styles.fontName,this._itemSize)).height + 3);
         this._list.itemRender = new XML("<Box>" + "<Clip name=\'clip\' width=\'" + _loc1_ + "\' clipsUrl=\'" + this._itemClipUrl + "\' sizeGride=\'" + this._itemSizeGride + "\' height=\'" + this._itemHeight + "\' visible=\'" + _loc3_ + "\' x=\'1\' />" + "<Label name=\'label\' width=\'" + _loc1_ + "\' size=\'" + this._itemSize + "\' height=\'" + this._itemHeight + "\' color=\'" + _loc2_ + "\' margin=\'" + this._itemLabelMargin + "\' stroke=\'" + this._itemLabelStroke + "\' x=\'1\' />" + "</Box>");
         this._list.repeatY = this._visibleNum;
         this._scrollBar.x = width - this._scrollBar.width - 1;
         this._list.refresh();
      }
      
      protected function onlistItemMouse(param1:MouseEvent, param2:int) : void
      {
         var _loc4_:Box = null;
         var _loc5_:Label = null;
         var _loc6_:Clip = null;
         var _loc3_:String = param1.type;
         if(_loc3_ == MouseEvent.CLICK || _loc3_ == MouseEvent.ROLL_OVER || _loc3_ == MouseEvent.ROLL_OUT)
         {
            _loc4_ = this._list.getCell(param2);
            _loc5_ = _loc4_.getChildByName("label") as Label;
            _loc6_ = _loc4_.getChildByName("clip") as Clip;
            if(_loc3_ == MouseEvent.ROLL_OVER)
            {
               _loc6_.visible = true;
               _loc6_.frame = this._itemSteateNum - 1;
            }
            else
            {
               _loc6_.visible = Boolean(this._itemSteateNum > 1);
               _loc6_.frame = 0;
            }
            if(_loc3_ == MouseEvent.CLICK)
            {
               this.isOpen = false;
            }
         }
      }
      
      protected function changeOpen() : void
      {
         this.isOpen = !this._isOpen;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._button.width = _width;
         callLater(this.changeItem);
         callLater(this.changeList);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this._button.height = _height;
      }
      
      public function get labels() : String
      {
         return this._labels.join(",");
      }
      
      public function set labels(param1:String) : void
      {
         if(this._labels.length > 0)
         {
            this.selectedIndex = -1;
         }
         if(Boolean(param1))
         {
            this._labels = param1.split(",");
         }
         else
         {
            this._labels.length = 0;
         }
         callLater(this.changeItem);
      }
      
      protected function changeItem() : void
      {
         exeCallLater(this.changeList);
         this._listHeight = this._labels.length > 0?Number(Math.min(this._visibleNum,this._labels.length) * this._itemHeight):Number(this._itemHeight);
         this._scrollBar.height = this._listHeight - 2;
         this._listBg.width = width - 1;
         this._listBg.height = this._list.height;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         var _loc3_:int = this._labels.length;
         while(_loc2_ < _loc3_)
         {
            _loc1_.push({"label":this._labels[_loc2_]});
            _loc2_++;
         }
         this._list.array = _loc1_;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._selectedIndex != param1 || this.canForceChange)
         {
            this._list.selectedIndex = this._selectedIndex = param1;
            this._button.label = this.selectedLabel;
            sendEvent(Event.CHANGE);
            sendEvent(Event.SELECT);
            if(this._selectHandler != null)
            {
               this._selectHandler.executeWith([this._selectedIndex]);
            }
         }
      }
      
      public function resetSelect() : void
      {
         this._selectedIndex = -1;
      }
      
      public function get selectHandler() : Handler
      {
         return this._selectHandler;
      }
      
      public function set selectHandler(param1:Handler) : void
      {
         this._selectHandler = param1;
      }
      
      public function get selectedLabel() : String
      {
         return this._selectedIndex > -1 && this._selectedIndex < this._labels.length?this._labels[this._selectedIndex]:null;
      }
      
      public function set selectedLabel(param1:String) : void
      {
         this.selectedIndex = this._labels.indexOf(param1);
      }
      
      public function get visibleNum() : int
      {
         return this._visibleNum;
      }
      
      public function set visibleNum(param1:int) : void
      {
         this._visibleNum = param1;
         callLater(this.changeList);
      }
      
      public function get itemColors() : String
      {
         return String(this._itemColors);
      }
      
      public function set itemColors(param1:String) : void
      {
         this._itemColors = StringUtils.fillArray(this._itemColors,param1);
         callLater(this.changeList);
      }
      
      public function get itemSize() : int
      {
         return this._itemSize;
      }
      
      public function set itemSize(param1:int) : void
      {
         this._itemSize = param1;
         callLater(this.changeList);
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         if(this._isOpen != param1)
         {
            this._isOpen = param1;
            this._button.selected = this._isOpen;
            if(this._isOpen)
            {
               _loc2_ = localToGlobal(new Point());
               _loc3_ = _loc2_.y + this._button.height;
               _loc3_ = _loc3_ + this._listHeight <= App.stage.stageHeight?Number(_loc3_):Number(_loc2_.y - this._listHeight);
               this._list.setPosition(_loc2_.x,_loc3_);
               this._listBg.setPosition(_loc2_.x,_loc3_);
               App.stage.addChild(this._listBg);
               App.stage.addChild(this._list);
               App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.removeList);
               this._list.scrollTo(this._selectedIndex + this._visibleNum < this._list.length?int(this._selectedIndex):int(this._list.length - this._visibleNum));
            }
            else
            {
               this._listBg.remove();
               this._list.remove();
               App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.removeList);
            }
         }
      }
      
      protected function removeList(param1:Event) : void
      {
         if(param1 == null || param1.target == this._list.content || !this._button.contains(param1.target as DisplayObject) && !this._list.contains(param1.target as DisplayObject))
         {
            this.isOpen = false;
         }
      }
      
      public function get scrollBarSkin() : String
      {
         return this._scrollBar.skin;
      }
      
      public function set scrollBarSkin(param1:String) : void
      {
         this._scrollBar.skin = param1;
      }
      
      public function get sizeGrid() : String
      {
         return this._button.sizeGrid;
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._button.sizeGrid = param1;
      }
      
      public function get scrollBar() : VScrollBar
      {
         return this._scrollBar;
      }
      
      public function get button() : Button
      {
         return this._button;
      }
      
      public function get list() : List
      {
         return this._list;
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is int || param1 is String)
         {
            this.selectedIndex = int(param1);
         }
         else if(param1 is Array)
         {
            this.labels = (param1 as Array).join(",");
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      public function get labelColors() : String
      {
         return this._button.labelColors;
      }
      
      public function set labelColors(param1:String) : void
      {
         this._button.labelColors = param1;
      }
      
      public function get labelMargin() : String
      {
         return this._button.btnLabel.margin;
      }
      
      public function set labelMargin(param1:String) : void
      {
         this._button.btnLabel.margin = param1;
      }
      
      public function get labelStroke() : String
      {
         return this._button.btnLabel.stroke;
      }
      
      public function set labelStroke(param1:String) : void
      {
         this._button.btnLabel.stroke = param1;
      }
      
      public function get labelSize() : Object
      {
         return this._button.btnLabel.size;
      }
      
      public function set labelSize(param1:Object) : void
      {
         this._button.btnLabel.size = param1;
      }
      
      public function get labelBold() : Object
      {
         return this._button.btnLabel.bold;
      }
      
      public function set labelBold(param1:Object) : void
      {
         this._button.btnLabel.bold = param1;
      }
      
      public function get labelFont() : String
      {
         return this._button.btnLabel.font;
      }
      
      public function set labelFont(param1:String) : void
      {
         this._button.btnLabel.font = param1;
      }
      
      public function set buttonLabel(param1:String) : void
      {
         this._button.label = param1;
      }
      
      public function get stateNum() : int
      {
         return this._button.stateNum;
      }
      
      public function set stateNum(param1:int) : void
      {
         this._button.stateNum = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._button && this._button.dispose();
         this._list && this._list.dispose();
         this._listBg && this._listBg.dispose();
         this._scrollBar && this._scrollBar.dispose();
         this._button = null;
         this._list = null;
         this._scrollBar = null;
         this._itemColors = null;
         this._labels = null;
         this._selectHandler = null;
      }
   }
}
