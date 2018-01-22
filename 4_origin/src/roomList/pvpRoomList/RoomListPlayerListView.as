package roomList.pvpRoomList
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.buff.BuffControl;
   import ddt.view.buff.BuffControlManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import guardCore.GuardCoreIcon;
   import guardCore.GuardCoreManager;
   import hall.event.NewHallEvent;
   import kingBless.KingBlessManager;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import vip.VipController;
   
   public class RoomListPlayerListView extends Sprite implements Disposeable
   {
       
      
      private var _selfInfo:SelfInfo;
      
      protected var _characterBg:MovieClip;
      
      protected var _propbg:MovieClip;
      
      protected var _listbg:MovieClip;
      
      protected var _listbg2:DisplayObject;
      
      private var _player:ICharacter;
      
      private var _levelIcon:LevelIcon;
      
      private var _iconContainer:VBox;
      
      private var _guardCoreIcon:GuardCoreIcon;
      
      private var _nickNameText:FilterFrameText;
      
      private var _consortiaNameText:FilterFrameText;
      
      private var _repute:FilterFrameText;
      
      private var _reputeText:FilterFrameText;
      
      private var _geste:FilterFrameText;
      
      private var _gesteText:FilterFrameText;
      
      protected var _level:FilterFrameText;
      
      protected var _sex:FilterFrameText;
      
      private var _playerList:ListPanel;
      
      private var _data:DictionaryData;
      
      private var _currentItem:RoomListPlayerItem;
      
      private var _marriedIcon:MarriedIcon;
      
      protected var _buffbgVec:Vector.<Bitmap>;
      
      private var _buff:BuffControl;
      
      private var _vipName:GradientText;
      
      public function RoomListPlayerListView(param1:DictionaryData)
      {
         _data = param1;
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initbg();
         initView();
         initEvent();
      }
      
      public function set type(param1:int) : void
      {
      }
      
      protected function initbg() : void
      {
         var _loc2_:int = 0;
         _characterBg = ClassUtils.CreatInstance("asset.ddtroomlist.characterbg") as MovieClip;
         PositionUtils.setPos(_characterBg,"asset.ddtRoomlist.pvp.left.characterbgpos");
         addChild(_characterBg);
         _propbg = ClassUtils.CreatInstance("asset.ddtroomlist.proprbg") as MovieClip;
         PositionUtils.setPos(_propbg,"asset.ddtRoomlist.pvp.left.propbgpos");
         addChild(_propbg);
         _listbg2 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.playerlistbg");
         addChild(_listbg2);
         _listbg = ClassUtils.CreatInstance("asset.ddtroomlist.listTitle.bg") as MovieClip;
         PositionUtils.setPos(_listbg,"asset.ddtRoomlist.pvp.left.listbgpos");
         addChild(_listbg);
         _buffbgVec = new Vector.<Bitmap>(6);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtRoomlist.pvp.buffbgpos");
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _buffbgVec[_loc2_] = ComponentFactory.Instance.creatBitmap("asset.core.buff.buffTiledBg");
            _buffbgVec[_loc2_].x = _loc1_.x + (_buffbgVec[_loc2_].width - 1) * _loc2_;
            _buffbgVec[_loc2_].y = _loc1_.y;
            addChild(_buffbgVec[_loc2_]);
            _loc2_++;
         }
      }
      
      protected function initView() : void
      {
         _level = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.levelText");
         _level.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.level");
         addChild(_level);
         _sex = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.sexText");
         _sex.text = LanguageMgr.GetTranslation("ddt.roomlist.right.sex");
         addChild(_sex);
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.iconContainer");
         addChild(_iconContainer);
         _consortiaNameText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.consortiaNameText");
         addChild(_consortiaNameText);
         _repute = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.repute");
         _repute.text = LanguageMgr.GetTranslation("repute");
         _repute.mouseEnabled = false;
         addChild(_repute);
         _reputeText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.reputeTxt");
         addChild(_reputeText);
         _geste = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.geste");
         _geste.text = LanguageMgr.GetTranslation("offer");
         addChild(_geste);
         _gesteText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.gesteText");
         addChild(_gesteText);
         _nickNameText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.nickNameText");
         _nickNameText.text = _selfInfo.NickName;
         addChild(_nickNameText);
         if(_selfInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(104,_selfInfo.typeVIP);
            _vipName.textSize = 16;
            _vipName.x = _nickNameText.x;
            _vipName.y = _nickNameText.y - 2;
            _vipName.text = _selfInfo.NickName;
            addChild(_vipName);
         }
         PositionUtils.adaptNameStyle(_selfInfo,_nickNameText,_vipName);
         _reputeText.text = String(_selfInfo.Repute);
         _gesteText.text = String(_selfInfo.Offer);
         if(_selfInfo.ConsortiaName == "")
         {
            _consortiaNameText.text = "";
         }
         else
         {
            _consortiaNameText.text = String("<" + _selfInfo.ConsortiaName + ">");
         }
         if(_consortiaNameText.text.substr(_consortiaNameText.text.length - 1) == ".")
         {
            _consortiaNameText.text = _consortiaNameText.text + ">";
         }
         _player = CharactoryFactory.createCharacter(_selfInfo,"room");
         _player.showGun = true;
         _player.show();
         _player.setShowLight(true);
         PositionUtils.setPos(_player,"asset.ddtroomList.pvp.left.playerPos");
         addChild(_player as DisplayObject);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pvp.left.levelIcon");
         _levelIcon.setInfo(_selfInfo.Grade,_selfInfo.ddtKingGrade,_selfInfo.Repute,_selfInfo.WinCount,_selfInfo.TotalCount,_selfInfo.FightPower,_selfInfo.Offer,true,false);
         addChild(_levelIcon);
         if(_selfInfo.IsVIP)
         {
            _levelIcon.x = _levelIcon.x + 2;
         }
         _selfInfo.isOpenKingBless = KingBlessManager.instance.getRemainTimeTxt().isOpen;
         if(_selfInfo.SpouseID > 0 && !_marriedIcon)
         {
            _marriedIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.pvp.left.MarriedIcon");
            _marriedIcon.tipData = {
               "nickName":_selfInfo.SpouseName,
               "gender":_selfInfo.Sex
            };
            _iconContainer.addChild(_marriedIcon);
         }
         if(_selfInfo.Grade >= GuardCoreManager.instance.guardCoreMinLevel)
         {
            ObjectUtils.disposeObject(_guardCoreIcon);
            _guardCoreIcon = ComponentFactory.Instance.creatComponentByStylename("core.guardCoreIcon");
            PositionUtils.setPos(_guardCoreIcon,"ddtcorei.roompListGuardCoreIcon.pos");
            _guardCoreIcon.setup(_selfInfo);
            _iconContainer.addChild(_guardCoreIcon);
         }
         _playerList = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.left.playerlistII");
         addChild(_playerList);
         _playerList.list.updateListView();
         _playerList.list.addEventListener("listItemClick",__itemClick);
         _buff = BuffControlManager.instance.buff;
         PositionUtils.setPos(_buff,"asset.ddtroomList.pvp.left.buffPos");
         addChild(_buff);
      }
      
      private function initEvent() : void
      {
         _data.addEventListener("add",__addPlayer);
         _data.addEventListener("remove",__removePlayer);
         _data.addEventListener("update",__updatePlayer);
      }
      
      private function __updatePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerInfo = param1.data as PlayerInfo;
         _playerList.vectorListModel.remove(_loc2_);
         _playerList.vectorListModel.insertElementAt(_loc2_,getInsertIndex(_loc2_));
         _playerList.list.updateListView();
         upSelfItem();
      }
      
      private function __addPlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerInfo = param1.data as PlayerInfo;
         _playerList.vectorListModel.insertElementAt(_loc2_,getInsertIndex(_loc2_));
         upSelfItem();
      }
      
      private function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerInfo = param1.data as PlayerInfo;
         _playerList.vectorListModel.remove(_loc2_);
         upSelfItem();
      }
      
      private function upSelfItem() : void
      {
         var _loc2_:PlayerInfo = _data[PlayerManager.Instance.Self.ID];
         var _loc1_:int = _playerList.vectorListModel.indexOf(_loc2_);
         if(_loc1_ == -1 || _loc1_ == 0)
         {
            return;
         }
         _playerList.vectorListModel.removeAt(_loc1_);
         _playerList.vectorListModel.append(_loc2_,0);
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_currentItem)
         {
            _currentItem = param1.cell as RoomListPlayerItem;
            _currentItem.setListCellStatus(_playerList.list,true,param1.index);
         }
         if(_currentItem != param1.cell as RoomListPlayerItem)
         {
            _currentItem.setListCellStatus(_playerList.list,false,param1.index);
            _currentItem = param1.cell as RoomListPlayerItem;
            _currentItem.setListCellStatus(_playerList.list,true,param1.index);
         }
      }
      
      private function getInsertIndex(param1:PlayerInfo) : int
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = _playerList.vectorListModel.elements;
         if(_loc3_.length == 0)
         {
            return 0;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = _loc3_[_loc5_] as PlayerInfo;
            if(!(param1.IsVIP && !_loc4_.IsVIP))
            {
               if(!param1.IsVIP && _loc4_.IsVIP)
               {
                  return _loc5_ + 1;
               }
               if(param1.IsVIP == _loc4_.IsVIP)
               {
                  if(param1.Grade > _loc4_.Grade)
                  {
                     _loc2_ = _loc5_ - 1;
                  }
                  else
                  {
                     return _loc5_ + 1;
                  }
               }
            }
            _loc5_--;
         }
         return _loc2_ < 0?0:_loc2_;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         SocketManager.Instance.dispatchEvent(new NewHallEvent("showbuffcontrol"));
         _data.removeEventListener("add",__addPlayer);
         _data.removeEventListener("remove",__removePlayer);
         _data.removeEventListener("update",__updatePlayer);
         _playerList.list.removeEventListener("listItemClick",__itemClick);
         _player.dispose();
         _player = null;
         _levelIcon.dispose();
         _levelIcon = null;
         if(_listbg2)
         {
            ObjectUtils.disposeObject(_listbg2);
         }
         _listbg2 = null;
         if(_nickNameText)
         {
            _nickNameText.dispose();
         }
         _nickNameText = null;
         if(_repute)
         {
            ObjectUtils.disposeObject(_repute);
         }
         _repute = null;
         _consortiaNameText.dispose();
         _consortiaNameText = null;
         _reputeText.dispose();
         _reputeText = null;
         if(_characterBg)
         {
            ObjectUtils.disposeObject(_characterBg);
         }
         _characterBg = null;
         if(_propbg)
         {
            ObjectUtils.disposeObject(_propbg);
         }
         _propbg = null;
         if(_listbg)
         {
            ObjectUtils.disposeObject(_listbg);
         }
         _listbg = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_geste)
         {
            ObjectUtils.disposeObject(_geste);
         }
         _geste = null;
         if(_sex)
         {
            ObjectUtils.disposeObject(_sex);
         }
         _sex = null;
         if(_buffbgVec)
         {
            _loc1_ = 0;
            while(_loc1_ < _buffbgVec.length)
            {
               ObjectUtils.disposeObject(_buffbgVec[_loc1_]);
               _buffbgVec[_loc1_] = null;
               _loc1_++;
            }
            _buffbgVec = null;
         }
         _gesteText.dispose();
         _gesteText = null;
         _playerList.vectorListModel.clear();
         _playerList.dispose();
         _playerList = null;
         _data = null;
         if(_currentItem)
         {
            _currentItem.dispose();
         }
         _currentItem = null;
         ObjectUtils.disposeAllChildren(_iconContainer);
         ObjectUtils.disposeObject(_iconContainer);
         _marriedIcon = null;
         _guardCoreIcon = null;
         _iconContainer = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
