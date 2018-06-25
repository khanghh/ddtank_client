package game.actions
{
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Living;
   
   public class LivingDeadEffectAction extends BaseAction
   {
       
      
      private var _args:Array;
      
      private var _completeCount:int;
      
      public function LivingDeadEffectAction($args:Array)
      {
         super();
         _args = $args;
      }
      
      override public function prepare() : void
      {
         var i:int = 0;
         var argObj:* = null;
         var living:* = null;
         var deadEffect:* = null;
         for(i = 0; i < _args.length; )
         {
            argObj = _args[i];
            living = argObj.target;
            deadEffect = argObj.deadEffect;
            living.showDeadEffect(deadEffect,showDeadEffectHandler,[argObj]);
            i++;
         }
      }
      
      private function showDeadEffectHandler(arr:Array) : void
      {
         var argObj:Object = arr[0];
         var living:Living = argObj.target;
         living.updateBlood(argObj.targetBlood,argObj.type,argObj.damage);
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
