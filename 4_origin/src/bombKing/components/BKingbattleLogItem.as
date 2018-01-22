package bombKing.components
{
   import bombKing.BombKingControl;
   import bombKing.BombKingManager;
   import bombKing.data.BKingLogInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   
   public class BKingbattleLogItem extends Sprite implements Disposeable
   {
       
      
      private var _infoTxt:FilterFrameText;
      
      private var _logTxt:FilterFrameText;
      
      private var _info:BKingLogInfo;
      
      public function BKingbattleLogItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _infoTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.Log.infoTxt");
         addChild(_infoTxt);
         _infoTxt.htmlText = LanguageMgr.GetTranslation("bombKing.log.infoTxt","冠军赛","今晚吃什么","铁板牛肉行不行");
         _logTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.Log.logTxt");
         addChild(_logTxt);
         var _loc1_:String = LanguageMgr.GetTranslation("bombKing.log.logTxt","test");
         _logTxt.htmlText = _loc1_;
         _logTxt.mouseEnabled = true;
         _logTxt.setFocus();
      }
      
      private function initEvents() : void
      {
         _logTxt.addEventListener("link",__linkHandler);
      }
      
      protected function __linkHandler(param1:TextEvent) : void
      {
         if(BombKingControl.instance.status != 2)
         {
            BombKingControl.instance.ReportID = _info.reportId;
            SocketManager.Instance.out.sendNewHallBattle();
            BombKingManager.instance.Recording = true;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bombKing.cancelFirst"));
         }
      }
      
      public function get info() : BKingLogInfo
      {
         return _info;
      }
      
      public function set info(param1:BKingLogInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
         var _loc2_:Array = getResultStr(_info.result);
         _infoTxt.htmlText = LanguageMgr.GetTranslation("bombKing.log.infoTxt",getTitle(param1.stage),param1.name + _loc2_[0],param1.fightName + _loc2_[1]);
         _logTxt.htmlText = LanguageMgr.GetTranslation("bombKing.log.logTxt",param1.reportId);
      }
      
      private function getTitle(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("bombKing.log.stage1");
            case 1:
               return LanguageMgr.GetTranslation("bombKing.log.stage2");
            case 2:
               return LanguageMgr.GetTranslation("bombKing.log.stage3");
            case 3:
               return LanguageMgr.GetTranslation("bombKing.log.stage4");
            case 4:
               return LanguageMgr.GetTranslation("bombKing.log.stage5");
            case 5:
               return LanguageMgr.GetTranslation("bombKing.log.stage6");
            case 6:
               return LanguageMgr.GetTranslation("bombKing.log.stage7");
         }
      }
      
      private function getResultStr(param1:Boolean) : Array
      {
         if(param1)
         {
            return [LanguageMgr.GetTranslation("bombKing.win"),LanguageMgr.GetTranslation("bombKing.lose")];
         }
         return [LanguageMgr.GetTranslation("bombKing.lose"),LanguageMgr.GetTranslation("bombKing.win")];
      }
      
      private function removeEvents() : void
      {
         _logTxt.removeEventListener("link",__linkHandler);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_infoTxt);
         _infoTxt = null;
         ObjectUtils.disposeObject(_logTxt);
         _logTxt = null;
      }
   }
}
