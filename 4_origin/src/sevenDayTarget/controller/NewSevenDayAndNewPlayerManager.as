package sevenDayTarget.controller
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import ddt.bagStore.BagStore;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import quest.TaskManager;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   import sevenDayTarget.view.NewSevenDayAndNewPlayerMainView;
   
   public class NewSevenDayAndNewPlayerManager extends EventDispatcher
   {
      
      private static var _instance:NewSevenDayAndNewPlayerManager;
       
      
      private var _isShowIcon:Boolean;
      
      private var _sevenDayOpen:Boolean;
      
      private var _newPlayerOpen:Boolean;
      
      public var sevenDayMainViewPreOk:Boolean;
      
      public var newPlayerMainViewPreOk:Boolean;
      
      private var _newSevenDayAndNewPlayerMainView:NewSevenDayAndNewPlayerMainView;
      
      public var enterShop:Boolean;
      
      public function NewSevenDayAndNewPlayerManager()
      {
         super();
      }
      
      public static function get Instance() : NewSevenDayAndNewPlayerManager
      {
         if(_instance == null)
         {
            _instance = new NewSevenDayAndNewPlayerManager();
         }
         return _instance;
      }
      
      public function get isShowIcon() : Boolean
      {
         var isopen:Boolean = false;
         if(!sevenDayOpen && !newPlayerOpen)
         {
            _isShowIcon = false;
         }
         else
         {
            _isShowIcon = true;
         }
         return _isShowIcon;
      }
      
      public function get sevenDayOpen() : Boolean
      {
         var isopen:Boolean = SevenDayTargetManager.Instance.isShowIcon;
         return isopen;
      }
      
      public function set sevenDayOpen(isopen:Boolean) : void
      {
         _sevenDayOpen = isopen;
      }
      
      public function get newPlayerOpen() : Boolean
      {
         var isopen:Boolean = NewPlayerRewardManager.Instance.isShowIcon;
         return isopen;
      }
      
      public function set newPlayerOpen(isopen:Boolean) : void
      {
         _newPlayerOpen = isopen;
      }
      
      public function setup() : void
      {
         SevenDayTargetManager.Instance.setup();
         NewPlayerRewardManager.Instance.setup();
         addEventListener("openUpdate",_aciveOtherManager);
         addEventListener("openSevenDayMainView",_openMainView);
         addEventListener("clickLink",__clickLink);
      }
      
      private function _aciveOtherManager(e:Event) : void
      {
         if(isShowIcon)
         {
            addEnterIcon();
         }
         else
         {
            disposeEnterIcon();
         }
      }
      
      public function addEnterIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 5)
         {
            HallIconManager.instance.updateSwitchHandler("sevenDayTarget",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("sevenDayTarget",true,5);
         }
      }
      
      private function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("sevenDayTarget",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("sevenDayTarget",false);
      }
      
      public function onClickSevenDayTargetIcon(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(sevenDayOpen)
         {
            SevenDayTargetManager.Instance.onClickSevenDayTargetIcon();
         }
         if(newPlayerOpen)
         {
            SocketManager.Instance.out.newPlayerReward_enter();
         }
      }
      
      private function _openMainView(e:Event) : void
      {
         if(!_newSevenDayAndNewPlayerMainView)
         {
            if(sevenDayOpen && newPlayerOpen)
            {
               if(sevenDayMainViewPreOk && newPlayerMainViewPreOk)
               {
                  _newSevenDayAndNewPlayerMainView = ComponentFactory.Instance.creatComponentByStylename("newSevenDayTarget.newSevenDayTargetFrame");
                  _newSevenDayAndNewPlayerMainView.show();
               }
            }
            else if(sevenDayOpen && !newPlayerOpen)
            {
               if(sevenDayMainViewPreOk)
               {
                  _newSevenDayAndNewPlayerMainView = ComponentFactory.Instance.creatComponentByStylename("newSevenDayTarget.newSevenDayTargetFrame");
                  _newSevenDayAndNewPlayerMainView.show();
               }
            }
            else if(!sevenDayOpen && newPlayerOpen)
            {
               if(newPlayerMainViewPreOk)
               {
                  _newSevenDayAndNewPlayerMainView = ComponentFactory.Instance.creatComponentByStylename("newSevenDayTarget.newSevenDayTargetFrame");
                  _newSevenDayAndNewPlayerMainView.show();
               }
            }
         }
      }
      
      public function hideMainView() : void
      {
         _newSevenDayAndNewPlayerMainView.dispose();
         _newSevenDayAndNewPlayerMainView = null;
      }
      
      private function __clickLink(e:Event) : void
      {
         var _todayQuestInfo:NewTargetQuestionInfo = _newSevenDayAndNewPlayerMainView.todayInfo();
         var linkId:int = _todayQuestInfo.linkId;
         switch(int(linkId) - 1)
         {
            case 0:
               hideMainView();
               TaskManager.instance.switchVisible();
               break;
            case 1:
               if(PlayerManager.Instance.Self.Grade < 6)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",6));
               }
               else
               {
                  hideMainView();
                  StateManager.setState("shop");
                  ComponentSetting.SEND_USELOG_ID(1);
               }
               break;
            case 2:
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
               }
               else
               {
                  hideMainView();
                  BagStore.instance.openStore("bag_store");
                  ComponentSetting.SEND_USELOG_ID(2);
               }
               break;
            case 3:
               if(PlayerManager.Instance.Self.Grade < 17)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
               }
               else
               {
                  hideMainView();
                  StateManager.setState("consortia");
                  ComponentSetting.SEND_USELOG_ID(5);
               }
               break;
            case 4:
               if(PlayerManager.Instance.Self.Grade < 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",10));
                  break;
               }
               hideMainView();
               StateManager.setState("dungeon");
               ComponentSetting.SEND_USELOG_ID(4);
               break;
         }
      }
   }
}
