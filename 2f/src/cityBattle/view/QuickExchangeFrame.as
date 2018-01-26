package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.WelfareInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class QuickExchangeFrame extends QuickBuyAlertBase
   {
       
      
      protected var _exchangeTxt:FilterFrameText;
      
      protected var _restTitleText:FilterFrameText;
      
      protected var _restText:FilterFrameText;
      
      public var type:int;
      
      public function QuickExchangeFrame(){super();}
      
      override protected function initView() : void{}
      
      override protected function refreshNumText() : void{}
      
      override public function setData(param1:int, param2:int, param3:int) : void{}
      
      override protected function __buy(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
