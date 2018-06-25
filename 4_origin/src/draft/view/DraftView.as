package draft.view
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.DraftManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.RequestVairableCreater;
   import draft.DraftControl;
   import draft.data.DraftListAnalyzer;
   import draft.data.DraftModel;
   import flash.display.Bitmap;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import road7th.comm.PackageIn;
   
   public class DraftView extends Frame implements Disposeable
   {
       
      
      private var _ticketBg:Bitmap;
      
      private var _mondayBitmap:Bitmap;
      
      private var _freeTicket:FilterFrameText;
      
      private var _competitionBtn:BaseButton;
      
      private var _lastRankBtn:BaseButton;
      
      private var _foreBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _currentPage:int = 1;
      
      private var _playerVec:Vector.<DraftPlayer>;
      
      public function DraftView()
      {
         super();
         _playerVec = new Vector.<DraftPlayer>(5);
         initView();
         initEvent();
         sendPkg();
      }
      
      private function sendPkg(page:int = 1) : void
      {
         SocketManager.Instance.out.getPlayerSpecialProperty(1);
         LoadResourceManager.Instance.startLoad(getDraftPlayerData(page));
      }
      
      private function initView() : void
      {
         _ticketBg = ComponentFactory.Instance.creat("asset.draftView.freeTicket");
         addToContent(_ticketBg);
         _mondayBitmap = ComponentFactory.Instance.creat("asset.draftView.mondayReward");
         addToContent(_mondayBitmap);
         _freeTicket = ComponentFactory.Instance.creatComponentByStylename("draftView.freeTicket.num");
         addToContent(_freeTicket);
         _competitionBtn = ComponentFactory.Instance.creatComponentByStylename("draftView.competitionBtn");
         addToContent(_competitionBtn);
         _competitionBtn.visible = !PlayerManager.Instance.Self.Sex;
         _lastRankBtn = ComponentFactory.Instance.creatComponentByStylename("draftView.lastWeek.rewardRecord");
         addToContent(_lastRankBtn);
         _foreBtn = ComponentFactory.Instance.creatComponentByStylename("draftView.foreBtn");
         addToContent(_foreBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("draftView.nextBtn");
         addToContent(_nextBtn);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("draftView.pageInput");
         addToContent(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("draftView.pageTxt");
         addToContent(_pageTxt);
         creatPlayer();
      }
      
      private function creatPlayer() : void
      {
         var i:int = 0;
         var player:* = null;
         var count:int = _playerVec.length;
         for(i = 0; i < count; )
         {
            player = new DraftPlayer();
            player.x = 55 + i * 147;
            player.y = 176;
            addToContent(player);
            _playerVec[i] = player;
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("keyDown",__onResponse);
         _competitionBtn.addEventListener("click",__onCompetitionClick);
         _foreBtn.addEventListener("click",__onForeBtnClick);
         _nextBtn.addEventListener("click",__onNextBtnClick);
         _lastRankBtn.addEventListener("click",__onLastRankClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(309),__onDraftVote);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onUpdateProperty);
      }
      
      protected function __onResponse(event:KeyboardEvent) : void
      {
         if(event.keyCode == 27)
         {
            __onCloseClick(null);
         }
      }
      
      protected function __onDraftVote(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         if(flag)
         {
            sendPkg(_currentPage);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("draftView.vote.failed"));
         }
      }
      
      protected function __onLastRankClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var lastRankView:DraftLastWeekRank = new DraftLastWeekRank();
         LayerManager.Instance.addToLayer(lastRankView,3,true,1);
      }
      
      protected function __onForeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentPage > 1)
         {
            _currentPage = Number(_currentPage) - 1;
         }
         else
         {
            _currentPage = DraftModel.Total;
         }
         LoadResourceManager.Instance.startLoad(getDraftPlayerData(_currentPage));
      }
      
      protected function __onNextBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentPage < DraftModel.Total)
         {
            _currentPage = Number(_currentPage) + 1;
         }
         else
         {
            _currentPage = 1;
         }
         LoadResourceManager.Instance.startLoad(getDraftPlayerData(_currentPage));
      }
      
      private function __onUpdateProperty(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["ticketNum"])
         {
            DraftControl.instance.TicketNum = PlayerManager.Instance.Self.ticketNum;
            DraftModel.UploadNum = PlayerManager.Instance.Self.uploadNum;
            _freeTicket.text = DraftControl.instance.TicketNum.toString();
         }
      }
      
      private function getDraftPlayerData(page:int = 1) : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = page;
         args["size"] = 5;
         args["isOrder"] = true;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetBeautyVoteList.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.draft.loadDraftInfoError");
         loader.analyzer = new DraftListAnalyzer(getDraftPlayerInfo);
         return loader;
      }
      
      private function getDraftPlayerInfo(analyzer:DraftListAnalyzer) : void
      {
         var count:int = 0;
         var i:int = 0;
         _currentPage;
         if(_playerVec != null)
         {
            count = _playerVec.length;
            for(i = 0; i < count; )
            {
               if(i < analyzer.draftInfoVec.length && analyzer.draftInfoVec[i] != null)
               {
                  analyzer.draftInfoVec[i].rank = (_currentPage - 1) * count + i + 1;
                  _playerVec[i].drafInfo = analyzer.draftInfoVec[i];
               }
               else
               {
                  _playerVec[i].drafInfo = null;
               }
               i++;
            }
            _pageTxt.text = _currentPage.toString() + "/" + DraftModel.Total.toString();
         }
      }
      
      protected function __onCompetitionClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.isAttest)
         {
            DraftControl.instance.hide();
            DraftManager.instance.showDraft = true;
            BagAndInfoManager.Instance.showBagAndInfo();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("draftView.vote.attestText"));
         }
      }
      
      override protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         DraftControl.instance.hide();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("keyDown",__onResponse);
         _competitionBtn.removeEventListener("click",__onCompetitionClick);
         _foreBtn.removeEventListener("click",__onForeBtnClick);
         _nextBtn.removeEventListener("click",__onNextBtnClick);
         _lastRankBtn.removeEventListener("click",__onLastRankClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onUpdateProperty);
         SocketManager.Instance.removeEventListener(PkgEvent.format(309),__onDraftVote);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         super.dispose();
         for(i = 0; i < _playerVec.length; )
         {
            _playerVec[i].dispose();
            _playerVec[i] = null;
            i++;
         }
         _playerVec.length = 0;
         _playerVec = null;
         ObjectUtils.disposeObject(_ticketBg);
         _ticketBg = null;
         ObjectUtils.disposeObject(_freeTicket);
         _freeTicket = null;
         ObjectUtils.disposeObject(_mondayBitmap);
         _mondayBitmap = null;
         ObjectUtils.disposeObject(_competitionBtn);
         _competitionBtn = null;
         ObjectUtils.disposeObject(_lastRankBtn);
         _lastRankBtn = null;
         ObjectUtils.disposeObject(_foreBtn);
         _foreBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
