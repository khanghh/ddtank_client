package game.actions.newHand
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import room.RoomManager;
   import room.model.RoomInfo;
   import trainer.controller.WeakGuildManager;
   
   class BaseNewHandFightHelpAction extends BaseAction
   {
       
      
      protected var _gameInfo:GameInfo;
      
      function BaseNewHandFightHelpAction()
      {
         super();
         _gameInfo = GameControl.Instance.Current;
      }
      
      protected function get isInNewHandRoom() : Boolean
      {
         var roomInfo:RoomInfo = RoomManager.Instance.current;
         if(!_gameInfo || !roomInfo)
         {
            return false;
         }
         return WeakGuildManager.Instance.switchUserGuide && _gameInfo.livings.length == 2 && _gameInfo.IsOneOnOne && (roomInfo.type == 0 || roomInfo.type == 1);
      }
      
      protected function showFightTip(tipStyle:String, duration:Number = 1) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(tipStyle),0,false,duration);
      }
   }
}
