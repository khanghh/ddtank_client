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
       
      
      public function LabyrinthTryAgain(param1:MissionAgainInfo, param2:Boolean = true){super(null,null);}
      
      override protected function __tryagainClick(param1:MouseEvent) : void{}
      
      override protected function onCheckComplete() : void{}
      
      override public function dispose() : void{}
   }
}
