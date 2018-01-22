package consortiaDomain.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class KillRankView extends Sprite implements Disposeable
   {
       
      
      private var _show_totalInfoBtnIMG:ScaleFrameImage;
      
      private var _open_show:Boolean;
      
      private var _show_totalInfoBtn:SimpleBitmapButton;
      
      private var _mgr:ConsortiaDomainManager;
      
      private var _listPanel:ListPanel;
      
      private var _myKillTF:FilterFrameText;
      
      public function KillRankView()
      {
         super();
         KillRankCell;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _mgr = ConsortiaDomainManager.instance;
         UICreatShortcut.creatAndAdd("consortiadomain.killRankView.bg",this);
         UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.rankType",LanguageMgr.GetTranslation("consortiadomain.killRankView.title.rank"),this);
         UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.playerNameType",LanguageMgr.GetTranslation("consortiadomain.killRankView.title.playerName"),this);
         UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.killNumType",LanguageMgr.GetTranslation("consortiadomain.killRankView.title.killNum"),this);
         _myKillTF = UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.myKillTF","",this);
         _show_totalInfoBtn = ComponentFactory.Instance.creatComponentByStylename("consortiadomain.showTotalBtn");
         addChild(_show_totalInfoBtn);
         _open_show = false;
         _show_totalInfoBtnIMG = ComponentFactory.Instance.creatComponentByStylename("consortiadomain.showTotalBtnIMG");
         _show_totalInfoBtnIMG.setFrame(2);
         _show_totalInfoBtn.addChild(_show_totalInfoBtnIMG);
         UICreatShortcut.creatAndAdd("consortiadomain.killRankView.title",this);
         UICreatShortcut.creatAndAdd("consortiadomain.killRankView.split",this).width = 200;
         _listPanel = UICreatShortcut.creatAndAdd("consortiadomain.killRankView.listPanel",this);
      }
      
      private function addEvent() : void
      {
         _show_totalInfoBtn.addEventListener("click",__showTotalInfo);
         _mgr.addEventListener("event_kill_rank_update",onGetRankInfoBack);
      }
      
      private function removeEvent() : void
      {
         if(_show_totalInfoBtn)
         {
            _show_totalInfoBtn.removeEventListener("click",__showTotalInfo);
         }
         _mgr.removeEventListener("event_kill_rank_update",onGetRankInfoBack);
      }
      
      private function onGetRankInfoBack(param1:Event) : void
      {
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_mgr.model.killRankArr);
         _listPanel.list.updateListView();
         if(_mgr.model.myRank <= 10)
         {
            _myKillTF.text = LanguageMgr.GetTranslation("consortiadomain.killRankView.myKill",_mgr.model.myKillNum);
         }
         else
         {
            _myKillTF.text = LanguageMgr.GetTranslation("consortiadomain.killRankView.myKill",_mgr.model.myKillNum) + "  " + LanguageMgr.GetTranslation("consortiadomain.killRankView.notInRank");
         }
      }
      
      private function formatName(param1:String) : String
      {
         if(param1.length > 4)
         {
            return param1.slice(0,4) + "...";
         }
         return param1;
      }
      
      private function __showTotalInfo(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _show_totalInfoBtnIMG.setFrame(!!_open_show?2:1);
         addEventListener("enterFrame",__totalViewShowOrHide);
      }
      
      private function __totalViewShowOrHide(param1:Event) : void
      {
         if(_open_show)
         {
            this.x = this.x + 20;
            if(this.x >= StageReferance.stageWidth - 3)
            {
               removeEventListener("enterFrame",__totalViewShowOrHide);
               this.x = StageReferance.stageWidth - 3;
               _open_show = !_open_show;
            }
         }
         else
         {
            this.x = this.x - 20;
            if(this.x <= StageReferance.stageWidth - this.width + 29)
            {
               removeEventListener("enterFrame",__totalViewShowOrHide);
               this.x = StageReferance.stageWidth - this.width + 29;
               _open_show = !_open_show;
            }
         }
      }
      
      public function setOpen(param1:Boolean) : void
      {
         if(param1)
         {
            this.x = StageReferance.stageWidth - this.width + 29;
            _open_show = true;
            _show_totalInfoBtnIMG.setFrame(1);
         }
         else
         {
            this.x = StageReferance.stageWidth - 3;
            _open_show = false;
            _show_totalInfoBtnIMG.setFrame(2);
         }
         this.y = (StageReferance.stageHeight - this.height) * 0.5;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_show_totalInfoBtnIMG);
         _show_totalInfoBtnIMG = null;
         ObjectUtils.disposeObject(_show_totalInfoBtn);
         _show_totalInfoBtn = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         _mgr = null;
      }
   }
}
