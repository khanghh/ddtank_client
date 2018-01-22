package draft.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import draft.DraftControl;
   import draft.data.DraftModel;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DraftPlayer extends Sprite implements Disposeable
   {
       
      
      private var _draftInfo:DraftModel;
      
      private var _playerBg:Bitmap;
      
      private var _charactor:RoomCharacter;
      
      private var _platform:ScaleFrameImage;
      
      private var _lightBg:ScaleFrameImage;
      
      private var _light:MovieClip;
      
      private var _ticketNum:FilterFrameText;
      
      private var _lblName:FilterFrameText;
      
      private var _rankNum:FilterFrameText;
      
      private var _voteBtn:SimpleBitmapButton;
      
      public function DraftPlayer()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _platform = ComponentFactory.Instance.creatComponentByStylename("draftView.player.platform");
         addChild(_platform);
         _lightBg = ComponentFactory.Instance.creatComponentByStylename("draftView.player.lightBg");
         addChild(_lightBg);
         _light = ComponentFactory.Instance.creat("asset.draftView.player.light");
         PositionUtils.setPos(_light,"draftView.player.lightPos");
         addChild(_light);
         _ticketNum = ComponentFactory.Instance.creatComponentByStylename("draftView.player.ticketNum");
         addChild(_ticketNum);
         _ticketNum.setFrame(1);
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("draftView.player.rankNum");
         addChild(_rankNum);
         _voteBtn = ComponentFactory.Instance.creatComponentByStylename("draftView.player.voteBtn");
         _voteBtn.enable = false;
         addChild(_voteBtn);
         _lblName = ComponentFactory.Instance.creat("asset.hall.playerInfo.lblName");
         PositionUtils.setPos(_lblName,"draftView.player.namePos");
         addChild(_lblName);
         _playerBg = ComponentFactory.Instance.creat("asset.draftView.normalBg");
         addChild(_playerBg);
      }
      
      private function initEvent() : void
      {
         _voteBtn.addEventListener("click",__onVoteBtnClick);
      }
      
      protected function __onVoteBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Grade < 40 || PlayerManager.Instance.Self.FightPower < 100000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("draftView.vote.limitText",40));
         }
         else if(DraftControl.instance.TicketNum > 0)
         {
            SocketManager.Instance.out.sendDraftVoteTicket(1,_draftInfo.id);
         }
         else
         {
            _loc2_ = new DraftVoteView(_draftInfo.playerInfo.ID,_draftInfo.id);
            LayerManager.Instance.addToLayer(_loc2_,3,true,1);
         }
      }
      
      public function set drafInfo(param1:DraftModel) : void
      {
         _draftInfo = param1;
         ObjectUtils.disposeObject(_charactor);
         _charactor = null;
         if(_draftInfo != null)
         {
            _voteBtn.enable = true;
            _draftInfo.playerInfo.Nimbus = 0;
            _charactor = CharactoryFactory.createCharacter(_draftInfo.playerInfo,"room") as RoomCharacter;
            _charactor.show(true);
            _charactor.showGun = false;
            _charactor.buttonMode = true;
            var _loc2_:* = true;
            _charactor.mouseEnabled = _loc2_;
            _charactor.mouseChildren = _loc2_;
            _charactor.addEventListener("complete",__onCharacterComplete);
            _charactor.addEventListener("click",__charactorClick_Handler);
            _charactor.addEventListener("mouseOver",__charactorFilter_Handler);
            _charactor.addEventListener("mouseOut",__charactorFilter_Handler);
            addChild(_charactor);
            if(_draftInfo.rank <= 3)
            {
               _rankNum.text = "";
               _platform.setFrame(_draftInfo.rank);
               _loc2_ = true;
               _lightBg.visible = _loc2_;
               _light.visible = _loc2_;
               _lightBg.setFrame(_draftInfo.rank);
            }
            else
            {
               _platform.setFrame(4);
               _loc2_ = false;
               _lightBg.visible = _loc2_;
               _light.visible = _loc2_;
               _rankNum.text = LanguageMgr.GetTranslation("draftView.player.rank",_draftInfo.rank);
            }
            _playerBg.visible = false;
            _ticketNum.text = LanguageMgr.GetTranslation("draftView.player.ticket",_draftInfo.ticketNum);
            _lblName.text = _draftInfo.playerInfo.NickName;
         }
         else
         {
            _platform.setFrame(4);
            _loc2_ = false;
            _voteBtn.enable = _loc2_;
            _loc2_ = _loc2_;
            _lightBg.visible = _loc2_;
            _light.visible = _loc2_;
            _playerBg.visible = true;
            _loc2_ = "";
            _ticketNum.text = _loc2_;
            _rankNum.text = _loc2_;
            _lblName.text = LanguageMgr.GetTranslation("draftView.player.normalName");
         }
      }
      
      private function __charactorClick_Handler(param1:MouseEvent) : void
      {
         if(_draftInfo != null)
         {
            SoundManager.instance.playButtonSound();
            PlayerInfoViewControl.viewByID(_draftInfo.playerInfo.ID);
            PlayerInfoViewControl.isOpenFromBag = false;
         }
      }
      
      private function __charactorFilter_Handler(param1:MouseEvent) : void
      {
         if(_charactor != null && _charactor is RoomCharacter)
         {
            if(param1.type == "mouseOver")
            {
               _charactor.setCharacterFilter(true);
            }
            else if(param1.type == "mouseOut")
            {
               _charactor.setCharacterFilter(false);
            }
         }
      }
      
      public function hideNotNeed(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         _platform.visible = _loc2_;
         _loc2_ = _loc2_;
         _voteBtn.visible = _loc2_;
         _rankNum.visible = _loc2_;
         if(_draftInfo != null)
         {
            _ticketNum.setFrame(_draftInfo.rank + 1);
            PositionUtils.setPos(_ticketNum,"lastRankView.ticket.Pos" + _draftInfo.rank);
         }
      }
      
      protected function __onCharacterComplete(param1:Event) : void
      {
         var _loc2_:RoomCharacter = param1.target as RoomCharacter;
         _loc2_.removeEventListener("complete",__onCharacterComplete);
         _charactor.setBodySize();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _draftInfo = null;
         if(_charactor != null)
         {
            _charactor.removeEventListener("mouseOver",__charactorFilter_Handler);
            _charactor.removeEventListener("mouseOut",__charactorFilter_Handler);
            _charactor.removeEventListener("click",__charactorClick_Handler);
         }
         ObjectUtils.disposeObject(_charactor);
         _charactor = null;
         ObjectUtils.disposeObject(_lightBg);
         _lightBg = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_platform);
         _platform = null;
         ObjectUtils.disposeObject(_ticketNum);
         _ticketNum = null;
         ObjectUtils.disposeObject(_lblName);
         _lblName = null;
         ObjectUtils.disposeObject(_rankNum);
         _rankNum = null;
         ObjectUtils.disposeObject(_voteBtn);
         _voteBtn = null;
         ObjectUtils.disposeObject(_playerBg);
         _playerBg = null;
      }
      
      private function removeEvent() : void
      {
         if(_voteBtn != null)
         {
            _voteBtn.removeEventListener("click",__onVoteBtnClick);
         }
      }
   }
}
