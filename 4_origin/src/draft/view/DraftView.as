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
      
      private function sendPkg(param1:int = 1) : void
      {
         SocketManager.Instance.out.getPlayerSpecialProperty(1);
         LoadResourceManager.Instance.startLoad(getDraftPlayerData(param1));
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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = _playerVec.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new DraftPlayer();
            _loc1_.x = 55 + _loc3_ * 147;
            _loc1_.y = 176;
            addToContent(_loc1_);
            _playerVec[_loc3_] = _loc1_;
            _loc3_++;
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
      
      protected function __onResponse(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 27)
         {
            __onCloseClick(null);
         }
      }
      
      protected function __onDraftVote(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(_loc2_)
         {
            sendPkg(_currentPage);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("draftView.vote.failed"));
         }
      }
      
      protected function __onLastRankClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:DraftLastWeekRank = new DraftLastWeekRank();
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      protected function __onForeBtnClick(param1:MouseEvent) : void
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
      
      protected function __onNextBtnClick(param1:MouseEvent) : void
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
      
      private function __onUpdateProperty(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["ticketNum"])
         {
            DraftControl.instance.TicketNum = PlayerManager.Instance.Self.ticketNum;
            DraftModel.UploadNum = PlayerManager.Instance.Self.uploadNum;
            _freeTicket.text = DraftControl.instance.TicketNum.toString();
         }
      }
      
      private function getDraftPlayerData(param1:int = 1) : BaseLoader
      {
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["page"] = param1;
         _loc3_["size"] = 5;
         _loc3_["isOrder"] = true;
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetBeautyVoteList.ashx"),7,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("tank.draft.loadDraftInfoError");
         _loc2_.analyzer = new DraftListAnalyzer(getDraftPlayerInfo);
         return _loc2_;
      }
      
      private function getDraftPlayerInfo(param1:DraftListAnalyzer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _currentPage;
         if(_playerVec != null)
         {
            _loc2_ = _playerVec.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc3_ < param1.draftInfoVec.length && param1.draftInfoVec[_loc3_] != null)
               {
                  param1.draftInfoVec[_loc3_].rank = (_currentPage - 1) * _loc2_ + _loc3_ + 1;
                  _playerVec[_loc3_].drafInfo = param1.draftInfoVec[_loc3_];
               }
               else
               {
                  _playerVec[_loc3_].drafInfo = null;
               }
               _loc3_++;
            }
            _pageTxt.text = _currentPage.toString() + "/" + DraftModel.Total.toString();
         }
      }
      
      protected function __onCompetitionClick(param1:MouseEvent) : void
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
      
      override protected function __onCloseClick(param1:MouseEvent) : void
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
         var _loc1_:int = 0;
         removeEvent();
         super.dispose();
         _loc1_ = 0;
         while(_loc1_ < _playerVec.length)
         {
            _playerVec[_loc1_].dispose();
            _playerVec[_loc1_] = null;
            _loc1_++;
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
