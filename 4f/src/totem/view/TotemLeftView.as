package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemLeftView extends Sprite implements Disposeable
   {
       
      
      private var _windowBg:Bitmap;
      
      private var _pageBg:Bitmap;
      
      private var _pageTxtBg:Bitmap;
      
      private var _windowView:TotemLeftWindowView;
      
      private var _firstBtn:SimpleBitmapButton;
      
      private var _forwardBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _lastBtn:SimpleBitmapButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      public function TotemLeftView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function changePage(param1:MouseEvent) : void{}
      
      public function refreshView(param1:Boolean) : void{}
      
      private function openSuccessAutoNextPage() : void{}
      
      private function refreshPageBtn() : void{}
      
      private function showPage() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
