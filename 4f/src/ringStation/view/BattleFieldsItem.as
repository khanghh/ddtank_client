package ringStation.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import ringStation.model.BattleFieldListItemInfo;
   import vip.VipController;
   
   public class BattleFieldsItem extends Sprite implements Disposeable
   {
       
      
      private var _fightIconBg:Bitmap;
      
      private var _fightIcon:Bitmap;
      
      private var _infoText:FilterFrameText;
      
      private var _index:int;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _battleInfo:BattleFieldListItemInfo;
      
      private var _playerInfo:PlayerInfo;
      
      private var msgID:String = "1";
      
      public function BattleFieldsItem(param1:int){super();}
      
      private function init() : void{}
      
      public function update(param1:BattleFieldListItemInfo) : void{}
      
      private function findPlayer(param1:String) : void{}
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateTxt() : void{}
      
      private function updateText(param1:BattleFieldListItemInfo) : String{return null;}
      
      private function setUerNameLength(param1:String) : String{return null;}
      
      private function __nickNameLinkHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
