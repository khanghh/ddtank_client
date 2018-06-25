package littleGame.actions
{
   import littleGame.model.LittleLiving;
   
   public class LittleLivingBornAction extends LittleAction
   {
       
      
      private var _life:int;
      
      private var _lifeTime:int;
      
      public function LittleLivingBornAction(living:LittleLiving, life:int = 10)
      {
         _living = living;
         super();
      }
      
      override public function prepare() : void
      {
         _living.borning = true;
         _life = _living.bornLife;
         _living.doAction("born");
         super.prepare();
      }
      
      override public function execute() : void
      {
         _lifeTime = Number(_lifeTime) + 1;
         if(_lifeTime >= _life)
         {
            finish();
         }
      }
      
      override protected function finish() : void
      {
         _living.borning = false;
         _living.stand();
         super.finish();
      }
   }
}
