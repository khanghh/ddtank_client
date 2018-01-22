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
      
      public function PrivateRecordFrame(){super();}
      
      protected function __clickHandler(param1:MouseEvent) : void{}
      
      protected function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      protected function __closeHandler(param1:MouseEvent) : void{}
      
      public function set playerId(param1:int) : void{}
      
      protected function showPage(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
