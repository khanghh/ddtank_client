package gameCommon.actions
{
   public class BaseAction
   {
       
      
      protected var _isFinished:Boolean;
      
      protected var _isPrepare:Boolean;
      
      public function BaseAction()
      {
         super();
         _isFinished = false;
      }
      
      public function connect(param1:BaseAction) : Boolean
      {
         return false;
      }
      
      public function canReplace(param1:BaseAction) : Boolean
      {
         return false;
      }
      
      public function get isFinished() : Boolean
      {
         return _isFinished;
      }
      
      public function prepare() : void
      {
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
      }
      
      public function execute() : void
      {
         executeAtOnce();
         _isFinished = true;
      }
      
      public function executeAtOnce() : void
      {
         prepare();
         _isFinished = true;
      }
      
      public function cancel() : void
      {
      }
   }
}
