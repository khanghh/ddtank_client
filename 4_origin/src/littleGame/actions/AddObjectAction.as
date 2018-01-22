package littleGame.actions
{
   import littleGame.LittleGameManager;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   import road7th.comm.PackageIn;
   
   public class AddObjectAction extends LittleAction
   {
       
      
      private var _scene:Scenario;
      
      private var _pkg:PackageIn;
      
      public function AddObjectAction()
      {
         super();
      }
      
      override public function parsePackege(param1:Scenario, param2:PackageIn = null) : void
      {
         _scene = param1;
         _pkg = param2;
         var _loc3_:int = _pkg.readInt();
         var _loc4_:LittleLiving = _scene.findLiving(_loc3_);
         if(_loc4_)
         {
            _loc4_.act(this);
         }
      }
      
      override public function execute() : void
      {
         var _loc1_:String = _pkg.readUTF();
         LittleGameManager.Instance.addObject(_scene,_loc1_,_pkg);
         finish();
      }
   }
}
