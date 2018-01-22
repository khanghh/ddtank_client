package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Living;
   
   public class LivingDeadEffectAction extends BaseAction
   {
       
      
      private var _args:Array;
      
      private var _completeCount:int;
      
      public function LivingDeadEffectAction(param1:Array)
      {
         super();
         _args = param1;
      }
      
      override public function prepare() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _args.length)
         {
            _loc2_ = _args[_loc4_];
            _loc3_ = _loc2_.target;
            _loc1_ = _loc2_.deadEffect;
            _loc3_.showDeadEffect(_loc1_,showDeadEffectHandler,[_loc2_]);
            _loc4_++;
         }
      }
      
      private function showDeadEffectHandler(param1:Array) : void
      {
         var _loc2_:Object = param1[0];
         var _loc3_:Living = _loc2_.target;
         _loc3_.updateBlood(_loc2_.targetBlood,_loc2_.type,_loc2_.damage);
         _completeCount = Number(_completeCount) + 1;
      }
      
      override public function execute() : void
      {
         if(_completeCount == _args.length)
         {
            _isFinished = true;
         }
      }
   }
}
