package setting.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.Silder;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.OpitionEnum;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;      public class SettingView extends BaseAlerFrame   {                   private var _imgTitle1:Image;            private var _imgTitle2:Image;            private var _imgTitle3:Image;            private var _bmpYpsz:Bitmap;            private var _bmpXssz:Bitmap;            private var _bmpGnsz:Bitmap;            private var _cbBjyy:SelectedCheckButton;            private var _cbYxyx:SelectedCheckButton;            private var _cbWqtx:SelectedCheckButton;            private var _cbLbgn:SelectedCheckButton;            private var _cbqytx:SelectedCheckButton;            private var _cbshtx:SelectedCheckButton;            private var _cbJsyq:SelectedCheckButton;            private var _cbSxts:SelectedCheckButton;            private var _communityFunction:SelectedCheckButton;            private var _guideFunction:SelectedCheckButton;            private var _academy:SelectedCheckButton;            private var _refusedBeFriendBtn:SelectedCheckButton;            private var _refusedPrivateChatBtn:SelectedCheckButton;            private var _sliderBg1:Image;            private var _sliderBg2:Image;            private var _sliderBjyy:Silder;            private var _sliderYxyx:Silder;            private var _keySettingBtn:SimpleBitmapButton;            private var _keySetFrame:KeySetFrame;            private var _oldAllowMusic:Boolean;            private var _oldAllowSound:Boolean;            private var _oldShowParticle:Boolean;            private var _oldShowBugle:Boolean;            private var _oldShowInvate:Boolean;            private var _oldShowOL:Boolean;            private var _oldisRecommend:Boolean;            private var _oldMusicVolumn:Number;            private var _oldSoundVolumn:Number;            private var _oldIsCommunity:Boolean;            private var _smallText1:FilterFrameText;            private var _smallText2:FilterFrameText;            private var _bigText1:FilterFrameText;            private var _bigText2:FilterFrameText;            public function SettingView() { super(); }
            private function __refusedPrivateChat(e:MouseEvent) : void { }
            private function initView() : void { }
            private function initData() : void { }
            public function setShowSettingMovie() : void { }
            private function get allowMusic() : Boolean { return false; }
            private function set allowMusic(value:Boolean) : void { }
            private function get allowSound() : Boolean { return false; }
            private function set allowSound(value:Boolean) : void { }
            private function get particle() : Boolean { return false; }
            private function set particle(value:Boolean) : void { }
            private function get showbugle() : Boolean { return false; }
            private function set showbugle(value:Boolean) : void { }
            private function get invate() : Boolean { return false; }
            private function set invate(value:Boolean) : void { }
            private function get showOL() : Boolean { return false; }
            private function set showOL(value:Boolean) : void { }
            private function get musicVolumn() : int { return 0; }
            private function set musicVolumn(value:int) : void { }
            private function get soundVolumn() : int { return 0; }
            private function set soundVolumn(value:int) : void { }
            private function get isRecommend() : Boolean { return false; }
            private function set isRecommend(value:Boolean) : void { }
            private function audioChanged() : void { }
            private function get isCommunity() : Boolean { return false; }
            private function set isCommunity(value:Boolean) : void { }
            private function get friendshipEffect() : Boolean { return false; }
            private function get guardEffect() : Boolean { return false; }
            private function revert() : void { }
            public function doConfirm() : void { }
            public function doCancel() : void { }
            private function sliderEnable(slider:Silder, sliderBg:Image, enable:Boolean) : void { }
            private function __checkBoxClick(evt:MouseEvent) : void { }
            private function __audioSelect(evt:MouseEvent) : void { }
            private function __musicSliderChanged(evt:Event) : void { }
            private function __soundSliderChanged(evt:Event) : void { }
            private function __refusedBeFriendHandler(event:MouseEvent) : void { }
            private function __setIsGuideHandler(event:MouseEvent) : void { }
            protected function isSkillCanUse() : Boolean { return false; }
            private function __keySettingBtnClick(event:MouseEvent) : void { }
            private function __onKeySetResponse(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}