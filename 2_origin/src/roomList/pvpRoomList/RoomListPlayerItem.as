package roomList.pvpRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerTipManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import vip.VipController;
   
   public class RoomListPlayerItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _info:PlayerInfo;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _name:FilterFrameText;
      
      private var _BG:Bitmap;
      
      private var _isSelected:Boolean;
      
      private var _vipName:GradientText;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function RoomListPlayerItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("asset.ddtroomList.playerItemBG");
         _BG.visible = false;
         _BG.y = 2;
         addChild(_BG);
         _name = ComponentFactory.Instance.creat("asset.ddtroomList.pvp.playerItem.Name");
         addChild(_name);
         _levelIcon = new LevelIcon();
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.PlayerItem.SexIcon");
         addChild(_sexIcon);
         addEventListener("click",itemClick);
      }
      
      private function itemClick(event:MouseEvent) : void
      {
         PlayerTipManager.show(_info,localToGlobal(new Point(0,0)).y);
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _isSelected = isSelected;
         if(_BG)
         {
            _BG.visible = _isSelected;
         }
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value;
         update();
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      private function update() : void
      {
         ObjectUtils.disposeObject(_vipName);
         if(_info.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(120,_info.typeVIP);
            _vipName.x = _name.x;
            _vipName.y = _name.y;
            _vipName.text = _info.NickName;
            addChild(_vipName);
         }
         _name.text = _info.NickName;
         PositionUtils.adaptNameStyle(_info,_name,_vipName);
         _sexIcon.setSex(_info.Sex);
         _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
               _attestBtn.x = _sexIcon.x - 7;
               _attestBtn.y = _sexIcon.y - 4;
            }
            _attestBtn.visible = true;
            _sexIcon.visible = false;
         }
         else
         {
            _sexIcon.visible = true;
            if(_attestBtn != null)
            {
               _attestBtn.visible = false;
            }
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEventListener("click",itemClick);
         if(_vipName)
         {
            _vipName.dispose();
         }
         _vipName = null;
         if(_name)
         {
            _name.dispose();
            _name = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_sexIcon)
         {
            _sexIcon.dispose();
            _sexIcon = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
            _BG = null;
         }
      }
   }
}
