package labyrinth.view
{
   import baglocked.BaglockedManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.MouseEvent;
   import gameCommon.TryAgain;
   import gameCommon.model.MissionAgainInfo;
   
   public class LabyrinthTryAgain extends TryAgain
   {
       
      
      public function LabyrinthTryAgain(info:MissionAgainInfo, isShowNum:Boolean = true)
      {
         super(info,isShowNum);
      }
      
      override protected function __tryagainClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         CheckMoneyUtils.instance.checkMoney(_selectedItem.isBind,_info.value,onCheckComplete);
      }
      
      override protected function onCheckComplete() : void
      {
         tryagain(CheckMoneyUtils.instance.isBind);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
