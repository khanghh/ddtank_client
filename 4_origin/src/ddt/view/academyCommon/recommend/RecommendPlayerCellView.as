package ddt.view.academyCommon.recommend
{
   import academy.AcademyManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class RecommendPlayerCellView extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      protected var _cellBg:Bitmap;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _vipName:GradientText;
      
      protected var _guildTxt:FilterFrameText;
      
      protected var _masterHonor:ScaleFrameImage;
      
      protected var _masterHonorText:GradientText;
      
      protected var _levelIcon:LevelIcon;
      
      protected var _vipIcon:VipLevelIcon;
      
      protected var _marriedIcon:MarriedIcon;
      
      protected var _badge:Badge;
      
      protected var _player:RoomCharacter;
      
      protected var _characteContainer:Sprite;
      
      protected var _iconContainer:VBox;
      
      protected var _recommendBtn:TextButton;
      
      protected var _info:AcademyPlayerInfo;
      
      protected var _isSelect:Boolean;
      
      protected var _tipStyle:String;
      
      protected var _tipDirctions:String;
      
      protected var _tipData:Object;
      
      protected var _tipGapH:int;
      
      protected var _tipGapV:int;
      
      protected var _chat:BaseButton;
      
      public function RecommendPlayerCellView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _cellBg = ComponentFactory.Instance.creatBitmap("academyCommon.cellViewPlayerBg");
         addChild(_cellBg);
         _characteContainer = new Sprite();
         addChild(_characteContainer);
         _masterHonor = ComponentFactory.Instance.creatComponentByStylename("academyCommon.RecommendPlayerCellView.masterHonor");
         _masterHonor.visible = false;
         addChild(_masterHonor);
         _guildTxt = ComponentFactory.Instance.creatComponentByStylename("academyCommon.RecommendPlayerCellView.guildTxt");
         addChild(_guildTxt);
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.RecommendPlayerCellView.iconContainer");
         addChild(_iconContainer);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("academy.RecommendPlayerCellView.levelIcon");
         _levelIcon.setSize(0);
         addChild(_levelIcon);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("academyCommon.RecommendPlayerCellView.nameTxt");
         _chat = ComponentFactory.Instance.creatComponentByStylename("academyCommon.RecommendPlayerCellView.masterChat");
         addChild(_chat);
         _tipStyle = "ddt.view.tips.OneLineTip";
         _tipDirctions = "0,4,5";
         _tipGapV = 5;
         _tipGapH = 5;
         _tipData = LanguageMgr.GetTranslation("ddt.view.academyCommon.recommend.RecommendPlayerCellView.tips");
         ShowTipManager.Instance.addTip(this);
         initRecommendBtn();
      }
      
      protected function initRecommendBtn() : void
      {
         _recommendBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.RecommendPlayerCellView.master");
         _recommendBtn.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.RecommendPlayerCellView.master");
         addChild(_recommendBtn);
      }
      
      protected function initEvent() : void
      {
         _recommendBtn.addEventListener("click",__recommendBtn);
         _chat.addEventListener("click",__chatHandler);
         addEventListener("mouseOver",__onOver);
         addEventListener("mouseOut",__onOut);
         _characteContainer.addEventListener("click",__onClick);
      }
      
      protected function __chatHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.alertPrivateFrame(_info.info.ID);
      }
      
      private function __onClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerInfoViewControl.viewByID(info.info.ID,PlayerManager.Instance.Self.ZoneID);
      }
      
      private function __onOut(event:MouseEvent) : void
      {
         if(_isSelect)
         {
         }
      }
      
      private function __onOver(event:MouseEvent) : void
      {
         if(_isSelect)
         {
         }
      }
      
      public function set isSelect(value:Boolean) : void
      {
         _isSelect = value;
         if(_isSelect)
         {
         }
      }
      
      public function get isSelect() : Boolean
      {
         return _isSelect;
      }
      
      private function createCharacter() : void
      {
         _player = CharactoryFactory.createCharacter(_info.info,"room") as RoomCharacter;
         _player.showGun = true;
         _player.show(true,-1);
         PositionUtils.setPos(_player,"academy.RecommendPlayerCellView.playerPos");
         _characteContainer.addChild(_player as DisplayObject);
      }
      
      protected function __recommendBtn(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!AcademyManager.Instance.compareState(_info.info,PlayerManager.Instance.Self))
         {
            return;
         }
         if(AcademyManager.Instance.isFreezes(true))
         {
            AcademyFrameManager.Instance.showAcademyRequestMasterFrame(_info.info);
         }
      }
      
      private function __characterComplete(event:Event) : void
      {
         _player.removeEventListener("complete",__characterComplete);
         PositionUtils.setPos(_player,"academy.RecommendPlayerCellView.playerPos");
         _characteContainer.addChild(_player as DisplayObject);
      }
      
      private function update() : void
      {
         var player:PlayerInfo = _info.info;
         _nameTxt.text = player.NickName;
         checkVip(player);
         _guildTxt.text = player.ConsortiaName;
         var masterLevel:int = AcademyManager.Instance.getMasterHonorLevel(player.graduatesCount);
         if(masterLevel != 0)
         {
            _masterHonor.visible = true;
            _masterHonor.setFrame(masterLevel);
         }
         else
         {
            _masterHonor.visible = false;
         }
         createCharacter();
         updateIcon();
      }
      
      protected function checkVip(player:PlayerInfo) : void
      {
         if(player.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(142,player.typeVIP);
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _nameTxt.text;
            addChild(_vipName);
         }
         addChild(_nameTxt);
         PositionUtils.adaptNameStyle(player,_nameTxt,_vipName);
      }
      
      protected function updateIcon() : void
      {
         var player:PlayerInfo = _info.info;
         _levelIcon.setInfo(player.Grade,player.ddtKingGrade,player.Repute,player.WinCount,player.TotalCount,player.FightPower,player.Offer,true,false);
         if(player.IsVIP)
         {
            if(_vipIcon == null)
            {
               _vipIcon = ComponentFactory.Instance.creatCustomObject("academy.RecommendPlayerCellView.VipIcon");
               _vipIcon.setInfo(player);
               _iconContainer.addChild(_vipIcon);
            }
         }
         else if(_vipIcon)
         {
            _vipIcon.dispose();
            _vipIcon = null;
         }
         if(player.SpouseID > 0)
         {
            if(_marriedIcon == null)
            {
               _marriedIcon = ComponentFactory.Instance.creatCustomObject("academy.RecommendPlayerCellView.MarriedIcon");
               _iconContainer.addChild(_marriedIcon);
            }
            _marriedIcon.tipData = {
               "nickName":player.SpouseName,
               "gender":player.Sex
            };
         }
         else
         {
            if(_marriedIcon != null)
            {
               _marriedIcon.dispose();
            }
            _marriedIcon = null;
         }
         if(player.badgeID > 0)
         {
            if(_badge == null)
            {
               _badge = new Badge();
               _badge.showTip = true;
               _badge.badgeID = player.badgeID;
               _badge.tipData = player.ConsortiaName;
               _iconContainer.addChild(_badge);
            }
         }
         else
         {
            ObjectUtils.disposeObject(_badge);
            _badge = null;
         }
      }
      
      public function set info(value:AcademyPlayerInfo) : void
      {
         _info = value;
         update();
      }
      
      public function get info() : AcademyPlayerInfo
      {
         return _info;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__onOver);
         removeEventListener("mouseOut",__onOut);
         if(_cellBg)
         {
            ObjectUtils.disposeObject(_cellBg);
            _cellBg = null;
         }
         if(_recommendBtn)
         {
            _recommendBtn.removeEventListener("click",__recommendBtn);
            ObjectUtils.disposeObject(_recommendBtn);
            _recommendBtn = null;
         }
         if(_masterHonor)
         {
            ObjectUtils.disposeObject(_masterHonor);
            _masterHonor = null;
         }
         if(_chat)
         {
            _chat.removeEventListener("click",__chatHandler);
            ObjectUtils.disposeObject(_chat);
            _chat = null;
         }
         if(_nameTxt)
         {
            _nameTxt.dispose();
            _nameTxt = null;
         }
         if(_guildTxt)
         {
            _guildTxt.dispose();
            _guildTxt = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_characteContainer && _characteContainer.parent)
         {
            _characteContainer.removeEventListener("click",__onClick);
            _characteContainer.parent.removeChild(_characteContainer);
            _characteContainer = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_vipIcon)
         {
            _vipIcon.dispose();
            _vipIcon = null;
         }
         if(_marriedIcon)
         {
            ObjectUtils.disposeObject(_marriedIcon);
         }
         _marriedIcon = null;
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         ObjectUtils.disposeObject(_iconContainer);
         _iconContainer = null;
         ShowTipManager.Instance.removeTip(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
