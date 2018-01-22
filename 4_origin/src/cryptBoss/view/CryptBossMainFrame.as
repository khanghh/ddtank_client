package cryptBoss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import cryptBoss.CryptBossManager;
   import cryptBoss.data.CryptBossItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import gameCommon.GameControl;
   import quest.TaskManager;
   
   public class CryptBossMainFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _itemVec:Vector.<CryptBossItem>;
      
      public function CryptBossMainFrame()
      {
         super();
         initView();
         initEvent();
         checkTask();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("cryptBoss.frame.titleTxt");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"cryptBoss.helpBtn",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),"cryptBoss.helpTxt",424,484) as SimpleBitmapButton;
         _bg = ComponentFactory.Instance.creat("asset.cryptBoss.bg");
         addToContent(_bg);
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc1_:* = null;
         if(_itemVec != null)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _itemVec;
            for each(var _loc2_ in _itemVec)
            {
               ObjectUtils.disposeObject(_loc2_);
               _loc2_ = null;
            }
            _itemVec = null;
         }
         _itemVec = new Vector.<CryptBossItem>();
         var _loc7_:int = 0;
         var _loc6_:* = CryptBossManager.instance.openWeekDaysDic;
         for each(var _loc3_ in CryptBossManager.instance.openWeekDaysDic)
         {
            _loc1_ = new CryptBossItem(_loc3_);
            _itemVec.push(_loc1_);
            addToContent(_loc1_);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
      }
      
      private function checkTask() : void
      {
         var _loc1_:QuestInfo = TaskManager.instance.getQuestByID(1277);
         if(_loc1_ && _loc1_.data != null && _loc1_.isCompleted == false)
         {
            SocketManager.Instance.out.sendQuestCheck(1277,1,0);
         }
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            CryptBossManager.instance.RoomType = 0;
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _itemVec = null;
         _helpBtn = null;
         super.dispose();
      }
   }
}
