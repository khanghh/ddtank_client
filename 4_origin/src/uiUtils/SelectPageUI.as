package uiUtils
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SelectPageUI extends Component
   {
      
      public static const FirstBtn:String = "firstBtn";
      
      public static const PrevBtn:String = "prevBtn";
      
      public static const NextBtn:String = "nextBtn";
      
      public static const LastBtn:String = "lastBtn";
      
      public static const P_FirstBtn:String = "firstBtn";
      
      public static const P_PrevBtn:String = "prevBtn";
      
      public static const P_NextBtn:String = "nextBtn";
      
      public static const P_LastBtn:String = "lastBtn";
      
      public static const P_PageText:String = "pageText";
      
      public static const P_pageImage:String = "pageImage";
      
      public static const P_spacing:String = "spacing";
       
      
      private const MIN_PAGE:int = 1;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int;
      
      protected var _firstBtnStyle:String = "core.uiUtils.firstPageBtn";
      
      protected var _prevBtnStyle:String = "core.uiUtils.prevPageBtn";
      
      protected var _nextBtnStyle:String = "core.uiUtils.nextPageBtn";
      
      protected var _lastBtnStyle:String = "core.uiUtils.lastPageBtn";
      
      protected var _pageTextStyle:String = "core.uiUtils.pageText";
      
      protected var _pageImageStyle:String = "core.uiUtils.pageImage";
      
      protected var _firstBtn:SimpleBitmapButton;
      
      protected var _prevBtn:SimpleBitmapButton;
      
      protected var _nextBtn:SimpleBitmapButton;
      
      protected var _lastBtn:SimpleBitmapButton;
      
      protected var _pageText:FilterFrameText;
      
      protected var _pageImage:Image;
      
      protected var _isLoop:Boolean;
      
      protected var _clickBtnType:String;
      
      protected var _spacing:int = 0;
      
      public function SelectPageUI()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         if(_firstBtn)
         {
            addChild(_firstBtn);
         }
         if(_prevBtn)
         {
            addChild(_prevBtn);
         }
         if(_nextBtn)
         {
            addChild(_nextBtn);
         }
         if(_lastBtn)
         {
            addChild(_lastBtn);
         }
         if(_pageImage)
         {
            addChild(_pageImage);
         }
         if(_pageText)
         {
            addChild(_pageText);
         }
      }
      
      public function set maxPage(value:int) : void
      {
         _maxPage = value;
         _pageText.text = getCurrentPageViewToString();
      }
      
      public function set firstButtonStyle(value:String) : void
      {
         _firstBtnStyle = value;
         onPropertiesChanged("firstBtn");
      }
      
      public function set prevButtonStyle(value:String) : void
      {
         _prevBtnStyle = value;
         onPropertiesChanged("prevBtn");
      }
      
      public function set nextButtonStyle(value:String) : void
      {
         _nextBtnStyle = value;
         onPropertiesChanged("nextBtn");
      }
      
      public function set lastButtonStyle(value:String) : void
      {
         _lastBtnStyle = value;
         onPropertiesChanged("lastBtn");
      }
      
      public function set pageTextStyle(value:String) : void
      {
         _pageTextStyle = value;
         onPropertiesChanged("pageText");
      }
      
      public function set pageImageStyle(value:String) : void
      {
         _pageImageStyle = value;
         onPropertiesChanged("pageImage");
      }
      
      public function set spacing(value:int) : void
      {
         _spacing = value;
         onPropertiesChanged("spacing");
      }
      
      public function get spacing() : int
      {
         return _spacing;
      }
      
      private function __onClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:* = e.currentTarget;
         if(_firstBtn !== _loc2_)
         {
            if(_prevBtn !== _loc2_)
            {
               if(_nextBtn !== _loc2_)
               {
                  if(_lastBtn === _loc2_)
                  {
                     if(_currentPage == _maxPage)
                     {
                        return;
                     }
                     _currentPage = _maxPage;
                     _clickBtnType = "lastBtn";
                  }
               }
               else
               {
                  _currentPage = _currentPage + 1;
                  if(_currentPage + 1 > _maxPage)
                  {
                     if(_isLoop)
                     {
                        _currentPage = 1;
                     }
                     else
                     {
                        _currentPage = _maxPage;
                        return;
                     }
                  }
                  _clickBtnType = "nextBtn";
               }
            }
            else
            {
               _currentPage = _currentPage - 1;
               if(_currentPage - 1 < 1)
               {
                  if(_isLoop)
                  {
                     _currentPage = _maxPage;
                  }
                  else
                  {
                     _currentPage = 1;
                     return;
                  }
               }
               _clickBtnType = "prevBtn";
            }
         }
         else
         {
            if(_currentPage == 1)
            {
               return;
            }
            _currentPage = 1;
            _clickBtnType = "firstBtn";
         }
         updatePage();
      }
      
      protected function updatePage() : void
      {
         _pageText.text = getCurrentPageViewToString();
         dispatchEvent(new Event("change"));
      }
      
      public function get clickBtnType() : String
      {
         return _clickBtnType;
      }
      
      public function get maxPage() : int
      {
         return _maxPage;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["firstBtn"])
         {
            disposeFirstBtn();
            if(_firstBtnStyle != "")
            {
               _firstBtn = ComponentFactory.Instance.creatComponentByStylename(_firstBtnStyle);
               _firstBtn.addEventListener("click",__onClick);
            }
         }
         if(_changedPropeties["prevBtn"])
         {
            disposePrevBtn();
            if(_prevBtnStyle != "")
            {
               _prevBtn = ComponentFactory.Instance.creatComponentByStylename(_prevBtnStyle);
               _prevBtn.addEventListener("click",__onClick);
            }
         }
         if(_changedPropeties["nextBtn"])
         {
            disposeNextBtn();
            if(_nextBtnStyle != "")
            {
               _nextBtn = ComponentFactory.Instance.creatComponentByStylename(_nextBtnStyle);
               _nextBtn.addEventListener("click",__onClick);
            }
         }
         if(_changedPropeties["lastBtn"])
         {
            disposeLastBtn();
            if(_lastBtnStyle != "")
            {
               _lastBtn = ComponentFactory.Instance.creatComponentByStylename(_lastBtnStyle);
               _lastBtn.addEventListener("click",__onClick);
            }
         }
         if(_changedPropeties["pageText"])
         {
            disposePageText();
            if(_pageTextStyle != "")
            {
               _pageText = ComponentFactory.Instance.creatComponentByStylename(_pageTextStyle);
            }
         }
         if(_changedPropeties["pageImage"])
         {
            disposePageImage();
            if(_pageImageStyle != "")
            {
               _pageImage = ComponentFactory.Instance.creat(_pageImageStyle);
            }
         }
         super.onProppertiesUpdate();
         arrange();
      }
      
      public function arrange() : void
      {
         var xpos:int = 0;
         if(_spacing > 0)
         {
            if(_firstBtn)
            {
               _firstBtn.x = 0;
               xpos = xpos + _firstBtn.width + spacing;
            }
            if(_prevBtn)
            {
               _prevBtn.x = xpos;
               xpos = xpos + _prevBtn.width + spacing;
            }
            if(_pageImage)
            {
               _pageImage.x = xpos;
               xpos = xpos + _pageImage.width + spacing;
            }
            if(_pageText)
            {
               if(_pageImage)
               {
                  _pageText.x = _pageImage.x - (_pageText.width - _pageImage.width) / 2;
               }
               else
               {
                  _pageText.x = xpos;
                  xpos = xpos + _pageText.width + spacing;
               }
            }
            if(_nextBtn)
            {
               _nextBtn.x = xpos;
               xpos = xpos + _nextBtn.width + spacing;
            }
            if(_lastBtn)
            {
               _lastBtn.x = xpos;
            }
         }
      }
      
      public function set currentPage(value:int) : void
      {
         _currentPage = value;
         _pageText.text = getCurrentPageViewToString();
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
         _isLoop = value;
      }
      
      public function set isSimple(value:Boolean) : void
      {
         if(value)
         {
            _firstBtnStyle = "";
            _lastBtnStyle = "";
            disposeFirstBtn();
            disposeLastBtn();
         }
      }
      
      public function set isDefault(value:Boolean) : void
      {
         if(value)
         {
            beginChanges();
            firstButtonStyle = _firstBtnStyle;
            prevButtonStyle = _prevBtnStyle;
            nextButtonStyle = _nextBtnStyle;
            lastButtonStyle = _lastBtnStyle;
            pageTextStyle = _pageTextStyle;
            pageImageStyle = _pageImageStyle;
            commitChanges();
         }
      }
      
      private function getCurrentPageViewToString() : String
      {
         var current:int = _currentPage == 0?1:_currentPage;
         var max:int = _maxPage == 0?1:_maxPage;
         var str:String = current + "/" + max;
         return str;
      }
      
      public function get firstBtn() : SimpleBitmapButton
      {
         return _firstBtn;
      }
      
      public function get prevBtn() : SimpleBitmapButton
      {
         return _prevBtn;
      }
      
      public function get nextBtn() : SimpleBitmapButton
      {
         return _nextBtn;
      }
      
      public function get lastBtn() : SimpleBitmapButton
      {
         return _lastBtn;
      }
      
      protected function disposeFirstBtn() : void
      {
         if(_firstBtn)
         {
            _firstBtn.removeEventListener("click",__onClick);
            ObjectUtils.disposeObject(_firstBtn);
            _firstBtn = null;
         }
      }
      
      protected function disposePrevBtn() : void
      {
         if(_prevBtn)
         {
            _prevBtn.removeEventListener("click",__onClick);
            ObjectUtils.disposeObject(_prevBtn);
            _prevBtn = null;
         }
      }
      
      protected function disposeNextBtn() : void
      {
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onClick);
            ObjectUtils.disposeObject(_nextBtn);
            _nextBtn = null;
         }
      }
      
      protected function disposeLastBtn() : void
      {
         if(_lastBtn)
         {
            _lastBtn.removeEventListener("click",__onClick);
            ObjectUtils.disposeObject(_lastBtn);
            _lastBtn = null;
         }
      }
      
      protected function disposePageText() : void
      {
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
      }
      
      protected function disposePageImage() : void
      {
         ObjectUtils.disposeObject(_pageImage);
         _pageImage = null;
      }
      
      override public function dispose() : void
      {
         disposeFirstBtn();
         disposePrevBtn();
         disposeNextBtn();
         disposeLastBtn();
         disposePageText();
         disposePageImage();
         super.dispose();
      }
   }
}
