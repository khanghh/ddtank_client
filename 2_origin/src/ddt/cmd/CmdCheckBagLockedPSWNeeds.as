package ddt.cmd
{
   import baglocked.BaglockedManager;
   import ddt.manager.PlayerManager;
   
   public class CmdCheckBagLockedPSWNeeds implements iCmd
   {
       
      
      public function CmdCheckBagLockedPSWNeeds()
      {
         super();
      }
      
      public function excute(data:Object) : *
      {
         var type:int = data;
         if(PlayerManager.Instance.Self.bagLocked && PlayerManager.Instance.isBagLockedPSWNeeded(type))
         {
            BaglockedManager.Instance.show();
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
      }
   }
}
