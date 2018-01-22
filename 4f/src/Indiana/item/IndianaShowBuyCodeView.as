package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class IndianaShowBuyCodeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _scroller:ScrollPanel;
      
      private var _titleTxt:GradientBitmapText;
      
      private var _title1Txt:GradientBitmapText;
      
      private var _beginNum:Array;
      
      private var _list:SimpleTileList;
      
      private var _closeBtn:BaseButton;
      
      private var _titletimes:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _rightBtn:BaseButton;
      
      private var _leftBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _totlePage:int;
      
      private var _currentPage:int = 1;
      
      private var timesarr:Array;
      
      public function IndianaShowBuyCodeView(param1:Array){super();}
      
      private function initItem() : void{}
      
      private function setPage(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __rightClickHandler(param1:MouseEvent) : void{}
      
      private function __leftClickHandler(param1:MouseEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
