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
      
      public function WeddingRoomListView(param1:ChurchRoomListController, param2:ChurchRoomListModel){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      private function removeView() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function getPageList(param1:MouseEvent) : void{}
      
      public function updateList(param1:DictionaryEvent = null) : void{}
      
      private function updatePageText() : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      public function get currentDataList() : Array{return null;}
      
      public function get pageIndex() : int{return 0;}
      
      public function set pageIndex(param1:int) : void{}
      
      public function get pageCount() : int{return 0;}
      
      public function dispose() : void{}
   }
}
