package roomLoading.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   
   public class SingleBattleMatchingView extends RoomLoadingView
   {
       
      
      private var _matchTxt:Bitmap;
      
      private var _playerArr:Array;
      
      public function SingleBattleMatchingView($info:GameInfo)
      {
         var i:int = 0;
         var player:* = null;
         super($info);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
         _matchTxt = ComponentFactory.Instance.creatBitmap("asset.room.view.roomView.SingleBattleMatch.matchTxt");
         _matchTxt.x = 407;
         _matchTxt.y = 368;
         addChild(_matchTxt);
         _playerArr = [];
         var len:int = _gameInfo.roomPlayers.length;
         for(i = 0; i < len; )
         {
            player = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
            PositionUtils.setPos(player,"asset.roomLoading.CharacterItemRedPos_1");
            addChild(player);
            player.x = player.x + 90 * i;
            player.y = player.y + 62;
            _playerArr.push(player);
            i++;
         }
      }
      
      override protected function init() : void
      {
         super.init();
         StateManager.currentStateType = "singleBattleMatching";
      }
      
      override protected function __countDownTick(evt:TimerEvent) : void
      {
         _countDownTxt.updateNum();
      }
      
      override protected function initRoomItem(item:RoomLoadingCharacterItem) : void
      {
         super.initRoomItem(item);
         item.removePerecentageTxt();
      }
      
      protected function __onStartLoad(event:Event) : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         StateManager.setState("roomLoading",GameControl.Instance.Current);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         GameControl.Instance.removeEventListener("StartLoading",__onStartLoad);
         if(_matchTxt)
         {
            ObjectUtils.disposeObject(_matchTxt);
         }
         _matchTxt = null;
         for(i = 0; i < _playerArr.length; )
         {
            ObjectUtils.disposeObject(_playerArr[i]);
            _playerArr[i] = null;
            i++;
         }
         _playerArr = null;
      }
   }
}
