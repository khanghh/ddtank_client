package morn.core.ex
{
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
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
      
      public function PageNavigaterEx(){super();}
      
      override protected function preinitialize() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      protected function checkBtnState() : void{}
      
      protected function updatePage() : void{}
      
      protected function getCurrentPageViewToString() : String{return null;}
      
      protected function createButton(param1:String, param2:String) : Button{return null;}
      
      protected function updatePageNum() : void{}
      
      public function get maxPage() : int{return 0;}
      
      public function set maxPage(param1:int) : void{}
      
      public function set currentPage(param1:int) : void{}
      
      public function get currentPage() : int{return 0;}
      
      public function get isLoop() : Boolean{return false;}
      
      public function set isLoop(param1:Boolean) : void{}
      
      public function get spacing() : int{return 0;}
      
      public function set spacing(param1:int) : void{}
      
      public function set pageNumBgStyle(param1:String) : void{}
      
      public function set firstButtonStyle(param1:String) : void{}
      
      public function set prevButtonStyle(param1:String) : void{}
      
      public function set nextButtonStyle(param1:String) : void{}
      
      public function set lastButtonStyle(param1:String) : void{}
      
      protected function changeButton(param1:String, param2:String) : void{}
      
      public function set pageNumBgSizeGrid(param1:String) : void{}
      
      public function set pageNumSize(param1:String) : void{}
      
      public function set pageNumAlign(param1:String) : void{}
      
      public function set pageNumXOffset(param1:int) : void{}
      
      public function get selectHandler() : Handler{return null;}
      
      public function set selectHandler(param1:Handler) : void{}
      
      public function set pageNumStroke(param1:String) : void{}
      
      public function set pageNumStyle(param1:String) : void{}
      
      protected function updatePageNumStyle(param1:String) : void{}
      
      public function get type() : String{return null;}
      
      public function set type(param1:String) : void{}
      
      protected function updateComponent() : void{}
      
      override public function dispose() : void{}
   }
}
