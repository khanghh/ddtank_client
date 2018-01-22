package game.actions.SkillActions
{
   import game.animations.IAnimate;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import road7th.comm.PackageIn;
   
   public class RevertAction extends SkillAction
   {
       
      
      private var _pkg:PackageIn;
      
      private var _src:Living;
      
      public function RevertAction(param1:IAnimate, param2:Living, param3:PackageIn)
      {
         _pkg = param3;
         _src = param2;
         super(param1);
      }
      
      override protected function finish() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = _pkg.readInt();
         var _loc3_:Vector.<Living> = new Vector.<Living>();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_.push(GameControl.Instance.Current.findLiving(_pkg.readInt()));
            _loc5_++;
         }
         var _loc1_:int = _pkg.readInt();
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc4_.updateBlood(_loc4_.blood + _loc1_,0,_loc1_);
         }
         super.finish();
      }
   }
}
