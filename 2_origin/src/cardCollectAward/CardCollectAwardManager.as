package cardCollectAward
{
   import cardCollectAward.data.CardCollectAwardInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class CardCollectAwardManager extends EventDispatcher
   {
      
      public static const OPEN_VIEW:String = "openView";
      
      private static var awardM:CardCollectAwardManager;
       
      
      private var _dataPkg:PackageIn = null;
      
      private var _showAward:Boolean = false;
      
      private var _awardInfo:CardCollectAwardInfo = null;
      
      public function CardCollectAwardManager(param1:IEventDispatcher = null)
      {
         _awardInfo = new CardCollectAwardInfo();
         super(param1);
      }
      
      public static function get Instance() : CardCollectAwardManager
      {
         if(awardM == null)
         {
            awardM = new CardCollectAwardManager();
         }
         return awardM;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,55),openView_Handler);
      }
      
      private function initData() : void
      {
         _awardInfo.title = "版本更新，认真填写！";
         _awardInfo.desc = "版本更新，认真填写";
         _awardInfo.minLv = 12;
         _awardInfo.quertions = "体验感,开心;一般;痛哭;|最有爱的更新,试练之地;弹弹奇缘功能体验亮点;暂未体验;|更多期待,竞技玩法;休闲玩法如;|最不给力的玩法,试练之地玩法;弹弹奇缘活动;温泉系统;";
         _awardInfo.qq = "1234567";
         _awardInfo.phone = "3156416546";
         showView();
      }
      
      protected function openView_Handler(param1:PkgEvent) : void
      {
         _dataPkg = param1.pkg;
         if(_awardInfo != null)
         {
            _awardInfo.title = _dataPkg.readUTF();
            _awardInfo.desc = _dataPkg.readUTF();
            _awardInfo.minLv = _dataPkg.readInt();
            _awardInfo.quertions = _dataPkg.readUTF();
            _awardInfo.beginTime = _dataPkg.readDate();
            _awardInfo.endTime = _dataPkg.readDate();
            _awardInfo.qq = _dataPkg.readUTF();
            _awardInfo.phone = _dataPkg.readUTF();
         }
         showView();
      }
      
      public function showView() : void
      {
         if(_showAward && _dataPkg != null)
         {
            if(_awardInfo == null)
            {
               return;
            }
            new HelperUIModuleLoad().loadUIModule(["cardCollectAward"],function():void
            {
               _showAward = false;
               dispatchEvent(new CEvent("openView"));
            });
         }
         else
         {
            _showAward = true;
         }
      }
      
      public function get awardInfo() : CardCollectAwardInfo
      {
         return _awardInfo;
      }
      
      public function closeAward() : void
      {
         _dataPkg = null;
         _awardInfo = null;
         _showAward = false;
      }
      
      public function dataPkg() : PackageIn
      {
         return _dataPkg;
      }
   }
}
