package morn.core.ex
{
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Component;
   import morn.core.components.HBox;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   public class PageNavigaterEx extends Component
   {
      
      protected static const FIRSTBUTTON_STYLE:String = "asset.ui.pageNavBtn.first2";
      
      protected static const PREVBUTTON_STYLE:String = "asset.ui.pageNavBtn.pre2";
      
      protected static const NEXTBUTTON_STYLE:String = "asset.ui.pageNavBtn.next2";
      
      protected static const LASTBUTTON_STYLE:String = "asset.ui.pageNavBtn.last2";
      
      protected static const PAGEIMG_STYLE:String = "asset.ui.combox.inputBg1";
      
      private static const FIRSTBTN_NAME:String = "firstBtn";
      
      private static const PREVBTN_NAME:String = "prevBtn";
      
      private static const NEXTBTN_NAME:String = "nextBtn";
      
      private static const LASTBTN_NAME:String = "lastBtn";
      
      protected static const PAGEBG_WIDTH:int = 50;
      
      protected static const SIMPLE:String = "simple";
      
      protected static const COMPLEXITY:String = "complexity";
      
      protected static const PAGENUM_STROKE:String = "0x000000,1,4,4,10";
      
      protected static const PAGENUM_BGSIZE:String = "80,25";
      
      protected static const PAGENUM_BGGRID:String = "5,5,10,10,0";
      
      public static var lableStyle:Array = ["Arial",14,16777215,"false",2];
       
      
      private var _hBox:HBox;
      
      protected const MIN_PAGE:int = 1;
      
      protected var _firstBtn:Button;
      
      protected var _prevBtn:Button;
      
      protected var _nextBtn:Button;
      
      protected var _lastBtn:Button;
      
      protected var _pageNumText:Label;
      
      protected var _pageNumBg:Image;
      
      protected var _pageNumAlign:String = "center";
      
      protected var _isLoop:Boolean = false;
      
      protected var _spacing:int;
      
      protected var _currentPage:int = 1;
      
      protected var _maxPage:int = 1;
      
      protected var _pageNumXOffset:int;
      
      protected var _pageSpri:Box;
      
      protected var _selectHandler:Handler;
      
      protected var _type:String = "complexity";
      
      public function PageNavigaterEx()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         mouseChildren = true;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _hBox = new HBox();
         addChild(new HBox());
         _firstBtn = createButton("asset.ui.pageNavBtn.first2","firstBtn");
         _hBox.addChild(createButton("asset.ui.pageNavBtn.first2","firstBtn"));
         _prevBtn = createButton("asset.ui.pageNavBtn.pre2","prevBtn");
         _hBox.addChild(createButton("asset.ui.pageNavBtn.pre2","prevBtn"));
         _pageSpri = new Box();
         _hBox.addChild(new Box());
         _pageNumBg = new Image("asset.ui.combox.inputBg1");
         _pageSpri.addChild(new Image("asset.ui.combox.inputBg1"));
         _pageNumText = new Label();
         _pageSpri.addChild(new Label());
         _nextBtn = createButton("asset.ui.pageNavBtn.next2","nextBtn");
         _hBox.addChild(createButton("asset.ui.pageNavBtn.next2","nextBtn"));
         _lastBtn = createButton("asset.ui.pageNavBtn.last2","lastBtn");
         _hBox.addChild(createButton("asset.ui.pageNavBtn.last2","lastBtn"));
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _pageNumBg.smoothing = true;
         _hBox.align = "top";
         pageNumBgSizeGrid = "5,5,10,10,0";
         pageNumSize = "80,25";
         updatePageNumStyle("");
         _pageNumText.stroke = "0x000000,1,4,4,10";
         callLater(updatePage);
      }
      
      protected function __onClick(evt:MouseEvent) : void
      {
         var _loc2_:* = evt.target.name;
         if("firstBtn" !== _loc2_)
         {
            if("prevBtn" !== _loc2_)
            {
               if("nextBtn" !== _loc2_)
               {
                  if("lastBtn" === _loc2_)
                  {
                     if(currentPage != maxPage)
                     {
                        currentPage = maxPage;
                     }
                  }
               }
               else if(currentPage + 1 > maxPage)
               {
                  if(isLoop)
                  {
                     currentPage = 1;
                  }
                  else
                  {
                     _currentPage = maxPage;
                  }
               }
               else
               {
                  currentPage = currentPage + 1;
               }
            }
            else
            {
               if(currentPage - 1 < 1)
               {
                  if(isLoop)
                  {
                     currentPage = maxPage;
                  }
                  else
                  {
                     _currentPage = 1;
                  }
                  return;
               }
               currentPage = currentPage - 1;
            }
         }
         else
         {
            if(currentPage == 1)
            {
               return;
            }
            currentPage = 1;
         }
      }
      
      protected function checkBtnState() : void
      {
         var isFirst:* = false;
         var isLast:* = false;
         if(!isLoop)
         {
            isFirst = currentPage == 1;
            isLast = currentPage == maxPage;
            if(isFirst || _prevBtn.disabled)
            {
               var _loc3_:* = isFirst;
               _prevBtn.disabled = _loc3_;
               _firstBtn.disabled = _loc3_;
            }
            if(isLast || _nextBtn.disabled)
            {
               _loc3_ = isLast;
               _nextBtn.disabled = _loc3_;
               _lastBtn.disabled = _loc3_;
            }
         }
      }
      
      protected function updatePage() : void
      {
         _pageNumText.text = getCurrentPageViewToString();
         checkBtnState();
         updatePageNum();
         if(_selectHandler != null)
         {
            _selectHandler.executeWith([currentPage]);
         }
      }
      
      protected function getCurrentPageViewToString() : String
      {
         var current:int = Math.max(currentPage,1);
         var max:int = Math.max(_maxPage,1);
         var str:String = current + "/" + max;
         return str;
      }
      
      protected function createButton(style:String, name:String) : Button
      {
         var btn:Button = new Button(style);
         btn.name = name;
         btn.stateNum = 1;
         btn.addEventListener("click",__onClick);
         return btn;
      }
      
      protected function updatePageNum() : void
      {
         var temX:* = 0;
         _pageNumText.y = _pageNumBg.height - _pageNumText.height >> 1;
         var _loc2_:* = _pageNumAlign;
         if("left" !== _loc2_)
         {
            if("center" !== _loc2_)
            {
               if("right" !== _loc2_)
               {
                  _pageNumText.x = _pageNumXOffset;
               }
               else
               {
                  temX = int(_pageNumBg.width - _pageNumText.width);
                  _pageNumText.x = temX + _pageNumXOffset;
               }
            }
            else
            {
               temX = _pageNumBg.width - _pageNumText.width >> 1;
               _pageNumText.x = temX + _pageNumXOffset;
            }
         }
         else
         {
            _pageNumText.x = _pageNumXOffset;
         }
      }
      
      public function get maxPage() : int
      {
         return _maxPage;
      }
      
      public function set maxPage(value:int) : void
      {
         if(_maxPage == value)
         {
            return;
         }
         _maxPage = value;
         callLater(updatePage);
      }
      
      public function set currentPage(value:int) : void
      {
         _currentPage = value;
         callLater(updatePage);
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get isLoop() : Boolean
      {
         return _isLoop;
      }
      
      public function set isLoop(value:Boolean) : void
      {
         if(_isLoop == value)
         {
            return;
         }
         _isLoop = value;
      }
      
      public function get spacing() : int
      {
         return _spacing;
      }
      
      public function set spacing(value:int) : void
      {
         if(_spacing == value)
         {
            return;
         }
         _spacing = value;
         _hBox.space = spacing;
      }
      
      public function set pageNumBgStyle(value:String) : void
      {
         _pageNumBg.skin = value;
      }
      
      public function set firstButtonStyle(value:String) : void
      {
         changeButton("firstBtn",value);
      }
      
      public function set prevButtonStyle(value:String) : void
      {
         changeButton("prevBtn",value);
      }
      
      public function set nextButtonStyle(value:String) : void
      {
         changeButton("nextBtn",value);
      }
      
      public function set lastButtonStyle(value:String) : void
      {
         changeButton("lastBtn",value);
      }
      
      protected function changeButton(name:String, style:String) : void
      {
         var btn:Button = _hBox.getChildByName(name) as Button;
         if(btn.skin != style)
         {
            btn.skin = style;
            callLater(_hBox.refresh);
         }
      }
      
      public function set pageNumBgSizeGrid(value:String) : void
      {
         _pageNumBg.sizeGrid = value;
      }
      
      public function set pageNumSize(value:String) : void
      {
         var temArr:Array = value.split(",");
         if(temArr == null || temArr.length <= 1)
         {
            return;
         }
         var w:int = temArr[0];
         var h:int = temArr[1];
         _pageNumBg.width = w;
         _pageNumBg.height = h;
         callLater(updatePageNum);
      }
      
      public function set pageNumAlign(value:String) : void
      {
         _pageNumAlign = value;
         callLater(updatePageNum);
      }
      
      public function set pageNumXOffset(value:int) : void
      {
         _pageNumXOffset = value;
         callLater(updatePageNum);
      }
      
      public function get selectHandler() : Handler
      {
         return _selectHandler;
      }
      
      public function set selectHandler(value:Handler) : void
      {
         _selectHandler = value;
      }
      
      public function set pageNumStroke(value:String) : void
      {
         _pageNumText.stroke = value;
         callLater(updatePageNum);
      }
      
      public function set pageNumStyle(value:String) : void
      {
         updatePageNumStyle(value);
         callLater(updatePageNum);
      }
      
      protected function updatePageNumStyle(value:String) : void
      {
         var temAr:Array = StringUtils.fillArray(lableStyle,value);
         _pageNumText.format = new TextFormat(temAr[0],temAr[1],temAr[2],temAr[3]);
         _pageNumText.letterSpacing = temAr[4];
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(value:String) : void
      {
         if(_type == value)
         {
            return;
         }
         _type = value;
         updateComponent();
      }
      
      protected function updateComponent() : void
      {
         if(_hBox == null)
         {
            return;
         }
         var _loc1_:* = type;
         if("simple" !== _loc1_)
         {
            if("complexity" === _loc1_)
            {
               if(_hBox.numChildren < 5)
               {
                  _hBox.addChildAt(_firstBtn,0);
                  _hBox.addChildAt(_lastBtn,_hBox.numChildren - 1);
               }
            }
         }
         else if(_hBox.numChildren > 3)
         {
            _hBox.removeChild(_firstBtn);
            _hBox.removeChild(_lastBtn);
         }
      }
      
      override public function dispose() : void
      {
         _firstBtn && _firstBtn.dispose();
         _prevBtn && _prevBtn.dispose();
         _nextBtn && _nextBtn.dispose();
         _lastBtn && _lastBtn.dispose();
         _pageNumBg && _pageNumBg.dispose();
         _pageNumText && _pageNumText.dispose();
         _hBox && _hBox.removeChildren();
         _pageSpri = null;
         _firstBtn = null;
         _prevBtn = null;
         _nextBtn = null;
         _lastBtn = null;
         _pageNumBg = null;
         _pageNumText = null;
         _hBox = null;
         super.dispose();
      }
   }
}
