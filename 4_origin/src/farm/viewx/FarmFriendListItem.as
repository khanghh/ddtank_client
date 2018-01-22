package farm.viewx
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.common.LevelIcon;
   import farm.FarmModelController;
   import farm.modelx.FramFriendStateInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import vip.VipController;
   
   public class FarmFriendListItem extends Sprite implements IListCell, Disposeable
   {
       
      
      private var _itemBG:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _nameText:FilterFrameText;
      
      private var _stoleIcon:Bitmap;
      
      private var _feedIcon:Bitmap;
      
      private var _info:FramFriendStateInfo;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _vipName:GradientText;
      
      public function FarmFriendListItem()
      {
         super();
         init();
         initEvent();
      }
      
      public function get info() : FramFriendStateInfo
      {
         return _info;
      }
      
      private function init() : void
      {
         buttonMode = true;
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _itemBG = ComponentFactory.Instance.creatBitmap("asset.farm.itemMouseOverBg");
         _itemBG.visible = false;
         addChild(_itemBG);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("farm.friendListItem.levelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _nameText = ComponentFactory.Instance.creat("farm.friendList.item.name");
         addChild(_nameText);
         _stoleIcon = ComponentFactory.Instance.creatBitmap("asset.farm.isStolenImage");
         _stoleIcon.visible = false;
         addChild(_stoleIcon);
         _feedIcon = ComponentFactory.Instance.creatBitmap("asset.farm.friendList.feed");
         _feedIcon.visible = false;
         addChild(_feedIcon);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__itemOut);
         addEventListener("click",__itemClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__itemOver);
         removeEventListener("mouseOut",__itemOut);
         removeEventListener("click",__itemClick);
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(StateManager.currentStateType == "farm" && FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            FarmModelController.instance.exitFarm(PlayerManager.Instance.Self.ID);
         }
         FarmModelController.instance.goFarm(_info.id,_info.playerinfo.NickName);
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         _itemBG.visible = true;
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         if(!isFriendSelected())
         {
            _itemBG.visible = false;
         }
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(param1:*) : void
      {
         _info = param1;
         update();
      }
      
      private function update() : void
      {
         _levelIcon.setInfo(_info.playerinfo.Grade,_info.playerinfo.ddtKingGrade,_info.playerinfo.Repute,_info.playerinfo.WinCount,_info.playerinfo.TotalCount,_info.playerinfo.FightPower,_info.playerinfo.Offer,true);
         if(_info.playerinfo.IsVIP)
         {
            if(_vipName == null)
            {
               _vipName = VipController.instance.getVipNameTxt(100);
               addChild(_vipName);
            }
            _vipName.x = _nameText.x;
            _vipName.y = _nameText.y;
            _vipName.text = _info.playerinfo.NickName;
            _vipName.visible = true;
            _nameText.visible = false;
         }
         else
         {
            if(_vipName)
            {
               _vipName.visible = false;
            }
            _nameText.visible = true;
         }
         _nameText.text = _info.playerinfo.NickName;
         if(FarmModelController.instance.model.SelectIndex == 0)
         {
            _feedIcon.visible = false;
            _stoleIcon.visible = _info.isStolen;
         }
         else
         {
            _stoleIcon.visible = false;
            _feedIcon.visible = _info.isFeed;
         }
         if(_info.playerinfo.playerState.StateID == 0)
         {
            this.filters = [_myColorMatrix_filter];
         }
         else
         {
            this.filters = null;
         }
         if(isFriendSelected())
         {
            _itemBG.visible = true;
         }
         else
         {
            _itemBG.visible = false;
         }
      }
      
      private function isFriendSelected() : Boolean
      {
         if(FarmModelController.instance.model.currentFarmerName == _info.playerinfo.NickName)
         {
            return true;
         }
         return false;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _itemBG = null;
         if(_levelIcon)
         {
            _levelIcon.dispose();
         }
         _levelIcon = null;
         _nameText = null;
         _stoleIcon = null;
         _feedIcon = null;
         _myColorMatrix_filter = null;
      }
   }
}
