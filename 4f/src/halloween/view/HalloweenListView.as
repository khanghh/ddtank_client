package halloween.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import halloween.data.HalloweenModel;
   import road7th.comm.PackageIn;
   
   public class HalloweenListView extends Sprite implements Disposeable
   {
      
      private static const HALLWEENLISTNUM:int = 6;
       
      
      private var _cellVec:Vector.<HalloweenListCell>;
      
      private var _infoArray:Array;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _prePageBtn:SimpleBitmapButton;
      
      private var _nextPageBtn:SimpleBitmapButton;
      
      private var _pageText:FilterFrameText;
      
      private var _currentPage:int;
      
      private var _totalPage:int;
      
      public function HalloweenListView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onNextPageClick(param1:MouseEvent) : void{}
      
      protected function __onPrePageClick(param1:MouseEvent) : void{}
      
      protected function __onViewInfo(param1:PkgEvent) : void{}
      
      public function setPageInfo(param1:int) : void{}
      
      private function sendPkg() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
