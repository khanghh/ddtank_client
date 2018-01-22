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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("game.playerThumbnailTipBg");
         addChild(_bg);
         _items = new Vector.<SimpleItem>();
         var _loc3_:Point = PositionUtils.creatPoint("game.PlayerThumbnailTipItemPos");
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("game.PlayerThumbnailTipItem");
            (_loc1_.foreItems[0] as FilterFrameText).text = LanguageMgr.GetTranslation("game.PlayerThumbnailTipItemText_" + _loc2_.toString());
            _loc1_.addEventListener("rollOver",__onMouseOver);
            _loc1_.addEventListener("rollOut",__onMouseOut);
            _loc1_.addEventListener("click",__onMouseClick);
            _loc1_.backItem.visible = false;
            _loc1_.buttonMode = true;
            _loc1_.x = _loc3_.x;
            _loc1_.y = _loc3_.y;
            _loc3_.y = _loc3_.y + (_loc1_.height - 2);
            _items.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
         addEventListener("addedToStage",__addStageEvent);
         addEventListener("removedFromStage",__removeFromStage);
      }
      
      public function set tipDisplay(param1:PlayerThumbnail) : void
      {
         _playerTipDisplay = param1;
      }
      
      public function get tipDisplay() : PlayerThumbnail
      {
         return _playerTipDisplay;
      }
      
      private function __addStageEvent(param1:Event) : void
      {
         StageReferance.stage.addEventListener("click",__removeStageEvent);
      }
      
      private function __removeStageEvent(param1:MouseEvent) : void
      {
         if(param1.target is HeadFigure)
         {
            return;
         }
         StageReferance.stage.removeEventListener("click",__removeStageEvent);
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __removeFromStage(param1:Event) : void
      {
         dispatchEvent(new Event("playerThumbnailTipItemClick"));
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:SimpleItem = param1.currentTarget as SimpleItem;
         if(_loc2_ && _loc2_.backItem)
         {
            _loc2_.backItem.visible = true;
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:SimpleItem = param1.currentTarget as SimpleItem;
         if(_loc2_ && _loc2_.backItem)
         {
            _loc2_.backItem.visible = false;
         }
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         PlayerInfoViewControl.isOpenFromBag = false;
         var _loc5_:SimpleItem = param1.currentTarget as SimpleItem;
         var _loc4_:int = _items.indexOf(_loc5_);
         _isBattle = false;
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 18)
         {
            _isBattle = true;
         }
         switch(int(_loc4_))
         {
            case 0:
               if(_isBattle)
               {
                  PlayerInfoViewControl._isBattle = _isBattle;
                  _loc6_ = _playerTipDisplay.info;
                  _loc6_.Agility = BattleGroudControl.Instance.playerBattleData.Agility;
                  _loc6_.Attack = BattleGroudControl.Instance.playerBattleData.Attack;
                  _loc6_.Defence = BattleGroudControl.Instance.playerBattleData.Defend;
                  _loc6_.Luck = BattleGroudControl.Instance.playerBattleData.Lucky;
                  _loc6_.Damage = BattleGroudControl.Instance.playerBattleData.Damage;
                  _loc6_.Blood = BattleGroudControl.Instance.playerBattleData.Blood;
                  _loc6_.Energy = BattleGroudControl.Instance.playerBattleData.Energy;
                  _loc6_.Guard = BattleGroudControl.Instance.playerBattleData.Guard;
                  PlayerInfoViewControl.view(_loc6_,false,_isBattle);
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
                  _loc2_ = new AreaInfo();
                  _loc2_.areaID = _playerTipDisplay.info.ZoneID;
                  _loc7_ = PlayerManager.Instance.getAreaNameByAreaID(_playerTipDisplay.info.ZoneID);
                  _loc2_.areaName = _loc7_;
                  ChatManager.Instance.output.functionEnabled = true;
                  ChatManager.Instance.privateChatTo(_playerTipDisplay.info.NickName,0,_loc2_);
                  break;
               }
               ChatManager.Instance.privateChatTo(_playerTipDisplay.info.NickName);
               _loc3_ = true;
               break;
         }
         StageReferance.stage.removeEventListener("click",__removeStageEvent);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_loc3_)
         {
            ChatManager.Instance.setFocus();
         }
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _isBattle = false;
         _playerTipDisplay = null;
         ObjectUtils.disposeObject(_bg);
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_];
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc2_++;
         }
         _items = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
