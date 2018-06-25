package worldcup.view
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import morn.core.handlers.Handler;
   import worldcup.WorldcupControl;
   import worldcup.WorldcupManager;
   import worldcup.view.mornui.WorldCupMainViewUI;
   
   public class WorldCupMainView extends WorldCupMainViewUI
   {
       
      
      public var betView:BetView;
      
      public var prizeView:PrizeView;
      
      public function WorldCupMainView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         viewTab.selectHandler = new Handler(select);
         closeBtn.clickHandler = new Handler(closehandler);
         viewTab.selectedIndex = 0;
      }
      
      private function closehandler() : void
      {
         SoundManager.instance.playButtonSound();
         WorldcupControl.instance.disposeMainview();
      }
      
      private function select(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(index))
         {
            case 0:
               if(prizeView)
               {
                  prizeView.visible = false;
               }
               if(betView)
               {
                  betView.visible = true;
               }
               else
               {
                  betView = new BetView();
                  PositionUtils.setPos(betView,"asset.worldcup.BetView.pos");
                  addChild(betView);
               }
               break;
            case 1:
               if(betView)
               {
                  betView.visible = false;
               }
               if(prizeView)
               {
                  prizeView.visible = true;
                  break;
               }
               prizeView = new PrizeView();
               PositionUtils.setPos(prizeView,"asset.worldcup.PrizeView.pos");
               addChild(prizeView);
               break;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(betView);
         betView = null;
         ObjectUtils.disposeObject(prizeView);
         prizeView = null;
         WorldcupManager.instance.model.selectCountry = 0;
         super.dispose();
      }
   }
}
