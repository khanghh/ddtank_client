package questionAward
{
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import questionAward.data.QuestionAwardInfo;
   import road7th.comm.PackageIn;
   
   public class QuestionAwardManager extends EventDispatcher
   {
      
      public static const OPEN_QUESTIONVIEW:String = "openQuestionView";
      
      private static var _instance:QuestionAwardManager;
       
      
      private var _dataPkg:PackageIn = null;
      
      private var _questionAwardInfo:QuestionAwardInfo;
      
      private var _questionControl:QuestionAwardControl;
      
      public function QuestionAwardManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _questionControl = new QuestionAwardControl();
      }
      
      public static function get instance() : QuestionAwardManager
      {
         if(_instance == null)
         {
            _instance = new QuestionAwardManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,57),__questionInfoHandler);
      }
      
      private function __questionInfoHandler(param1:PkgEvent) : void
      {
         _dataPkg = param1.pkg;
         _questionAwardInfo = new QuestionAwardInfo();
         _questionAwardInfo.title = _dataPkg.readUTF();
         _questionAwardInfo.addDataBaseInfo(_dataPkg.readUTF());
         _questionAwardInfo.beginTime = _dataPkg.readDate();
         _questionAwardInfo.endTime = _dataPkg.readDate();
         tryShowView();
      }
      
      public function tryShowView() : void
      {
         if(_questionControl)
         {
            _questionControl.openView();
         }
      }
      
      public function getQuestionAwardInfo() : QuestionAwardInfo
      {
         return _questionAwardInfo;
      }
      
      public function sendAnswer(param1:String) : void
      {
         SocketManager.Instance.out.sendQuestionAwardAnswer(param1);
      }
   }
}
