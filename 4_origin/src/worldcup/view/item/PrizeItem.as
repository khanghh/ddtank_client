package worldcup.view.item
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import worldcup.WorldcupManager;
   import worldcup.view.mornui.item.PrizeItemUI;
   
   public class PrizeItem extends PrizeItemUI
   {
       
      
      private var _index:int;
      
      public function PrizeItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         getPrizeBtn.clickHandler = new Handler(getClickHandler);
      }
      
      private function getClickHandler() : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.getWorldcupPrize(_index + 1);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
         updataInfo();
      }
      
      private function updataInfo() : void
      {
         if(_index % 2 == 0)
         {
            prizeItemBg.skin = "asset.worldcup.listBg1";
         }
         else
         {
            prizeItemBg.skin = "asset.worldcup.listBg2";
         }
         var moneyType:String = ServerConfigManager.instance.worldcupBackRate[0] == 1?LanguageMgr.GetTranslation("ddt.worldcupGuess.rechargeInfo.moneyType1"):LanguageMgr.GetTranslation("ddt.worldcupGuess.rechargeInfo.moneyType2");
         totalRechargeTxt.text = LanguageMgr.GetTranslation("ddt.worldcupGuess.rechargeInfo1",ServerConfigManager.instance.worldcupAwardCount[_index]);
         var returnMoney:String = "";
         if(WorldcupManager.instance.model.returnRate != 0)
         {
            returnMoney = String(ServerConfigManager.instance.worldcupAwardCount[_index] * WorldcupManager.instance.model.returnRate / 100);
         }
         else
         {
            returnMoney = String(ServerConfigManager.instance.worldcupAwardCount[_index]) + "*?";
         }
         prizeInfoTxt.text = LanguageMgr.GetTranslation("ddt.worldcupGuess.rechargeInfo2",returnMoney,moneyType);
         refreshInfo();
      }
      
      public function refreshInfo() : void
      {
         if(WorldcupManager.instance.model.state != 4 || WorldcupManager.instance.model.supportCountry == 0)
         {
            getPrizeBtn.disabled = true;
            getPrizeBtn.visible = true;
            getAlreadyIcon.visible = false;
            return;
         }
         if(WorldcupManager.instance.model.totalRecharge >= ServerConfigManager.instance.worldcupAwardCount[_index])
         {
            getPrizeBtn.disabled = false;
         }
         else
         {
            getPrizeBtn.disabled = true;
         }
         if((WorldcupManager.instance.model.awardIndex >> _index) % 2 == 0)
         {
            getPrizeBtn.visible = true;
            getAlreadyIcon.visible = false;
         }
         else
         {
            getPrizeBtn.visible = false;
            getAlreadyIcon.visible = true;
         }
      }
   }
}
