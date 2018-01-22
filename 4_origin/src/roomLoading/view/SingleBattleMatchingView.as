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
      
      public function SingleBattleMatchingView(param1:GameInfo)
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         super(param1);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
         _matchTxt = ComponentFactory.Instance.creatBitmap("asset.room.view.roomView.SingleBattleMatch.matchTxt");
         _matchTxt.x = 407;
         _matchTxt.y = 368;
         addChild(_matchTxt);
         _playerArr = [];
         var _loc3_:int = _gameInfo.roomPlayers.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
            PositionUtils.setPos(_loc2_,"asset.roomLoading.CharacterItemRedPos_1");
            addChild(_loc2_);
            _loc2_.x = _loc2_.x + 90 * _loc4_;
            _loc2_.y = _loc2_.y + 62;
            _playerArr.push(_loc2_);
            _loc4_++;
         }
      }
      
      override protected function init() : void
      {
         super.init();
         StateManager.currentStateType = "singleBattleMatching";
      }
      
      override protected function __countDownTick(param1:TimerEvent) : void
      {
         _countDownTxt.updateNum();
      }
      
      override protected function initRoomItem(param1:RoomLoadingCharacterItem) : void
      {
         super.initRoomItem(param1);
         param1.removePerecentageTxt();
      }
      
      protected function __onStartLoad(param1:Event) : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         StateManager.setState("roomLoading",GameControl.Instance.Current);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         GameControl.Instance.removeEventListener("StartLoading",__onStartLoad);
         if(_matchTxt)
         {
            ObjectUtils.disposeObject(_matchTxt);
         }
         _matchTxt = null;
         _loc1_ = 0;
         while(_loc1_ < _playerArr.length)
         {
            ObjectUtils.disposeObject(_playerArr[_loc1_]);
            _playerArr[_loc1_] = null;
            _loc1_++;
         }
         _playerArr = null;
      }
   }
}
