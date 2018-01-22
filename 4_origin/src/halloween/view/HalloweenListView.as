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
      
      public function HalloweenListView()
      {
         super();
         _cellVec = new Vector.<HalloweenListCell>();
         _infoArray = [];
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new HalloweenListCell();
            PositionUtils.setPos(_loc1_,"halloween.listCellPos" + _loc2_);
            addChild(_loc1_);
            _cellVec.push(_loc1_);
            _loc2_++;
         }
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("halloween.currentPageInput");
         addChild(_pageBg);
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("halloween.prePageBtn");
         addChild(_prePageBtn);
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("halloween.nextPageBtn");
         addChild(_nextPageBtn);
         _pageText = ComponentFactory.Instance.creatComponentByStylename("halloween.currentPage");
         addChild(_pageText);
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(283,2),__onViewInfo);
      }
      
      protected function __onNextPageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentPage < _totalPage)
         {
            _currentPage = Number(_currentPage) + 1;
            setPageInfo(_currentPage);
         }
      }
      
      protected function __onPrePageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentPage - 1 > 0)
         {
            _currentPage = Number(_currentPage) - 1;
            setPageInfo(_currentPage);
         }
      }
      
      protected function __onViewInfo(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _totalPage = Math.ceil(_loc2_ / 6);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new HalloweenModel();
            _loc4_.Index = _loc3_.readInt();
            _loc4_.Id = _loc3_.readInt();
            _loc4_.Price = _loc3_.readInt();
            _infoArray.push(_loc4_);
            _loc5_++;
         }
         _infoArray.sortOn("Index",16);
         setPageInfo(1);
      }
      
      public function setPageInfo(param1:int) : void
      {
         var _loc2_:int = 0;
         _currentPage = param1;
         _pageText.text = _currentPage.toString() + "/" + _totalPage.toString();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _cellVec[_loc2_].info = _infoArray[6 * (_currentPage - 1) + _loc2_];
            _loc2_++;
         }
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.getHalloweenViewInfo();
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__onPrePageClick);
         _nextPageBtn.removeEventListener("click",__onNextPageClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(283,2),__onViewInfo);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < _cellVec.length)
         {
            ObjectUtils.disposeObject(_cellVec[_loc1_]);
            _cellVec[_loc1_] = null;
            _loc1_++;
         }
         _cellVec = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
      }
   }
}
