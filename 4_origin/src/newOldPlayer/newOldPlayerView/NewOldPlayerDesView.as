package newOldPlayer.newOldPlayerView
{
   import ddt.manager.LanguageMgr;
   import newOldPlayer.NewOldPlayerManager;
   import newOldPlayer.newOldPlayerUI.view.NewOldPlayerDesUI;
   
   public class NewOldPlayerDesView extends NewOldPlayerDesUI
   {
       
      
      public function NewOldPlayerDesView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         rechargeMoney.text = String(NewOldPlayerManager.instance.rechargeMoney) + LanguageMgr.GetTranslation("tank.oldPlayer.bindMoney");
         AllMoney.text = String(NewOldPlayerManager.instance.rechargeMoney + NewOldPlayerManager.instance.exchangeMoney) + LanguageMgr.GetTranslation("tank.oldPlayer.bindMoney");
         AllMoneyImg.count = NewOldPlayerManager.instance.rechargeMoney + NewOldPlayerManager.instance.exchangeMoney;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
