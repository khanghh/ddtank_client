package church.view.weddingRoom.frame
{
   import church.ChurchManager;
   import church.view.menu.MenuView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class WeddingRoomGuestListItemView extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _playerInfo:PlayerInfo;
      
      private var _index:int;
      
      private var _levelIcon:LevelIcon;
      
      private var _txtItemInfo:FilterFrameText;
      
      private var _ltemBgAc:Bitmap;
      
      private var _sexIcon:SexIcon;
      
      private var _isSelected:Boolean;
      
      private var _vipName:GradientText;
      
      private var _itemBG:DisplayObject;
      
      private var _line:TiledImage;
      
      public function WeddingRoomGuestListItemView()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         _itemBG = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.frame.WeddingRoomGuestListView.listItemBG");
         addChild(_itemBG);
         _line = ComponentFactory.Instance.creatComponentByStylename("church.room.VerticalLine");
         addChild(_line);
         _txtItemInfo = ComponentFactory.Instance.creat("church.room.listGuestListItemInfoAsset");
         _txtItemInfo.mouseEnabled = false;
         _levelIcon = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.frame.WeddingRoomGuestListItemLevelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.frame.WeddingRoomGuestListItemSexIcon");
         _sexIcon.size = 0.8;
         addChild(_sexIcon);
      }
      
      private function setEvent() : void
      {
         addEventListener("click",itemClick);
      }
      
      private function itemClick(event:MouseEvent) : void
      {
         if(_playerInfo.ID == ChurchManager.instance.currentRoom.brideID || _playerInfo.ID == ChurchManager.instance.currentRoom.groomID)
         {
            return;
         }
         MenuView.show(_playerInfo);
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _isSelected = isSelected;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value;
         _playerInfo = value.playerInfo;
         _index = value.index;
         update();
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      private function update() : void
      {
         _itemBG.visible = !!(_index % 2)?false:true;
         _txtItemInfo.text = _playerInfo.NickName;
         if(_playerInfo.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(109,_playerInfo.typeVIP);
            _vipName.x = _txtItemInfo.x;
            _vipName.y = _txtItemInfo.y;
            _vipName.text = _txtItemInfo.text;
            addChild(_vipName);
            DisplayUtils.removeDisplay(_txtItemInfo);
         }
         else
         {
            addChild(_txtItemInfo);
            DisplayUtils.removeDisplay(_vipName);
         }
         _sexIcon.setSex(_playerInfo.Sex);
         _levelIcon.setInfo(_playerInfo.Grade,_playerInfo.ddtKingGrade,_playerInfo.Repute,_playerInfo.WinCount,_playerInfo.TotalCount,_playerInfo.FightPower,_playerInfo.Offer,true,false);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function removeView() : void
      {
         if(_levelIcon)
         {
            if(_levelIcon.parent)
            {
               _levelIcon.parent.removeChild(_levelIcon);
            }
            _levelIcon.dispose();
         }
         _levelIcon = null;
         if(_txtItemInfo)
         {
            if(_txtItemInfo.parent)
            {
               _txtItemInfo.parent.removeChild(_txtItemInfo);
            }
            _txtItemInfo.dispose();
         }
         _txtItemInfo = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(_sexIcon)
         {
            if(_sexIcon.parent)
            {
               _sexIcon.parent.removeChild(_sexIcon);
            }
            _sexIcon.dispose();
         }
         _sexIcon = null;
         if(_line)
         {
            if(_line.parent)
            {
               _line.parent.removeChild(_line);
            }
         }
         _line = null;
         if(_itemBG)
         {
            if(_itemBG.parent)
            {
               _itemBG.parent.removeChild(_itemBG);
            }
         }
         _itemBG = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",itemClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
