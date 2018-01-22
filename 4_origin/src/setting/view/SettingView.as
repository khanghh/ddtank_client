package setting.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.Silder;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.OpitionEnum;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SettingView extends BaseAlerFrame
   {
       
      
      private var _imgTitle1:Image;
      
      private var _imgTitle2:Image;
      
      private var _imgTitle3:Image;
      
      private var _bmpYpsz:Bitmap;
      
      private var _bmpXssz:Bitmap;
      
      private var _bmpGnsz:Bitmap;
      
      private var _cbBjyy:SelectedCheckButton;
      
      private var _cbYxyx:SelectedCheckButton;
      
      private var _cbWqtx:SelectedCheckButton;
      
      private var _cbLbgn:SelectedCheckButton;
      
      private var _cbqytx:SelectedCheckButton;
      
      private var _cbshtx:SelectedCheckButton;
      
      private var _cbJsyq:SelectedCheckButton;
      
      private var _cbSxts:SelectedCheckButton;
      
      private var _communityFunction:SelectedCheckButton;
      
      private var _guideFunction:SelectedCheckButton;
      
      private var _academy:SelectedCheckButton;
      
      private var _refusedBeFriendBtn:SelectedCheckButton;
      
      private var _refusedPrivateChatBtn:SelectedCheckButton;
      
      private var _sliderBg1:Image;
      
      private var _sliderBg2:Image;
      
      private var _sliderBjyy:Silder;
      
      private var _sliderYxyx:Silder;
      
      private var _keySettingBtn:SimpleBitmapButton;
      
      private var _keySetFrame:KeySetFrame;
      
      private var _oldAllowMusic:Boolean;
      
      private var _oldAllowSound:Boolean;
      
      private var _oldShowParticle:Boolean;
      
      private var _oldShowBugle:Boolean;
      
      private var _oldShowInvate:Boolean;
      
      private var _oldShowOL:Boolean;
      
      private var _oldisRecommend:Boolean;
      
      private var _oldMusicVolumn:Number;
      
      private var _oldSoundVolumn:Number;
      
      private var _oldIsCommunity:Boolean;
      
      private var _smallText1:FilterFrameText;
      
      private var _smallText2:FilterFrameText;
      
      private var _bigText1:FilterFrameText;
      
      private var _bigText2:FilterFrameText;
      
      public function SettingView()
      {
         super();
         Silder;
         initView();
      }
      
      private function __refusedPrivateChat(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerManager.Instance.Self.OptionOnOff = OpitionEnum.setOpitionState(!_refusedPrivateChatBtn.selected,4);
         SocketManager.Instance.out.sendOpition(PlayerManager.Instance.Self.OptionOnOff);
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.game.ToolStripView.set"));
         _loc1_.moveEnable = false;
         info = _loc1_;
         _imgTitle1 = ComponentFactory.Instance.creat("ddtsetting.VolumeSetting");
         addToContent(_imgTitle1);
         _imgTitle2 = ComponentFactory.Instance.creat("ddtsetting.DisplaySetting");
         addToContent(_imgTitle2);
         _imgTitle3 = ComponentFactory.Instance.creat("ddtsetting.FuncSetting");
         addToContent(_imgTitle3);
         _smallText1 = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.smallText1");
         _smallText2 = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.smallText2");
         _bigText1 = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.bigText1");
         _bigText2 = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.bigText2");
         _cbBjyy = ComponentFactory.Instance.creat("ddtsetting.BackgroundMusicCbn");
         _cbBjyy.text = LanguageMgr.GetTranslation("setting.backgroundMusic");
         _cbBjyy.addEventListener("click",__audioSelect);
         addToContent(_cbBjyy);
         _cbYxyx = ComponentFactory.Instance.creat("ddtsetting.GameMusicCbn");
         _cbYxyx.text = LanguageMgr.GetTranslation("setting.gameMusic");
         _cbYxyx.addEventListener("click",__audioSelect);
         addToContent(_cbYxyx);
         _cbWqtx = ComponentFactory.Instance.creat("ddtsetting.WeaponEffectCbn");
         _cbWqtx.text = LanguageMgr.GetTranslation("setting.weaponEffect");
         _cbWqtx.addEventListener("click",__checkBoxClick);
         addToContent(_cbWqtx);
         _cbLbgn = ComponentFactory.Instance.creat("ddtsetting.SpeakerFunctionCbn");
         _cbLbgn.text = LanguageMgr.GetTranslation("setting.speakerFunction");
         _cbLbgn.addEventListener("click",__checkBoxClick);
         addToContent(_cbLbgn);
         _cbqytx = ComponentFactory.Instance.creat("ddtsetting.FriendshipEffectCbn");
         _cbqytx.text = LanguageMgr.GetTranslation("setting.friendshipEffectMsg");
         _cbqytx.addEventListener("click",__checkBoxClick);
         _cbqytx.selected = !SharedManager.Instance.friendshipEffect;
         addToContent(_cbqytx);
         _cbshtx = ComponentFactory.Instance.creat("ddtsetting.GuardEffectCbn");
         _cbshtx.text = LanguageMgr.GetTranslation("setting.guardEffectMsg");
         _cbshtx.addEventListener("click",__checkBoxClick);
         _cbshtx.selected = !SharedManager.Instance.guardEffect;
         addToContent(_cbshtx);
         _cbJsyq = ComponentFactory.Instance.creat("ddtsetting.AcceptInvitationCbn");
         _cbJsyq.text = LanguageMgr.GetTranslation("setting.acceptInvitation");
         _cbJsyq.addEventListener("click",__checkBoxClick);
         addToContent(_cbJsyq);
         _cbSxts = ComponentFactory.Instance.creat("ddtsetting.OnlinePromptCbn");
         _cbSxts.text = LanguageMgr.GetTranslation("setting.onlinePrompt");
         _cbSxts.addEventListener("click",__checkBoxClick);
         addToContent(_cbSxts);
         _communityFunction = ComponentFactory.Instance.creat("ddtsetting.CommunityFunctionCbn");
         _communityFunction.text = LanguageMgr.GetTranslation("setting.communityFunction");
         _communityFunction.addEventListener("click",__checkBoxClick);
         addToContent(_communityFunction);
         if(!PathManager.isVisibleExistBtn() || !PathManager.CommunityExist())
         {
            _communityFunction.visible = false;
         }
         _guideFunction = ComponentFactory.Instance.creat("ddtsetting.GuideCbn");
         _guideFunction.text = LanguageMgr.GetTranslation("setting.GuideCbnText");
         _guideFunction.addEventListener("click",__setIsGuideHandler);
         addToContent(_guideFunction);
         if(PlayerManager.Instance.Self.Grade > 15)
         {
            _guideFunction.selected = false;
         }
         if(!PathManager.isVisibleExistBtn() || !PathManager.CommunityExist())
         {
            PositionUtils.setPos(_guideFunction,"ddtsetting.GuideCbnPos");
         }
         _academy = ComponentFactory.Instance.creatComponentByStylename("setting.academy");
         _academy.addEventListener("click",__checkBoxClick);
         _refusedBeFriendBtn = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.AcceptAddingFriendsCbn");
         _refusedBeFriendBtn.text = LanguageMgr.GetTranslation("setting.acceptAddingFriends");
         _refusedBeFriendBtn.addEventListener("click",__refusedBeFriendHandler);
         addToContent(_refusedBeFriendBtn);
         _refusedPrivateChatBtn = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.RejectStrangerMessageCbn");
         _refusedPrivateChatBtn.text = LanguageMgr.GetTranslation("setting.rejectStrangerMessage");
         _refusedPrivateChatBtn.addEventListener("click",__refusedPrivateChat);
         addToContent(_refusedPrivateChatBtn);
         _sliderBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.SliderBarBg1");
         addToContent(_sliderBg1);
         _sliderBg2 = ComponentFactory.Instance.creatComponentByStylename("ddtsetting.SliderBarBg2");
         addToContent(_sliderBg2);
         _sliderBjyy = ComponentFactory.Instance.creat("ddtsetting.BackgroundMusicSlider");
         _sliderBjyy.addEventListener("stateChange",__musicSliderChanged);
         addToContent(_sliderBjyy);
         _sliderYxyx = ComponentFactory.Instance.creat("ddtsetting.GameMusicSlider");
         _sliderYxyx.addEventListener("stateChange",__soundSliderChanged);
         addToContent(_sliderYxyx);
         _keySettingBtn = ComponentFactory.Instance.creatComponentByStylename("setting.keySettingBtn");
         _keySettingBtn.addEventListener("click",__keySettingBtnClick);
         addToContent(_keySettingBtn);
         _keySettingBtn.enable = isSkillCanUse();
         addToContent(_smallText1);
         addToContent(_smallText2);
         addToContent(_bigText1);
         addToContent(_bigText2);
         initData();
      }
      
      private function initData() : void
      {
         allowMusic = SharedManager.Instance.allowMusic;
         _oldAllowMusic = SharedManager.Instance.allowMusic;
         allowSound = SharedManager.Instance.allowSound;
         _oldAllowSound = SharedManager.Instance.allowSound;
         particle = SharedManager.Instance.showParticle;
         _oldShowParticle = SharedManager.Instance.showParticle;
         showbugle = SharedManager.Instance.showTopMessageBar;
         _oldShowBugle = SharedManager.Instance.showTopMessageBar;
         invate = SharedManager.Instance.showInvateWindow;
         _oldShowInvate = SharedManager.Instance.showInvateWindow;
         showOL = SharedManager.Instance.showOL;
         _oldShowOL = SharedManager.Instance.showOL;
         musicVolumn = SharedManager.Instance.musicVolumn;
         _oldMusicVolumn = SharedManager.Instance.musicVolumn;
         soundVolumn = SharedManager.Instance.soundVolumn;
         _oldSoundVolumn = SharedManager.Instance.soundVolumn;
         isRecommend = SharedManager.Instance.isRecommend;
         _oldisRecommend = SharedManager.Instance.isRecommend;
         _refusedBeFriendBtn.selected = !PlayerManager.Instance.Self.getOptionState(1);
         if(PlayerManager.Instance.Self.Grade < 16)
         {
            _guideFunction.selected = !PlayerManager.Instance.Self.getOptionState(32);
         }
         _refusedPrivateChatBtn.selected = !PlayerManager.Instance.Self.getOptionState(4);
         sliderEnable(_sliderBjyy,_sliderBg1,allowMusic);
         sliderEnable(_sliderYxyx,_sliderBg2,allowSound);
         isCommunity = SharedManager.Instance.isCommunity;
         _oldIsCommunity = SharedManager.Instance.isCommunity;
      }
      
      public function setShowSettingMovie() : void
      {
      }
      
      private function get allowMusic() : Boolean
      {
         return _cbBjyy.selected;
      }
      
      private function set allowMusic(param1:Boolean) : void
      {
         _cbBjyy.selected = param1;
      }
      
      private function get allowSound() : Boolean
      {
         return _cbYxyx.selected;
      }
      
      private function set allowSound(param1:Boolean) : void
      {
         _cbYxyx.selected = param1;
      }
      
      private function get particle() : Boolean
      {
         return _cbWqtx.selected;
      }
      
      private function set particle(param1:Boolean) : void
      {
         _cbWqtx.selected = param1;
      }
      
      private function get showbugle() : Boolean
      {
         return _cbLbgn.selected;
      }
      
      private function set showbugle(param1:Boolean) : void
      {
         _cbLbgn.selected = param1;
      }
      
      private function get invate() : Boolean
      {
         return _cbJsyq.selected;
      }
      
      private function set invate(param1:Boolean) : void
      {
         _cbJsyq.selected = param1;
      }
      
      private function get showOL() : Boolean
      {
         return _cbSxts.selected;
      }
      
      private function set showOL(param1:Boolean) : void
      {
         _cbSxts.selected = param1;
      }
      
      private function get musicVolumn() : int
      {
         return _sliderBjyy.value;
      }
      
      private function set musicVolumn(param1:int) : void
      {
         _sliderBjyy.value = param1;
      }
      
      private function get soundVolumn() : int
      {
         return _sliderYxyx.value;
      }
      
      private function set soundVolumn(param1:int) : void
      {
         _sliderYxyx.value = param1;
      }
      
      private function get isRecommend() : Boolean
      {
         return _academy.selected;
      }
      
      private function set isRecommend(param1:Boolean) : void
      {
         _academy.selected = param1;
      }
      
      private function audioChanged() : void
      {
         SharedManager.Instance.changed();
      }
      
      private function get isCommunity() : Boolean
      {
         return _communityFunction.selected;
      }
      
      private function set isCommunity(param1:Boolean) : void
      {
         _communityFunction.selected = param1;
      }
      
      private function get friendshipEffect() : Boolean
      {
         return !_cbqytx.selected;
      }
      
      private function get guardEffect() : Boolean
      {
         return !_cbshtx.selected;
      }
      
      private function revert() : void
      {
         SharedManager.Instance.allowMusic = _oldAllowMusic;
         SharedManager.Instance.allowSound = _oldAllowSound;
         SharedManager.Instance.showParticle = _oldShowParticle;
         SharedManager.Instance.showTopMessageBar = _oldShowBugle;
         SharedManager.Instance.showInvateWindow = _oldShowInvate;
         SharedManager.Instance.showOL = _oldShowOL;
         SharedManager.Instance.musicVolumn = _oldMusicVolumn;
         SharedManager.Instance.soundVolumn = _oldSoundVolumn;
         SharedManager.Instance.isCommunity = _oldIsCommunity;
         SharedManager.Instance.isRecommend = _oldisRecommend;
         SharedManager.Instance.save();
      }
      
      public function doConfirm() : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.allowMusic = allowMusic;
         SharedManager.Instance.allowSound = allowSound;
         SharedManager.Instance.showParticle = particle;
         SharedManager.Instance.showTopMessageBar = showbugle;
         SharedManager.Instance.showInvateWindow = invate;
         SharedManager.Instance.showOL = showOL;
         SharedManager.Instance.musicVolumn = musicVolumn;
         SharedManager.Instance.soundVolumn = soundVolumn;
         SharedManager.Instance.isCommunity = isCommunity;
         SharedManager.Instance.isRecommend = isRecommend;
         SharedManager.Instance.friendshipEffect = friendshipEffect;
         SharedManager.Instance.guardEffect = guardEffect;
         SharedManager.Instance.save();
      }
      
      public function doCancel() : void
      {
         SoundManager.instance.play("008");
         revert();
      }
      
      private function sliderEnable(param1:Silder, param2:Image, param3:Boolean) : void
      {
         var _loc4_:* = null;
         param1.mouseChildren = param3;
         param1.mouseEnabled = param3;
         if(param3)
         {
            param1.filters = null;
            param2.filters = null;
         }
         else
         {
            _loc4_ = [ComponentFactory.Instance.model.getSet("grayFilter")];
            param2.filters = _loc4_;
            param1.filters = _loc4_;
         }
      }
      
      private function __checkBoxClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __audioSelect(param1:MouseEvent) : void
      {
         SharedManager.Instance.allowMusic = allowMusic;
         SharedManager.Instance.allowSound = allowSound;
         audioChanged();
         if(param1.currentTarget == _cbBjyy)
         {
            SoundManager.instance.play("008");
            sliderEnable(_sliderBjyy,_sliderBg1,allowMusic);
         }
         else if(param1.currentTarget == _cbYxyx)
         {
            sliderEnable(_sliderYxyx,_sliderBg2,allowSound);
         }
      }
      
      private function __musicSliderChanged(param1:Event) : void
      {
         SharedManager.Instance.musicVolumn = musicVolumn;
         audioChanged();
      }
      
      private function __soundSliderChanged(param1:Event) : void
      {
         SharedManager.Instance.soundVolumn = soundVolumn;
         audioChanged();
      }
      
      private function __refusedBeFriendHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerManager.Instance.Self.OptionOnOff = OpitionEnum.setOpitionState(!_refusedBeFriendBtn.selected,1);
         SocketManager.Instance.out.sendOpition(PlayerManager.Instance.Self.OptionOnOff);
      }
      
      private function __setIsGuideHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade > 15)
         {
            _guideFunction.selected = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.setting.guideText"));
            return;
         }
         PlayerManager.Instance.Self.OptionOnOff = OpitionEnum.setOpitionState(!_guideFunction.selected,32);
         SocketManager.Instance.out.sendOpition(PlayerManager.Instance.Self.OptionOnOff);
      }
      
      protected function isSkillCanUse() : Boolean
      {
         var _loc1_:Boolean = false;
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(5) && PlayerManager.Instance.Self.IsWeakGuildFinish(2) && PlayerManager.Instance.Self.IsWeakGuildFinish(12) && PlayerManager.Instance.Self.IsWeakGuildFinish(51) && PlayerManager.Instance.Self.IsWeakGuildFinish(55))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function __keySettingBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         if(_keySetFrame == null)
         {
            _keySetFrame = ComponentFactory.Instance.creatComponentByStylename("setting.keySetFrame");
            _keySetFrame.addEventListener("response",__onKeySetResponse);
         }
         _keySetFrame.show();
      }
      
      private function __onKeySetResponse(param1:FrameEvent) : void
      {
         _keySetFrame.removeEventListener("response",__onKeySetResponse);
         _keySetFrame.dispose();
         _keySetFrame = null;
      }
      
      override public function dispose() : void
      {
         if(!this.parent)
         {
            return;
         }
         _cbBjyy && _cbBjyy.removeEventListener("click",__audioSelect);
         _cbYxyx && _cbYxyx.removeEventListener("click",__audioSelect);
         _cbWqtx && _cbWqtx.removeEventListener("click",__checkBoxClick);
         _cbLbgn && _cbLbgn.removeEventListener("click",__checkBoxClick);
         _cbJsyq && _cbJsyq.removeEventListener("click",__checkBoxClick);
         _cbSxts && _cbSxts.removeEventListener("click",__checkBoxClick);
         _academy && _academy.removeEventListener("click",__checkBoxClick);
         _guideFunction && _guideFunction.removeEventListener("click",__setIsGuideHandler);
         _communityFunction && _communityFunction.removeEventListener("click",__checkBoxClick);
         _refusedBeFriendBtn && _refusedBeFriendBtn.removeEventListener("click",__refusedBeFriendHandler);
         _refusedPrivateChatBtn && _refusedPrivateChatBtn.removeEventListener("click",__refusedPrivateChat);
         _sliderBjyy && _sliderBjyy.removeEventListener("stateChange",__musicSliderChanged);
         _sliderYxyx && _sliderYxyx.removeEventListener("stateChange",__soundSliderChanged);
         _keySettingBtn && _keySettingBtn.removeEventListener("click",__keySettingBtnClick);
         _cbqytx && _cbqytx.removeEventListener("click",__checkBoxClick);
         _cbshtx && _cbshtx.removeEventListener("click",__checkBoxClick);
         if(_keySetFrame)
         {
            _keySetFrame.removeEventListener("response",__onKeySetResponse);
            _keySetFrame.dispose();
            _keySetFrame = null;
         }
         var _loc1_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(_loc1_ && contains(_loc1_))
         {
            StageReferance.stage.focus = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _imgTitle1 = null;
         _imgTitle2 = null;
         _imgTitle3 = null;
         _smallText1 = null;
         _smallText2 = null;
         _bigText1 = null;
         _bigText2 = null;
         _bmpYpsz = null;
         _bmpXssz = null;
         _bmpGnsz = null;
         _cbBjyy = null;
         _cbYxyx = null;
         _cbWqtx = null;
         _cbLbgn = null;
         _cbqytx = null;
         _cbshtx = null;
         _cbJsyq = null;
         _cbSxts = null;
         _sliderBg1 = null;
         _sliderBg2 = null;
         _sliderBjyy = null;
         _sliderYxyx = null;
         _refusedBeFriendBtn = null;
         _refusedPrivateChatBtn = null;
         if(_keySettingBtn)
         {
            ObjectUtils.disposeObject(_keySettingBtn);
         }
         _keySettingBtn = null;
         super.dispose();
      }
   }
}
