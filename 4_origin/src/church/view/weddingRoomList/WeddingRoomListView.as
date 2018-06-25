package church.view.weddingRoomList
{
   import church.controller.ChurchRoomListController;
   import church.model.ChurchRoomListModel;
   import church.view.weddingRoomList.frame.WeddingRoomEnterConfirmView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryEvent;
   
   public class WeddingRoomListView extends Sprite implements Disposeable
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _model:ChurchRoomListModel;
      
      private var _bgJoinListAsset:MutipleImage;
      
      private var _btnPageFirstAsset:BaseButton;
      
      private var _btnPageBackAsset:BaseButton;
      
      private var _btnPageNextAsset:BaseButton;
      
      private var _btnPageLastAsset:BaseButton;
      
      private var _pageInfoText:FilterFrameText;
      
      private var _pageCount:int;
      
      private var _pageIndex:int = 1;
      
      private var _pageSize:int = 7;
      
      private var _weddingRoomListBox:VBox;
      
      private var _enterConfirmView:WeddingRoomEnterConfirmView;
      
      private var _titleBG:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _listBG:MovieImage;
      
      private var _titleLine:MovieImage;
      
      private var _roomListBG:ScaleBitmapImage;
      
      private var _menberListVLine:MutipleImage;
      
      private var _itemBG:MutipleImage;
      
      private var _pagePreBG:ScaleBitmapImage;
      
      private var _idTxt:FilterFrameText;
      
      private var _roomNameTxt:FilterFrameText;
      
      private var _numberTxt:FilterFrameText;
      
      private var _lblPageInfoBG:Scale9CornerImage;
      
      public function WeddingRoomListView(controller:ChurchRoomListController, model:ChurchRoomListModel)
      {
         super();
         _controller = controller;
         _model = model;
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
         updateList();
      }
      
      private function setView() : void
      {
         _bgJoinListAsset = ComponentFactory.Instance.creatComponentByStylename("churchroomlist.WeddingRoomListNavViewBG");
         addChild(_bgJoinListAsset);
         _titleBG = ComponentFactory.Instance.creatBitmap("asset.church.main.bgJoinListAsset");
         addChild(_titleBG);
         _titleTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomListView.titleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.titleText");
         addChild(_titleTxt);
         _roomListBG = ComponentFactory.Instance.creatComponentByStylename("churchroomlist.WeddingRoomListBG");
         addChild(_roomListBG);
         _listBG = ComponentFactory.Instance.creatComponentByStylename("churchroomlist.WeddingRoomListBG.titleBG");
         addChild(_listBG);
         _titleLine = ComponentFactory.Instance.creatComponentByStylename("churchroomlist.WeddingRoomLine");
         addChild(_titleLine);
         _menberListVLine = ComponentFactory.Instance.creatComponentByStylename("church.main.WeddingRoomListTitle.Vline");
         addChild(_menberListVLine);
         _idTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomList.idTxt");
         _idTxt.text = LanguageMgr.GetTranslation("tank.ddthotSpringList.ID");
         addChild(_idTxt);
         _roomNameTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomList.roomNameTxt");
         _roomNameTxt.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.roomname");
         addChild(_roomNameTxt);
         _numberTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomList.numberTxt");
         _numberTxt.text = LanguageMgr.GetTranslation("tank.ddthotSpringList.peopleNum");
         addChild(_numberTxt);
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("church.main.WeddingRoomListItem.BG");
         addChild(_itemBG);
         _weddingRoomListBox = ComponentFactory.Instance.creat("asset.church.main.WeddingRoomListBoxAsset");
         addChild(_weddingRoomListBox);
         _pagePreBG = ComponentFactory.Instance.creatComponentByStylename("churchroomlist.WeddingRoomList.pagePreBg");
         addChild(_pagePreBG);
         _lblPageInfoBG = ComponentFactory.Instance.creatComponentByStylename("church.main.lblPageInfo.wordBG");
         addChild(_lblPageInfoBG);
         _btnPageFirstAsset = ComponentFactory.Instance.creat("church.main.btnPageFirstAsset");
         addChild(_btnPageFirstAsset);
         _btnPageBackAsset = ComponentFactory.Instance.creat("church.main.btnPageBackAsset");
         addChild(_btnPageBackAsset);
         _btnPageNextAsset = ComponentFactory.Instance.creat("church.main.btnPageNextAsset");
         addChild(_btnPageNextAsset);
         _btnPageLastAsset = ComponentFactory.Instance.creat("church.main.btnPageLastAsset");
         addChild(_btnPageLastAsset);
         _pageInfoText = ComponentFactory.Instance.creat("church.main.lblPageInfo");
         addChild(_pageInfoText);
      }
      
      private function removeView() : void
      {
         if(_bgJoinListAsset)
         {
            if(_bgJoinListAsset.parent)
            {
               _bgJoinListAsset.parent.removeChild(_bgJoinListAsset);
            }
         }
         _bgJoinListAsset = null;
         if(_titleBG)
         {
            if(_titleBG.parent)
            {
               _titleBG.parent.removeChild(_titleBG);
            }
            _titleBG.bitmapData.dispose();
            _titleBG.bitmapData = null;
         }
         _titleBG = null;
         if(_titleTxt)
         {
            if(_titleTxt.parent)
            {
               _titleTxt.parent.removeChild(_titleTxt);
            }
            _titleTxt.dispose();
         }
         _titleTxt = null;
         if(_roomListBG)
         {
            ObjectUtils.disposeObject(_roomListBG);
         }
         _roomListBG = null;
         if(_listBG)
         {
            if(_listBG.parent)
            {
               _listBG.parent.removeChild(_listBG);
            }
         }
         _listBG = null;
         if(_titleLine)
         {
            if(_titleLine.parent)
            {
               _titleLine.parent.removeChild(_titleLine);
            }
         }
         _titleLine = null;
         _menberListVLine = null;
         _itemBG = null;
         _pagePreBG = null;
         _lblPageInfoBG.dispose();
         _lblPageInfoBG = null;
         _idTxt = null;
         _roomNameTxt = null;
         _numberTxt = null;
         if(_btnPageFirstAsset)
         {
            if(_btnPageFirstAsset.parent)
            {
               _btnPageFirstAsset.parent.removeChild(_btnPageFirstAsset);
            }
            _btnPageFirstAsset.dispose();
         }
         _btnPageFirstAsset = null;
         if(_btnPageBackAsset)
         {
            if(_btnPageBackAsset.parent)
            {
               _btnPageBackAsset.parent.removeChild(_btnPageBackAsset);
            }
            _btnPageBackAsset.dispose();
         }
         _btnPageBackAsset = null;
         if(_btnPageNextAsset)
         {
            if(_btnPageNextAsset.parent)
            {
               _btnPageNextAsset.parent.removeChild(_btnPageNextAsset);
            }
            _btnPageNextAsset.dispose();
         }
         _btnPageNextAsset = null;
         if(_btnPageLastAsset)
         {
            if(_btnPageLastAsset.parent)
            {
               _btnPageLastAsset.parent.removeChild(_btnPageLastAsset);
            }
            _btnPageLastAsset.dispose();
         }
         _btnPageLastAsset = null;
         if(_enterConfirmView)
         {
            if(_enterConfirmView.parent)
            {
               _enterConfirmView.parent.removeChild(_enterConfirmView);
            }
            _enterConfirmView.dispose();
         }
         _enterConfirmView = null;
         if(_pageInfoText)
         {
            ObjectUtils.disposeObject(_pageInfoText);
         }
         _pageInfoText = null;
         if(_weddingRoomListBox)
         {
            ObjectUtils.disposeObject(_weddingRoomListBox);
         }
         _weddingRoomListBox = null;
      }
      
      private function setEvent() : void
      {
         _model.roomList.addEventListener("add",updateList);
         _model.roomList.addEventListener("remove",updateList);
         _model.roomList.addEventListener("update",updateList);
         _btnPageFirstAsset.addEventListener("click",getPageList);
         _btnPageBackAsset.addEventListener("click",getPageList);
         _btnPageNextAsset.addEventListener("click",getPageList);
         _btnPageLastAsset.addEventListener("click",getPageList);
      }
      
      private function removeEvent() : void
      {
         _btnPageFirstAsset.removeEventListener("click",getPageList);
         _btnPageBackAsset.removeEventListener("click",getPageList);
         _btnPageNextAsset.removeEventListener("click",getPageList);
         _btnPageLastAsset.removeEventListener("click",getPageList);
      }
      
      private function getPageList(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = evt.target;
         if(_btnPageFirstAsset !== _loc2_)
         {
            if(_btnPageBackAsset !== _loc2_)
            {
               if(_btnPageNextAsset !== _loc2_)
               {
                  if(_btnPageLastAsset === _loc2_)
                  {
                     pageIndex = pageCount;
                  }
               }
               else
               {
                  pageIndex = pageIndex + 1 <= pageCount?pageIndex + 1:pageCount;
               }
            }
            else
            {
               pageIndex = pageIndex - 1 > 0?pageIndex - 1:1;
            }
         }
         else
         {
            pageIndex = 1;
         }
      }
      
      public function updateList(event:DictionaryEvent = null) : void
      {
         var item:* = null;
         _weddingRoomListBox.disposeAllChildren();
         var _loc5_:* = pageCount > 0 && pageIndex > 1;
         _btnPageBackAsset.enable = _loc5_;
         _btnPageFirstAsset.enable = _loc5_;
         _loc5_ = pageCount > 0 && pageIndex < pageCount;
         _btnPageLastAsset.enable = _loc5_;
         _btnPageNextAsset.enable = _loc5_;
         updatePageText();
         if(!currentDataList || currentDataList.length <= 0)
         {
            return;
         }
         var pageList:Array = currentDataList.slice(_pageIndex * _pageSize - _pageSize,_pageIndex * _pageSize <= currentDataList.length?_pageIndex * _pageSize:currentDataList.length);
         var _loc7_:int = 0;
         var _loc6_:* = pageList;
         for each(var churchRoomInfo in pageList)
         {
            item = ComponentFactory.Instance.creatCustomObject("church.view.WeddingRoomListItemView");
            item.churchRoomInfo = churchRoomInfo;
            _weddingRoomListBox.addChild(item);
            item.addEventListener("click",__itemClick);
         }
      }
      
      private function updatePageText() : void
      {
         _pageInfoText.text = _pageIndex + "/" + _pageCount;
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         var item:WeddingRoomListItemView = event.currentTarget as WeddingRoomListItemView;
         _enterConfirmView = ComponentFactory.Instance.creat("church.main.weddingRoomList.WeddingRoomEnterConfirmView");
         _enterConfirmView.controller = _controller;
         _enterConfirmView.churchRoomInfo = item.churchRoomInfo;
         _enterConfirmView.show();
      }
      
      public function get currentDataList() : Array
      {
         var arr:* = null;
         if(_model && _model.roomList)
         {
            arr = _model.roomList.list;
            arr.sortOn("id",16);
            return arr;
         }
         return null;
      }
      
      public function get pageIndex() : int
      {
         return _pageIndex;
      }
      
      public function set pageIndex(value:int) : void
      {
         _pageIndex = value;
         updateList();
      }
      
      public function get pageCount() : int
      {
         _pageCount = currentDataList.length / _pageSize;
         if(currentDataList.length % _pageSize > 0)
         {
            _pageCount = _pageCount + 1;
         }
         _pageCount = _pageCount == 0?1:_pageCount;
         return _pageCount;
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
