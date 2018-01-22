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
      
      public function SingleBattleMatchingView(param1:GameInfo){super(null);}
      
      override protected function init() : void{}
      
      override protected function __countDownTick(param1:TimerEvent) : void{}
      
      override protected function initRoomItem(param1:RoomLoadingCharacterItem) : void{}
      
      protected function __onStartLoad(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
