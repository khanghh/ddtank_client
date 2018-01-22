package gameCommon.actions
{
   public class BaseAction
   {
       
      
      protected var _isFinished:Boolean;
      
      protected var _isPrepare:Boolean;
      
      public function BaseAction(){super();}
      
      public function connect(param1:BaseAction) : Boolean{return false;}
      
      public function canReplace(param1:BaseAction) : Boolean{return false;}
      
      public function get isFinished() : Boolean{return false;}
      
      public function prepare() : void{}
      
      public function execute() : void{}
      
      public function executeAtOnce() : void{}
      
      public function cancel() : void{}
   }
}
