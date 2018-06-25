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
      
      public function DevilTurnBoxConvertView()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         _model = DevilTurnManager.instance.model;
         super.preinitialize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text9.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label9");
         closeBtn.clickHandler = new Handler(onClickCose);
         beadList.renderHandler = new Handler(onBeadListRender);
         beadList.array = _model.boxConverList;
         __onUpdateInfo(null);
         DevilTurnManager.instance.addEventListener("updateinfo",__onUpdateInfo);
      }
      
      private function __onUpdateInfo(e:DevilTurnEvent) : void
      {
         beadText1.text = _model.beadCount1.toString();
         beadText2.text = _model.beadCount2.toString();
         beadText3.text = _model.beadCount3.toString();
         beadText4.text = _model.beadCount4.toString();
         beadText5.text = _model.beadCount5.toString();
      }
      
      private function onBeadListRender(item:Box, index:int) : void
      {
         var view:DevilTurnBoxConvertItem = item as DevilTurnBoxConvertItem;
         if(index < beadList.array.length)
         {
            view.info = beadList.array[index] as DevilTurnBoxItem;
         }
         else
         {
            view.info = null;
         }
      }
      
      private function onClickCose() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         DevilTurnManager.instance.removeEventListener("updateinfo",__onUpdateInfo);
         super.dispose();
      }
   }
}
