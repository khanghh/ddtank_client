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
      
      public function WeddingRoomGuestListView(param1:ChurchRoomController, param2:ChurchRoomModel)
      {
         super();
         _controller = param1;
         _model = param2;
         initialize();
      }
      
      protected function initialize() : void
      {
         _data = _model.getPlayers();
         setView();
         setEvent();
         getGuestList();
      }
      
      private function setView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("church.weddingRoom.guestFrameBg");
         addChild(_bg);
         _titleTxt = ComponentFactory.Instance.creat("ddtchurchroomlist.frame.WeddingRoomGuestListView.titleText");
         _titleTxt.text = LanguageMgr.GetTranslation("tank.ddtchurchroomlist.frame.WeddingRoomGuestListView.titleText");
         addChild(_titleTxt);
         _bg1 = ComponentFactory.Instance.creat("church.weddingRoom.guestListBg");
         addChild(_bg1);
         _guestListBox = ComponentFactory.Instance.creat("asset.church.room.guestListBoxAsset");
         addChild(_guestListBox);
         _gradeText = ComponentFactory.Instance.creat("ddtchurchroomlist.frame.WeddingRoomGuestListView.gradeText");
         _gradeText.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.level");
         addChild(_gradeText);
         _nameText = ComponentFactory.Instance.creat("ddtchurchroomlist.frame.WeddingRoomGuestListView.nameText");
         _nameText.text = LanguageMgr.GetTranslation("itemview.listname");
         addChild(_nameText);
         _sexText = ComponentFactory.Instance.creat("ddtchurchroomlist.frame.WeddingRoomGuestListView.sexText");
         _sexText.text = LanguageMgr.GetTranslation("ddt.roomlist.right.sex");
         addChild(_sexText);
         _btnGuestListClose = ComponentFactory.Instance.creat("church.room.guestListCloseAsset");
         addChild(_btnGuestListClose);
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("church.room.listGuestListAsset");
         addChild(_listPanel);
         _listPanel.list.updateListView();
         _listPanel.list.addEventListener("listItemClick",itemClick);
      }
      
      private function getGuestList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _data.list.sort(compareFunction);
         _loc3_ = 0;
         while(_loc3_ < _data.length)
         {
            _loc2_ = (_data.list[_loc3_] as PlayerVO).playerInfo;
            _loc1_ = changeData(_loc2_,_loc3_ + 1);
            _listPanel.vectorListModel.insertElementAt(_loc1_,getInsertIndex(_loc2_));
            _loc3_++;
         }
         addSelfItem();
         upSelfItem();
      }
      
      private function compareFunction(param1:PlayerVO, param2:PlayerVO) : int
      {
         if(param1.playerInfo.Grade >= param2.playerInfo.Grade)
         {
            return -1;
         }
         return 1;
      }
      
      private function itemClick(param1:ListItemEvent) : void
      {
         if(!_currentItem)
         {
            _currentItem = param1.cell as WeddingRoomGuestListItemView;
            _currentItem.setListCellStatus(_listPanel.list,true,param1.index);
         }
         if(_currentItem != param1.cell as WeddingRoomGuestListItemView)
         {
            _currentItem.setListCellStatus(_listPanel.list,false,param1.index);
            _currentItem = param1.cell as WeddingRoomGuestListItemView;
            _currentItem.setListCellStatus(_listPanel.list,true,param1.index);
         }
      }
      
      private function setEvent() : void
      {
         _btnGuestListClose.addEventListener("click",closeView);
         _data.addEventListener("add",addGuest);
         _data.addEventListener("remove",removeGuest);
      }
      
      private function addGuest(param1:DictionaryEvent) : void
      {
         _listPanel.vectorListModel.clear();
         getGuestList();
      }
      
      private function getInsertIndex(param1:PlayerInfo) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = _listPanel.vectorListModel.elements;
         if(_loc3_.length == 0)
         {
            return 0;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(param1.Grade > (_loc3_[_loc4_].playerInfo as PlayerInfo).Grade)
            {
               return _loc2_;
            }
            if(param1.Grade <= (_loc3_[_loc4_].playerInfo as PlayerInfo).Grade)
            {
               _loc2_ = _loc4_ + 1;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function removeGuest(param1:DictionaryEvent) : void
      {
         _listPanel.vectorListModel.clear();
         getGuestList();
      }
      
      private function addSelfItem() : void
      {
         _listPanel.vectorListModel.insertElementAt(changeData(PlayerManager.Instance.Self,0),0);
      }
      
      private function upSelfItem() : void
      {
         var _loc2_:PlayerInfo = _data[PlayerManager.Instance.Self.ID];
         var _loc1_:int = _listPanel.vectorListModel.indexOf(changeData(_loc2_,0));
         if(_loc1_ == -1 || _loc1_ == 0)
         {
            return;
         }
         _listPanel.vectorListModel.removeAt(_loc1_);
         _listPanel.vectorListModel.insertElementAt(changeData(_loc2_,0),0);
      }
      
      private function changeData(param1:PlayerInfo, param2:int) : Object
      {
         var _loc3_:Object = {};
         _loc3_["playerInfo"] = param1;
         _loc3_["index"] = param2;
         return _loc3_;
      }
      
      private function closeView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2);
      }
      
      private function removeView() : void
      {
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.dispose();
         }
         _bg = null;
         if(_bg1)
         {
            if(_bg1.parent)
            {
               _bg1.parent.removeChild(_bg1);
            }
            _bg1.dispose();
         }
         _bg1 = null;
         if(_titleTxt)
         {
            if(_titleTxt.parent)
            {
               _titleTxt.parent.removeChild(_titleTxt);
            }
            _titleTxt.dispose();
         }
         _titleTxt = null;
         if(_gradeText)
         {
            if(_gradeText.parent)
            {
               _gradeText.parent.removeChild(_gradeText);
            }
            _gradeText.dispose();
         }
         _gradeText = null;
         if(_nameText)
         {
            if(_nameText.parent)
            {
               _nameText.parent.removeChild(_nameText);
            }
            _nameText.dispose();
         }
         _nameText = null;
         if(_sexText)
         {
            if(_sexText.parent)
            {
               _sexText.parent.removeChild(_sexText);
            }
            _sexText.dispose();
         }
         _sexText = null;
         if(_btnGuestListClose)
         {
            if(_btnGuestListClose.parent)
            {
               _btnGuestListClose.parent.removeChild(_btnGuestListClose);
            }
            _btnGuestListClose.dispose();
         }
         _btnGuestListClose = null;
         if(_guestListBox)
         {
            if(_guestListBox.parent)
            {
               _guestListBox.parent.removeChild(_guestListBox);
            }
            _guestListBox.bitmapData.dispose();
            _guestListBox.bitmapData = null;
         }
         _guestListBox = null;
         if(_listPanel)
         {
            if(_listPanel.parent)
            {
               _listPanel.parent.removeChild(_listPanel);
            }
            _listPanel.dispose();
         }
         _listPanel = null;
         if(_currentItem)
         {
            if(_currentItem.parent)
            {
               _currentItem.parent.removeChild(_currentItem);
            }
            _currentItem.dispose();
         }
         _currentItem = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
      
      private function removeEvent() : void
      {
         if(_btnGuestListClose)
         {
            _btnGuestListClose.removeEventListener("click",closeView);
         }
         _data.removeEventListener("add",addGuest);
         _data.removeEventListener("remove",removeGuest);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
