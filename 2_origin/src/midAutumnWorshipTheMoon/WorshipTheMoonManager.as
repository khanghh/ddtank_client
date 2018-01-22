package midAutumnWorshipTheMoon
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.utils.ByteArray;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonAwardsBoxInfo;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonModel;
   import midAutumnWorshipTheMoon.view.WorshipTheMoonEnterButton;
   
   public class WorshipTheMoonManager extends CoreManager
   {
      
      public static const SHOW_FRAME:String = "wship_show";
      
      public static const HIDE:String = "wship_hide";
      
      public static const DISPOSE_FRAME:String = "wship_dispose_frame";
      
      public static const DISPOSE:String = "wship_dispose";
      
      private static var instance:WorshipTheMoonManager;
       
      
      private var _showFrameBtn:WorshipTheMoonEnterButton;
      
      private var _hall:HallStateView;
      
      public var _isOpen:Boolean = false;
      
      public var showBuyCountFram:Boolean = true;
      
      public var dataTime:String = "";
      
      public var dataEndTime:String = "";
      
      public function WorshipTheMoonManager(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : WorshipTheMoonManager
      {
         if(!instance)
         {
            instance = new WorshipTheMoonManager(new inner());
         }
         return instance;
      }
      
      override protected function start() : void
      {
         showFrame();
      }
      
      public function init(param1:HallStateView = null) : void
      {
         _hall = param1;
         initEvents();
      }
      
      private function initEvents() : void
      {
         var _loc1_:int = 281;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,1),onResultIsActivityOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,4),onResultAwardsList);
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,2),onResultFreeCounts);
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,3),onResultWorshipTheMoon);
      }
      
      private function removeEvents() : void
      {
         var _loc1_:int = 281;
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc1_,1),onResultIsActivityOpen);
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc1_,4),onResultAwardsList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc1_,2),onResultFreeCounts);
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc1_,3),onResultWorshipTheMoon);
      }
      
      protected function onResultIsActivityOpen(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _isOpen = _loc3_;
         WorshipTheMoonModel.getInstance().updateIsOpen(_loc3_);
         worshipTheMoonIcon(_loc3_);
         if(_loc3_)
         {
            dataTime = _loc2_.readUTF();
            dataEndTime = _loc2_.readUTF();
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("worshipTheMoon.chatMsg.open"));
         }
         else if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("worshipTheMoon.chatMsg.close"));
         }
      }
      
      public function worshipTheMoonIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("worshipTheMoon",param1);
      }
      
      public function showFrame() : void
      {
         if(PlayerManager.Instance.Self.Grade < 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",15));
            return;
         }
         new HelperUIModuleLoad().loadUIModule(["worshipTheMoon"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new CEvent("wship_show"));
         requireAwardsList();
         requireFreeCount();
      }
      
      protected function onResultAwardsList(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg;
         var _loc5_:int = _loc2_.readInt();
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:Vector.<int> = new Vector.<int>();
         while(_loc2_.bytesAvailable)
         {
            _loc4_.push(_loc2_.readInt());
         }
         WorshipTheMoonModel.getInstance().update200TimesGain(_loc5_);
         WorshipTheMoonModel.getInstance().updateItemsCanGainsIDList(_loc4_);
      }
      
      protected function onResultFreeCounts(param1:PkgEvent) : void
      {
         var _loc4_:ByteArray = param1.pkg;
         var _loc5_:int = _loc4_.readInt();
         var _loc6_:int = _loc4_.readInt();
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
         WorshipTheMoonModel.getInstance().updateFreeCounts(_loc5_);
         WorshipTheMoonModel.getInstance().updateWorshipedCounts(_loc6_);
         WorshipTheMoonModel.getInstance().update200State(_loc2_);
         WorshipTheMoonModel.getInstance().updatePrice(_loc3_);
      }
      
      protected function onResultWorshipTheMoon(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg;
         var _loc3_:Vector.<WorshipTheMoonAwardsBoxInfo> = new Vector.<WorshipTheMoonAwardsBoxInfo>();
         _loc2_.readInt();
         while(_loc2_.bytesAvailable)
         {
            _loc3_.push(new WorshipTheMoonAwardsBoxInfo(_loc2_.readInt(),_loc2_.readInt()));
         }
         WorshipTheMoonModel.getInstance().updateAwardsBoxInfoList(_loc3_);
      }
      
      public function requireFreeCount() : void
      {
         GameInSocketOut.sendWorshipTheMoonFreeCount();
      }
      
      public function requireAwardsList() : void
      {
         GameInSocketOut.sendWorshipTheMoonAwardsList();
      }
      
      public function requireWorshipTheMoon(param1:int) : void
      {
         var _loc2_:Boolean = false;
         if(param1 == 1)
         {
            _loc2_ = WorshipTheMoonModel.getInstance().getIsOnceBtnUseBindMoney();
         }
         else
         {
            _loc2_ = WorshipTheMoonModel.getInstance().getIsTensBtnUseBindMoney();
         }
         GameInSocketOut.sendWorshipTheMoon(param1,_loc2_);
      }
      
      public function requireWorship200AwardBox() : void
      {
         GameInSocketOut.sendGainThe200timesAwardBox();
      }
      
      public function hide() : void
      {
         dispatchEvent(new CEvent("wship_hide"));
         if(_showFrameBtn != null)
         {
            ObjectUtils.disposeObject(_showFrameBtn);
            _showFrameBtn = null;
         }
         WorshipTheMoonModel.getInstance().dispose();
      }
      
      public function disposeMainFrame() : void
      {
         dispatchEvent(new CEvent("wship_dispose_frame"));
      }
      
      public function dispose() : void
      {
         dispatchEvent(new CEvent("wship_dispose"));
         _hall = null;
         if(_showFrameBtn != null)
         {
            ObjectUtils.disposeObject(_showFrameBtn);
            _showFrameBtn = null;
         }
         WorshipTheMoonModel.getInstance().dispose();
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
