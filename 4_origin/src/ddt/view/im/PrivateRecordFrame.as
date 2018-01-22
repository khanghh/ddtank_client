package ddt.view.im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class PrivateRecordFrame extends Frame
   {
      
      public static const PAGE_MESSAGE:int = 20;
      
      public static const CLOSE:String = "close";
       
      
      protected var _content:TextArea;
      
      protected var _contentBG:ScaleBitmapImage;
      
      protected var _close:TextButton;
      
      protected var _messages:Vector.<Object>;
      
      protected var _totalPage:int = 1;
      
      protected var _currentPage:int;
      
      private var _pageBG:Bitmap;
      
      private var _firstPage:SimpleBitmapButton;
      
      private var _prePage:SimpleBitmapButton;
      
      private var _nextPage:SimpleBitmapButton;
      
      private var _lastPage:SimpleBitmapButton;
      
      private var _pageInput:TextInput;
      
      protected var _pageWord:FilterFrameText;
      
      public function PrivateRecordFrame()
      {
         super();
         _titleText = LanguageMgr.GetTranslation("IM.ChatFrame.recordFrame.title");
         _contentBG = ComponentFactory.Instance.creatComponentByStylename("recordFrame.contentBG");
         _content = ComponentFactory.Instance.creatComponentByStylename("recordFrame.content");
         _close = ComponentFactory.Instance.creatComponentByStylename("recordFrame.close");
         _close.text = LanguageMgr.GetTranslation("tank.invite.InviteView.close");
         _pageBG = ComponentFactory.Instance.creatBitmap("asset.recordFrame.pageBG");
         _firstPage = ComponentFactory.Instance.creatComponentByStylename("recordFrame.first");
         _prePage = ComponentFactory.Instance.creatComponentByStylename("recordFrame.pre");
         _nextPage = ComponentFactory.Instance.creatComponentByStylename("recordFrame.next");
         _lastPage = ComponentFactory.Instance.creatComponentByStylename("recordFrame.last");
         _pageInput = ComponentFactory.Instance.creatComponentByStylename("recordFrame.input");
         _pageWord = ComponentFactory.Instance.creatComponentByStylename("recordFrame.word");
         addToContent(_contentBG);
         addToContent(_content);
         addToContent(_close);
         addToContent(_pageBG);
         addToContent(_firstPage);
         addToContent(_prePage);
         addToContent(_nextPage);
         addToContent(_lastPage);
         addToContent(_pageInput);
         addToContent(_pageWord);
         _pageInput.textField.maxChars = 4;
         _pageInput.textField.restrict = "0-9";
         _close.addEventListener("click",__closeHandler);
         _pageInput.addEventListener("keyDown",__keyDownHandler);
         _firstPage.addEventListener("click",__clickHandler);
         _prePage.addEventListener("click",__clickHandler);
         _nextPage.addEventListener("click",__clickHandler);
         _lastPage.addEventListener("click",__clickHandler);
         _messages = new Vector.<Object>();
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_firstPage !== _loc2_)
         {
            if(_prePage !== _loc2_)
            {
               if(_nextPage !== _loc2_)
               {
                  if(_lastPage === _loc2_)
                  {
                     showPage(1);
                  }
               }
               else if(_currentPage > 1)
               {
                  showPage(_currentPage - 1);
               }
            }
            else if(_currentPage < _totalPage)
            {
               showPage(_currentPage + 1);
            }
         }
         else
         {
            showPage(_totalPage);
         }
      }
      
      protected function __keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.keyCode == 13)
         {
            SoundManager.instance.play("008");
            _loc2_ = parseInt(_pageInput.text);
            if(_loc2_ > _totalPage)
            {
               _loc2_ = _totalPage;
            }
            else if(_loc2_ < 1)
            {
               _loc2_ = 1;
            }
            showPage(_totalPage + 1 - _loc2_);
         }
      }
      
      protected function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("close"));
      }
      
      public function set playerId(param1:int) : void
      {
         if(SharedManager.Instance.privateChatRecord[param1])
         {
            _messages = SharedManager.Instance.privateChatRecord[param1];
         }
         else
         {
            _messages = new Vector.<Object>();
         }
         _totalPage = _messages.length % 20 == 0?_messages.length / 20:Number(int(_messages.length / 20) + 1);
         _totalPage = _totalPage == 0?1:_totalPage;
         _pageWord.text = LanguageMgr.GetTranslation("IM.ChatFrame.recordFrame.pageWord",_totalPage);
         showPage(1);
      }
      
      protected function showPage(param1:int) : void
      {
         var _loc5_:* = 0;
         if(param1 == 1)
         {
            _lastPage.enable = false;
            _nextPage.enable = false;
         }
         else
         {
            _lastPage.enable = true;
            _nextPage.enable = true;
         }
         if(param1 == _totalPage)
         {
            _firstPage.enable = false;
            _prePage.enable = false;
         }
         else
         {
            _firstPage.enable = true;
            _prePage.enable = true;
         }
         _pageInput.text = (_totalPage + 1 - param1).toString();
         _currentPage = param1;
         var _loc2_:String = "";
         var _loc4_:int = (_totalPage - _currentPage) * 20;
         var _loc3_:int = (_totalPage - _currentPage + 1) * 20;
         _loc4_ = _loc4_ < 0?0:_loc4_;
         _loc3_ = _loc3_ > _messages.length?_messages.length:_loc3_;
         _loc5_ = _loc4_;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc2_ + (String(_messages[_loc5_]) + "<br/>");
            _loc5_++;
         }
         _content.htmlText = _loc2_;
         _content.textField.setSelection(_content.text.length - 1,_content.text.length - 1);
         _content.upScrollArea();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _close.removeEventListener("click",__closeHandler);
         _pageInput.removeEventListener("keyDown",__keyDownHandler);
         _firstPage.removeEventListener("click",__clickHandler);
         _prePage.removeEventListener("click",__clickHandler);
         _nextPage.removeEventListener("click",__clickHandler);
         _lastPage.removeEventListener("click",__clickHandler);
         _messages = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_contentBG)
         {
            ObjectUtils.disposeObject(_contentBG);
         }
         _contentBG = null;
         if(_close)
         {
            ObjectUtils.disposeObject(_close);
         }
         _close = null;
         if(_pageBG)
         {
            ObjectUtils.disposeObject(_pageBG);
         }
         _pageBG = null;
         if(_firstPage)
         {
            ObjectUtils.disposeObject(_firstPage);
         }
         _firstPage = null;
         if(_prePage)
         {
            ObjectUtils.disposeObject(_prePage);
         }
         _prePage = null;
         if(_nextPage)
         {
            ObjectUtils.disposeObject(_nextPage);
         }
         _nextPage = null;
         if(_lastPage)
         {
            ObjectUtils.disposeObject(_lastPage);
         }
         _lastPage = null;
         if(_pageInput)
         {
            ObjectUtils.disposeObject(_pageInput);
         }
         _pageInput = null;
         if(_pageWord)
         {
            ObjectUtils.disposeObject(_pageWord);
         }
         _pageWord = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
