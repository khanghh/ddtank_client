package gameCommon.view.playerThumbnail
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import battleGroud.BattleGroudControl;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.AreaInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.SimpleItem;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import room.RoomManager;
   
   [Event(name="playerThumbnailTipItemClick",type="flash.events.Event")]
   public class PlayerThumbnailTip extends Sprite implements Disposeable, ITip
   {
      
      public static const VIEW_INFO:int = 0;
      
      public static const MAKE_FRIEND:int = 1;
      
      public static const PRIVATE_CHAT:int = 2;
       
      
      private var _isBattle:Boolean;
      
      private var _bg:Image;
      
      private var _items:Vector.<SimpleItem>;
      
      private var _playerTipDisplay:PlayerThumbnail;
      
      public function PlayerThumbnailTip()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         var i:int = 0;
         var btn:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("game.playerThumbnailTipBg");
         addChild(_bg);
         _items = new Vector.<SimpleItem>();
         var pos:Point = PositionUtils.creatPoint("game.PlayerThumbnailTipItemPos");
         for(i = 0; i < 3; )
         {
            btn = ComponentFactory.Instance.creatComponentByStylename("game.PlayerThumbnailTipItem");
            (btn.foreItems[0] as FilterFrameText).text = LanguageMgr.GetTranslation("game.PlayerThumbnailTipItemText_" + i.toString());
            btn.addEventListener("rollOver",__onMouseOver);
            btn.addEventListener("rollOut",__onMouseOut);
            btn.addEventListener("click",__onMouseClick);
            btn.backItem.visible = false;
            btn.buttonMode = true;
            btn.x = pos.x;
            btn.y = pos.y;
            pos.y = pos.y + (btn.height - 2);
            _items.push(btn);
            addChild(btn);
            i++;
         }
         addEventListener("addedToStage",__addStageEvent);
         addEventListener("removedFromStage",__removeFromStage);
      }
      
      public function set tipDisplay(value:PlayerThumbnail) : void
      {
         _playerTipDisplay = value;
      }
      
      public function get tipDisplay() : PlayerThumbnail
      {
         return _playerTipDisplay;
      }
      
      private function __addStageEvent(e:Event) : void
      {
         StageReferance.stage.addEventListener("click",__removeStageEvent);
      }
      
      private function __removeStageEvent(e:MouseEvent) : void
      {
         if(e.target is HeadFigure)
         {
            return;
         }
         StageReferance.stage.removeEventListener("click",__removeStageEvent);
         e.stopImmediatePropagation();
         e.stopPropagation();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __removeFromStage(e:Event) : void
      {
         dispatchEvent(new Event("playerThumbnailTipItemClick"));
      }
      
      private function __onMouseOver(e:MouseEvent) : void
      {
         var btn:SimpleItem = e.currentTarget as SimpleItem;
         if(btn && btn.backItem)
         {
            btn.backItem.visible = true;
         }
      }
      
      private function __onMouseOut(e:MouseEvent) : void
      {
         var btn:SimpleItem = e.currentTarget as SimpleItem;
         if(btn && btn.backItem)
         {
            btn.backItem.visible = false;
         }
      }
      
      private function __onMouseClick(e:MouseEvent) : void
      {
         var toSetFocus:Boolean = false;
         var playerInfo:* = null;
         var areaInfo:* = null;
         var zoneName:* = null;
         PlayerInfoViewControl.isOpenFromBag = false;
         var btn:SimpleItem = e.currentTarget as SimpleItem;
         var idx:int = _items.indexOf(btn);
         _isBattle = false;
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 18)
         {
            _isBattle = true;
         }
         switch(int(idx))
         {
            case 0:
               if(_isBattle)
               {
                  PlayerInfoViewControl._isBattle = _isBattle;
                  playerInfo = _playerTipDisplay.info;
                  playerInfo.Agility = BattleGroudControl.Instance.playerBattleData.Agility;
                  playerInfo.Attack = BattleGroudControl.Instance.playerBattleData.Attack;
                  playerInfo.Defence = BattleGroudControl.Instance.playerBattleData.Defend;
                  playerInfo.Luck = BattleGroudControl.Instance.playerBattleData.Lucky;
                  playerInfo.Damage = BattleGroudControl.Instance.playerBattleData.Damage;
                  playerInfo.Blood = BattleGroudControl.Instance.playerBattleData.Blood;
                  playerInfo.Energy = BattleGroudControl.Instance.playerBattleData.Energy;
                  playerInfo.Guard = BattleGroudControl.Instance.playerBattleData.Guard;
                  PlayerInfoViewControl.view(playerInfo,false,_isBattle);
               }
               else
               {
                  PlayerInfoViewControl.view(_playerTipDisplay.info,false);
               }
               break;
            case 1:
               if(_playerTipDisplay.info.ZoneID > 0 && _playerTipDisplay.info.ZoneID != PlayerManager.Instance.Self.ZoneID)
               {
                  ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.AddFriendUnable"));
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("core.crossZone.AddFriendUnable"));
               }
               else if(_playerTipDisplay.getInfo().IsRobot)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.PlayerThumbnailTip.cannotAddRobotFriend"));
               }
               else
               {
                  IMManager.Instance.addFriend(_playerTipDisplay.info.NickName);
               }
               break;
            case 2:
               if(_playerTipDisplay.info.ZoneID > 0 && _playerTipDisplay.info.ZoneID != PlayerManager.Instance.Self.ZoneID)
               {
                  areaInfo = new AreaInfo();
                  areaInfo.areaID = _playerTipDisplay.info.ZoneID;
                  zoneName = PlayerManager.Instance.getAreaNameByAreaID(_playerTipDisplay.info.ZoneID);
                  areaInfo.areaName = zoneName;
                  ChatManager.Instance.output.functionEnabled = true;
                  ChatManager.Instance.privateChatTo(_playerTipDisplay.info.NickName,0,areaInfo);
                  break;
               }
               ChatManager.Instance.privateChatTo(_playerTipDisplay.info.NickName);
               toSetFocus = true;
               break;
         }
         StageReferance.stage.removeEventListener("click",__removeStageEvent);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(toSetFocus)
         {
            ChatManager.Instance.setFocus();
         }
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function set tipData(data:Object) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var btn:* = null;
         _isBattle = false;
         _playerTipDisplay = null;
         ObjectUtils.disposeObject(_bg);
         for(i = 0; i < _items.length; )
         {
            btn = _items[i];
            ObjectUtils.disposeObject(btn);
            btn = null;
            i++;
         }
         _items = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
