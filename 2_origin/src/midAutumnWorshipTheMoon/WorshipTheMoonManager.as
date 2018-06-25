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
      
      public function WorshipTheMoonManager(single:inner)
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
      
      public function init(hall:HallStateView = null) : void
      {
         _hall = hall;
         initEvents();
      }
      
      private function initEvents() : void
      {
         var eType:int = 281;
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,1),onResultIsActivityOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,4),onResultAwardsList);
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,2),onResultFreeCounts);
         SocketManager.Instance.addEventListener(PkgEvent.format(eType,3),onResultWorshipTheMoon);
      }
      
      private function removeEvents() : void
      {
         var eType:int = 281;
         SocketManager.Instance.removeEventListener(PkgEvent.format(eType,1),onResultIsActivityOpen);
         SocketManager.Instance.removeEventListener(PkgEvent.format(eType,4),onResultAwardsList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(eType,2),onResultFreeCounts);
         SocketManager.Instance.removeEventListener(PkgEvent.format(eType,3),onResultWorshipTheMoon);
      }
      
      protected function onResultIsActivityOpen(e:PkgEvent) : void
      {
         var bytes:ByteArray = e.pkg;
         var isOpen:Boolean = bytes.readBoolean();
         _isOpen = isOpen;
         WorshipTheMoonModel.getInstance().updateIsOpen(isOpen);
         worshipTheMoonIcon(isOpen);
         if(isOpen)
         {
            dataTime = bytes.readUTF();
            dataEndTime = bytes.readUTF();
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("worshipTheMoon.chatMsg.open"));
         }
         else if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("worshipTheMoon.chatMsg.close"));
         }
      }
      
      public function worshipTheMoonIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("worshipTheMoon",flag);
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
      
      protected function onResultAwardsList(e:PkgEvent) : void
      {
         var bytes:ByteArray = e.pkg;
         var the200ItemID:int = bytes.readInt();
         var count:int = bytes.readInt();
         var list:Vector.<int> = new Vector.<int>();
         while(bytes.bytesAvailable)
         {
            list.push(bytes.readInt());
         }
         WorshipTheMoonModel.getInstance().update200TimesGain(the200ItemID);
         WorshipTheMoonModel.getInstance().updateItemsCanGainsIDList(list);
      }
      
      protected function onResultFreeCounts(e:PkgEvent) : void
      {
         var bytes:ByteArray = e.pkg;
         var freeCount:int = bytes.readInt();
         var counts:int = bytes.readInt();
         var gainedTimes:int = bytes.readInt();
         var price:int = bytes.readInt();
         WorshipTheMoonModel.getInstance().updateFreeCounts(freeCount);
         WorshipTheMoonModel.getInstance().updateWorshipedCounts(counts);
         WorshipTheMoonModel.getInstance().update200State(gainedTimes);
         WorshipTheMoonModel.getInstance().updatePrice(price);
      }
      
      protected function onResultWorshipTheMoon(e:PkgEvent) : void
      {
         var bytes:ByteArray = e.pkg;
         var list:Vector.<WorshipTheMoonAwardsBoxInfo> = new Vector.<WorshipTheMoonAwardsBoxInfo>();
         bytes.readInt();
         while(bytes.bytesAvailable)
         {
            list.push(new WorshipTheMoonAwardsBoxInfo(bytes.readInt(),bytes.readInt()));
         }
         WorshipTheMoonModel.getInstance().updateAwardsBoxInfoList(list);
      }
      
      public function requireFreeCount() : void
      {
         GameInSocketOut.sendWorshipTheMoonFreeCount();
      }
      
      public function requireAwardsList() : void
      {
         GameInSocketOut.sendWorshipTheMoonAwardsList();
      }
      
      public function requireWorshipTheMoon(counts:int) : void
      {
         var isBindTickets:Boolean = false;
         if(counts == 1)
         {
            isBindTickets = WorshipTheMoonModel.getInstance().getIsOnceBtnUseBindMoney();
         }
         else
         {
            isBindTickets = WorshipTheMoonModel.getInstance().getIsTensBtnUseBindMoney();
         }
         GameInSocketOut.sendWorshipTheMoon(counts,isBindTickets);
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
