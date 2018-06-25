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
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < 6; )
         {
            cell = new HalloweenListCell();
            PositionUtils.setPos(cell,"halloween.listCellPos" + i);
            addChild(cell);
            _cellVec.push(cell);
            i++;
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
      
      protected function __onNextPageClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentPage < _totalPage)
         {
            _currentPage = Number(_currentPage) + 1;
            setPageInfo(_currentPage);
         }
      }
      
      protected function __onPrePageClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentPage - 1 > 0)
         {
            _currentPage = Number(_currentPage) - 1;
            setPageInfo(_currentPage);
         }
      }
      
      protected function __onViewInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         _totalPage = Math.ceil(count / 6);
         for(i = 0; i < count; )
         {
            info = new HalloweenModel();
            info.Index = pkg.readInt();
            info.Id = pkg.readInt();
            info.Price = pkg.readInt();
            _infoArray.push(info);
            i++;
         }
         _infoArray.sortOn("Index",16);
         setPageInfo(1);
      }
      
      public function setPageInfo(page:int) : void
      {
         var i:int = 0;
         _currentPage = page;
         _pageText.text = _currentPage.toString() + "/" + _totalPage.toString();
         for(i = 0; i < 6; )
         {
            _cellVec[i].info = _infoArray[6 * (_currentPage - 1) + i];
            i++;
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
         var i:int = 0;
         removeEvent();
         for(i = 0; i < _cellVec.length; )
         {
            ObjectUtils.disposeObject(_cellVec[i]);
            _cellVec[i] = null;
            i++;
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
