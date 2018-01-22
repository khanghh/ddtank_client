package gameStarling.actions.newHand
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
         var _loc1_:RoomInfo = RoomManager.Instance.current;
         if(!_gameInfo || !_loc1_)
         {
            return false;
         }
         return WeakGuildManager.Instance.switchUserGuide && _gameInfo.livings.length == 2 && _gameInfo.IsOneOnOne && (_loc1_.type == 0 || _loc1_.type == 1);
      }
      
      protected function showFightTip(param1:String, param2:Number = 1) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(param1),0,false,param2);
      }
   }
}
