package game.actions
{
   import ddt.manager.GameInSocketOut;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.LocalPlayer;
   
   public class SelfSkipAction extends BaseAction
   {
       
      
      private var _info:LocalPlayer;
      
      public function SelfSkipAction(info:LocalPlayer)
      {
         super();
         _info = info;
      }
      
      override public function prepare() : void
      {
         if(_isPrepare)
         {
            return;
         }
         GameInSocketOut.sendGameSkipNext(_info.shootTime);
         _isPrepare = true;
      }
   }
}
