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
      
      public function PlayerThumbnailTip(){super();}
      
      public function init() : void{}
      
      public function set tipDisplay(param1:PlayerThumbnail) : void{}
      
      public function get tipDisplay() : PlayerThumbnail{return null;}
      
      private function __addStageEvent(param1:Event) : void{}
      
      private function __removeStageEvent(param1:MouseEvent) : void{}
      
      private function __removeFromStage(param1:Event) : void{}
      
      private function __onMouseOver(param1:MouseEvent) : void{}
      
      private function __onMouseOut(param1:MouseEvent) : void{}
      
      private function __onMouseClick(param1:MouseEvent) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
