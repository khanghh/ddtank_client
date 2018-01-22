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
      
      public function excute(param1:Object) : *
      {
         var _loc2_:int = param1;
         if(PlayerManager.Instance.Self.bagLocked && PlayerManager.Instance.isBagLockedPSWNeeded(_loc2_))
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
