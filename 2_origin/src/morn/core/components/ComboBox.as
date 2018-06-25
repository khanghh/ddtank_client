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
      
      public function ComboBox(skin:String = null, labels:String = null)
      {
         _itemColors = Styles.comboBoxItemColors;
         _itemSize = Styles.fontSize;
         _labels = [];
         super();
         this.skin = skin;
         this.labels = labels;
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         _button = new Button();
         addChild(new Button());
         _listBg = new Image();
         _list = new List();
         _list.mouseHandler = new Handler(onlistItemMouse);
         _scrollBar = new VScrollBar();
         _list.addChild(_scrollBar);
      }
      
      override protected function initialize() : void
      {
         _button.btnLabel.align = "left";
         _button.enableClickMoveDownEffect = false;
         _button.labelMargin = "5";
         _button.addEventListener("mouseDown",onButtonMouseDown);
         _list.addEventListener("change",onListChange);
         _scrollBar.name = "scrollBar";
         _scrollBar.y = 1;
      }
      
      private function onButtonMouseDown(e:MouseEvent) : void
      {
         callLater(changeOpen);
      }
      
      protected function onListChange(e:Event) : void
      {
         selectedIndex = _list.selectedIndex;
      }
      
      public function get skin() : String
      {
         return _button.skin;
      }
      
      public function set skin(value:String) : void
      {
         if(_button.skin != value)
         {
            _button.skin = value;
            _contentWidth = _button.width;
            _contentHeight = _button.height;
            callLater(changeList);
         }
      }
      
      public function set imageLabel(value:String) : void
      {
         _button.imageLabel = value;
      }
      
      public function set imageLabelX(value:int) : void
      {
         _button.imageLabelX = value;
      }
      
      public function set imageLabelY(value:int) : void
      {
         _button.imageLabelY = value;
      }
      
      public function set imageLabelSizeGrid(value:String) : void
      {
         _button.imageLabelSizeGrid = value;
      }
      
      public function set imageLabelRect(value:String) : void
      {
         _button.imageLabelRect = value;
      }
      
      public function set enableClickMoveDownEffect(value:Boolean) : void
      {
         _button.enableClickMoveDownEffect = value;
      }
      
      public function set listSkin(value:String) : void
      {
         _listBg.skin = value;
         callLater(changeList);
      }
      
      public function set listSizeGrid(value:String) : void
      {
         _listBg.sizeGrid = value;
         callLater(changeList);
      }
      
      public function set itemSizeGride(value:String) : void
      {
         _itemSizeGride = value;
         callLater(changeList);
      }
      
      public function set itemSteateNum(value:int) : void
      {
         _itemSteateNum = value;
         callLater(changeList);
      }
      
      public function set itemClipUrl(value:String) : void
      {
         _itemClipUrl = value;
         callLater(changeList);
      }
      
      public function set itemHeight(value:Number) : void
      {
         _itemH = value;
         callLater(changeList);
      }
      
      public function set itemLabelMargin(value:String) : void
      {
         _itemLabelMargin = value;
         callLater(changeList);
      }
      
      public function set itemLabelStroke(value:String) : void
      {
         _itemLabelStroke = value;
         callLater(changeList);
      }
      
      protected function changeList() : void
      {
         var labelWidth:Number = width - 2;
         var labelColor:Number = _itemColors[2];
         var v:* = _itemSteateNum > 1;
         _itemHeight = _itemH || Number(ObjectUtils.getTextField(new TextFormat(Styles.fontName,_itemSize)).height + 3);
         _list.itemRender = new XML("<Box><Clip name=\'clip\' width=\'" + labelWidth + "\' clipsUrl=\'" + _itemClipUrl + "\' sizeGride=\'" + _itemSizeGride + "\' height=\'" + _itemHeight + "\' visible=\'" + v + "\' x=\'1\' />" + "<Label name=\'label\' width=\'" + labelWidth + "\' size=\'" + _itemSize + "\' height=\'" + _itemHeight + "\' color=\'" + labelColor + "\' margin=\'" + _itemLabelMargin + "\' stroke=\'" + _itemLabelStroke + "\' x=\'1\' />" + "</Box>");
         _list.repeatY = _visibleNum;
         _scrollBar.x = width - _scrollBar.width - 1;
         _list.refresh();
      }
      
      protected function onlistItemMouse(e:MouseEvent, index:int) : void
      {
         var box:* = null;
         var label:* = null;
         var clip:* = null;
         var type:String = e.type;
         if(type == "click" || type == "rollOver" || type == "rollOut")
         {
            box = _list.getCell(index);
            label = box.getChildByName("label") as Label;
            clip = box.getChildByName("clip") as Clip;
            if(type == "rollOver")
            {
               clip.visible = true;
               clip.frame = _itemSteateNum - 1;
            }
            else
            {
               clip.visible = _itemSteateNum > 1;
               clip.frame = 0;
            }
            if(type == "click")
            {
               isOpen = false;
            }
         }
      }
      
      protected function changeOpen() : void
      {
         isOpen = !_isOpen;
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _button.width = _width;
         callLater(changeItem);
         callLater(changeList);
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _button.height = _height;
      }
      
      public function get labels() : String
      {
         return _labels.join(",");
      }
      
      public function set labels(value:String) : void
      {
         if(_labels.length > 0)
         {
            selectedIndex = -1;
         }
         if(value)
         {
            _labels = value.split(",");
         }
         else
         {
            _labels.length = 0;
         }
         callLater(changeItem);
      }
      
      protected function changeItem() : void
      {
         var i:int = 0;
         var n:int = 0;
         exeCallLater(changeList);
         _listHeight = _labels.length > 0?Math.min(_visibleNum,_labels.length) * _itemHeight:Number(_itemHeight);
         _scrollBar.height = _listHeight - 2;
         _listBg.width = width - 1;
         _listBg.height = _list.height;
         var a:Array = [];
         for(i = 0,n = _labels.length; i < n; )
         {
            a.push({"label":_labels[i]});
            i++;
         }
         _list.array = a;
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function set selectedIndex(value:int) : void
      {
         if(_selectedIndex != value || canForceChange)
         {
            _selectedIndex = value;
            _list.selectedIndex = value;
            _button.label = selectedLabel;
            sendEvent("change");
            sendEvent("select");
            if(_selectHandler != null)
            {
               _selectHandler.executeWith([_selectedIndex]);
            }
         }
      }
      
      public function resetSelect() : void
      {
         _selectedIndex = -1;
      }
      
      public function get selectHandler() : Handler
      {
         return _selectHandler;
      }
      
      public function set selectHandler(value:Handler) : void
      {
         _selectHandler = value;
      }
      
      public function get selectedLabel() : String
      {
         return _selectedIndex > -1 && _selectedIndex < _labels.length?_labels[_selectedIndex]:null;
      }
      
      public function set selectedLabel(value:String) : void
      {
         selectedIndex = _labels.indexOf(value);
      }
      
      public function get visibleNum() : int
      {
         return _visibleNum;
      }
      
      public function set visibleNum(value:int) : void
      {
         _visibleNum = value;
         callLater(changeList);
      }
      
      public function get itemColors() : String
      {
         return String(_itemColors);
      }
      
      public function set itemColors(value:String) : void
      {
         _itemColors = StringUtils.fillArray(_itemColors,value);
         callLater(changeList);
      }
      
      public function get itemSize() : int
      {
         return _itemSize;
      }
      
      public function set itemSize(value:int) : void
      {
         _itemSize = value;
         callLater(changeList);
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         var p:* = null;
         var py:Number = NaN;
         if(_isOpen != value)
         {
            _isOpen = value;
            _button.selected = _isOpen;
            if(_isOpen)
            {
               p = localToGlobal(new Point());
               py = p.y + _button.height;
               py = py + _listHeight <= App.stage.stageHeight?py:Number(p.y - _listHeight);
               _list.setPosition(p.x,py);
               _listBg.setPosition(p.x,py);
               App.stage.addChild(_listBg);
               App.stage.addChild(_list);
               App.stage.addEventListener("mouseDown",removeList);
               _list.scrollTo(_selectedIndex + _visibleNum < _list.length?_selectedIndex:_list.length - _visibleNum);
            }
            else
            {
               _listBg.remove();
               _list.remove();
               App.stage.removeEventListener("mouseDown",removeList);
            }
         }
      }
      
      protected function removeList(e:Event) : void
      {
         if(e == null || e.target == _list.content || !_button.contains(e.target as DisplayObject) && !_list.contains(e.target as DisplayObject))
         {
            isOpen = false;
         }
      }
      
      public function get scrollBarSkin() : String
      {
         return _scrollBar.skin;
      }
      
      public function set scrollBarSkin(value:String) : void
      {
         _scrollBar.skin = value;
      }
      
      public function get sizeGrid() : String
      {
         return _button.sizeGrid;
      }
      
      public function set sizeGrid(value:String) : void
      {
         _button.sizeGrid = value;
      }
      
      public function get scrollBar() : VScrollBar
      {
         return _scrollBar;
      }
      
      public function get button() : Button
      {
         return _button;
      }
      
      public function get list() : List
      {
         return _list;
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is int || value is String)
         {
            selectedIndex = int(value);
         }
         else if(value is Array)
         {
            labels = (value as Array).join(",");
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      public function get labelColors() : String
      {
         return _button.labelColors;
      }
      
      public function set labelColors(value:String) : void
      {
         _button.labelColors = value;
      }
      
      public function get labelMargin() : String
      {
         return _button.btnLabel.margin;
      }
      
      public function set labelMargin(value:String) : void
      {
         _button.btnLabel.margin = value;
      }
      
      public function get labelStroke() : String
      {
         return _button.btnLabel.stroke;
      }
      
      public function set labelStroke(value:String) : void
      {
         _button.btnLabel.stroke = value;
      }
      
      public function get labelSize() : Object
      {
         return _button.btnLabel.size;
      }
      
      public function set labelSize(value:Object) : void
      {
         _button.btnLabel.size = value;
      }
      
      public function get labelBold() : Object
      {
         return _button.btnLabel.bold;
      }
      
      public function set labelBold(value:Object) : void
      {
         _button.btnLabel.bold = value;
      }
      
      public function get labelFont() : String
      {
         return _button.btnLabel.font;
      }
      
      public function set labelFont(value:String) : void
      {
         _button.btnLabel.font = value;
      }
      
      public function set buttonLabel(value:String) : void
      {
         _button.label = value;
      }
      
      public function get stateNum() : int
      {
         return _button.stateNum;
      }
      
      public function set stateNum(value:int) : void
      {
         _button.stateNum = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _button && _button.dispose();
         _list && _list.dispose();
         _listBg && _listBg.dispose();
         _scrollBar && _scrollBar.dispose();
         _button = null;
         _list = null;
         _scrollBar = null;
         _itemColors = null;
         _labels = null;
         _selectHandler = null;
      }
   }
}
