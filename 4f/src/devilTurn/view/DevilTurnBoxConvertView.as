package devilTurn.view
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import devilTurn.DevilTurnManager;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnBoxItem;
   import devilTurn.model.DevilTurnModel;
   import devilTurn.view.mornui.DevilTurnBoxConvertViewUI;
   import morn.core.components.Box;
   import morn.core.handlers.Handler;
   
   public class DevilTurnBoxConvertView extends DevilTurnBoxConvertViewUI
   {
       
      
      private var _model:DevilTurnModel;
      
      public function DevilTurnBoxConvertView(){super();}
      
      override protected function preinitialize() : void{}
      
      override protected function initialize() : void{}
      
      private function __onUpdateInfo(param1:DevilTurnEvent) : void{}
      
      private function onBeadListRender(param1:Box, param2:int) : void{}
      
      private function onClickCose() : void{}
      
      override public function dispose() : void{}
   }
}
