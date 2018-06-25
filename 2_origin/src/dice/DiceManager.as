package dice
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import dice.controller.DiceController;
   import road7th.comm.PackageIn;
   
   public class DiceManager extends CoreManager
   {
      
      private static var _instance:DiceManager;
       
      
      private var _callBack:Function;
      
      private var _isopen:Boolean = false;
      
      private var _pkg:PackageIn;
      
      public function DiceManager()
      {
         super();
         SocketManager.Instance.addEventListener("dice_active_open",__showEnterIcon);
         SocketManager.Instance.addEventListener("dice_active_close",__hideEnterIcon);
      }
      
      public static function get Instance() : DiceManager
      {
         if(_instance == null)
         {
            _instance = new DiceManager();
         }
         return _instance;
      }
      
      public function setup(callBack:Function = null) : void
      {
         if(callBack != null)
         {
            _callBack = callBack;
            if(DiceController.Instance.canUseModel)
            {
               _callBack(true);
            }
         }
      }
      
      public function get isopen() : Boolean
      {
         return _isopen;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["dice"],loaderDice);
      }
      
      public function __showEnterIcon(event:CrazyTankSocketEvent) : void
      {
         _isopen = true;
         _pkg = event.pkg;
         show();
      }
      
      private function loaderDice() : void
      {
         DiceController.Instance.install(_pkg);
         if(_callBack != null)
         {
            _callBack(true);
         }
      }
      
      private function __hideEnterIcon(event:CrazyTankSocketEvent) : void
      {
         _isopen = false;
         if(_callBack != null)
         {
            _callBack(false);
            DiceController.Instance.unInstall();
         }
      }
   }
}
