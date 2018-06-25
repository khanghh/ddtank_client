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
      
      override public function parsePackege(scene:Scenario, pkg:PackageIn = null) : void
      {
         _scene = scene;
         _pkg = pkg;
         var id:int = _pkg.readInt();
         var living:LittleLiving = _scene.findLiving(id);
         if(living)
         {
            living.act(this);
         }
      }
      
      override public function execute() : void
      {
         var type:String = _pkg.readUTF();
         LittleGameManager.Instance.addObject(_scene,type,_pkg);
         finish();
      }
   }
}
