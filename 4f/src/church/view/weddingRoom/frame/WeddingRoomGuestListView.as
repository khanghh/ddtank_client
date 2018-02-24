package church.view.weddingRoom.frame
{
   import church.controller.ChurchRoomController;
   import church.model.ChurchRoomModel;
   import church.vo.PlayerVO;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class WeddingRoomGuestListView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg1:Scale9CornerImage;
      
      private var _controller:ChurchRoomController;
      
      private var _model:ChurchRoomModel;
      
      private var _btnGuestListClose:BaseButton;
      
      private var _guestListBox:Bitmap;
      
      private var _listPanel:ListPanel;
      
      private var _data:DictionaryData;
      
      private var _currentItem:WeddingRoomGuestListItemView;
      
      private var _titleTxt:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _sexText:FilterFrameText;
      
      public function WeddingRoomGuestListView(param1:ChurchRoomController, param2:ChurchRoomModel){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      private function getGuestList() : void{}
      
      private function compareFunction(param1:PlayerVO, param2:PlayerVO) : int{return 0;}
      
      private function itemClick(param1:ListItemEvent) : void{}
      
      private function setEvent() : void{}
      
      private function addGuest(param1:DictionaryEvent) : void{}
      
      private function getInsertIndex(param1:PlayerInfo) : int{return 0;}
      
      private function removeGuest(param1:DictionaryEvent) : void{}
      
      private function addSelfItem() : void{}
      
      private function upSelfItem() : void{}
      
      private function changeData(param1:PlayerInfo, param2:int) : Object{return null;}
      
      private function closeView(param1:MouseEvent) : void{}
      
      public function show() : void{}
      
      private function removeView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
