package bagAndInfo.info
{
   import armShell.ArmShellManager;
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.amulet.EquipAmuletManager;
   import bagAndInfo.bag.NecklacePtetrochemicalView;
   import bagAndInfo.bag.ring.RingSystemView;
   import bagAndInfo.bag.trailelite.TrailEliteView;
   import bagAndInfo.cell.CellFactory;
   import bagAndInfo.cell.PersonalInfoCell;
   import bagAndInfo.energyData.EnergyData;
   import baglocked.BaglockedManager;
   import cardSystem.CardManager;
   import cardSystem.CardSystemEvent;
   import cardSystem.data.CardInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.EquipType;
   import ddt.data.Experience;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.data.store.FineSuitVo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.EffortManager;
   import ddt.manager.FineSuitManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.utils.StaticFormula;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.tips.FineSuitTipsSimple;
   import ddt.view.tips.PlayerManualProTips;
   import explorerManual.ExplorerManualManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import gemstone.GemstoneManager;
   import gemstone.info.GemstListInfo;
   import guardCore.GuardCoreIcon;
   import guardCore.GuardCoreManager;
   import hall.event.NewHallEvent;
   import magicStone.data.MagicStoneInfo;
   import powerUp.PowerUpMovieManager;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import room.RoomManager;
   import shop.manager.ShopBuyManager;
   import team.TeamManager;
   import texpSystem.view.TexpInfoTipArea;
   import trainer.view.NewHandContainer;
   import vip.VipController;
   
   public class PlayerInfoView extends Sprite implements Disposeable
   {
       
      
      private var _info:PlayerInfo;
      
      private var _showSelfOperation:Boolean;
      
      private var _cellPos:Array;
      
      private var _energyData:EnergyData;
      
      private var _honorNameTxt:FilterFrameText;
      
      private var _playerInfoEffortHonorView:PlayerInfoEffortHonorView;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _dutyField:FilterFrameText;
      
      private var _storeBtn:SimpleBitmapButton;
      
      private var _reputeField:FilterFrameText;
      
      private var _gesteField:FilterFrameText;
      
      private var _iconContainer:VBox;
      
      private var _levelIcon:LevelIcon;
      
      private var _marriedIcon:MarriedIcon;
      
      private var _bagDefinitionGroup:SelectedButtonGroup;
      
      private var _bagDefinitionBtnI:SelectedCheckButton;
      
      private var _bagDefinitionBtnII:SelectedCheckButton;
      
      private var _battle:FilterFrameText;
      
      private var _hiddenControlsBg:Bitmap;
      
      private var _hideHatBtn:SelectedCheckButton;
      
      private var _hideGlassBtn:SelectedCheckButton;
      
      private var _hideSuitBtn:SelectedCheckButton;
      
      private var _hideWingBtn:SelectedCheckButton;
      
      private var _achvEnable:Boolean = true;
      
      private var _addFriendBtn:TextButton;
      
      private var _buyAvatar:TextButton;
      
      private var _attackTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _luckTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefenceTxt:FilterFrameText;
      
      private var _attackTxt1:FilterFrameText;
      
      private var _agilityTxt1:FilterFrameText;
      
      private var _defenceTxt1:FilterFrameText;
      
      private var _luckTxt1:FilterFrameText;
      
      private var _attackButton:GlowPropButton;
      
      private var _agilityButton:GlowPropButton;
      
      private var _defenceButton:GlowPropButton;
      
      private var _luckButton:GlowPropButton;
      
      private var _magicAttackButton:GlowPropButton;
      
      private var _magicDefenceButton:GlowPropButton;
      
      private var _damageTxt:FilterFrameText;
      
      private var _damageButton:PropButton;
      
      private var _armorTxt:FilterFrameText;
      
      private var _armorButton:PropButton;
      
      private var _HPText:FilterFrameText;
      
      private var _hpButton:PropButton;
      
      private var _vitality:FilterFrameText;
      
      private var _vitalityBuntton:PropButton;
      
      private var _textLevelPrpgress:FilterFrameText;
      
      private var _progressLevel:LevelProgress;
      
      private var _cellContent:Sprite;
      
      private var _character:RoomCharacter;
      
      private var _cells:Vector.<PersonalInfoCell>;
      
      private var _dragDropArea:PersonalInfoDragInArea;
      
      private var _offerLabel:Bitmap;
      
      private var _offerSourcePosition:Point;
      
      private var _vipName:GradientText;
      
      private var _showEquip:Sprite;
      
      private var _showCard:Sprite;
      
      private var _cardEquipView:Sprite;
      
      private var _bg:MutipleImage;
      
      private var _bg1:MovieImage;
      
      private var _textBg:Scale9CornerImage;
      
      private var _textBg1:Scale9CornerImage;
      
      private var _textBg2:Scale9CornerImage;
      
      private var _textBg3:Scale9CornerImage;
      
      private var _textBg4:Scale9CornerImage;
      
      private var _textBg5:Scale9CornerImage;
      
      private var _textBg6:Scale9CornerImage;
      
      private var _bg2:MovieImage;
      
      private var _gongxunbg:MovieImage;
      
      private var _characterSprite:TexpInfoTipArea;
      
      private var _isVisible:Boolean = true;
      
      private var _openNecklacePtetrochemicalView:SimpleBitmapButton;
      
      private var _necklacePtetrochemicalView:NecklacePtetrochemicalView;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _fineSuitIcon:ScaleFrameImage;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _guardCore:GuardCoreIcon;
      
      private var _explorerIcon:ScaleFrameImage;
      
      private var _ringSystemBtn:SimpleBitmapButton;
      
      private var _ringSystemView:RingSystemView;
      
      private var _trailEliteBtn:SimpleBitmapButton;
      
      private var _trailEliteView:TrailEliteView;
      
      protected var _armShellBitmapBtn:BaseButton;
      
      private var _amuletBtn:SimpleBitmapButton;
      
      private var _teamIcon:ScaleFrameImage;
      
      private var _switchShowII:Boolean = true;
      
      private var _isTextTips:Boolean;
      
      public function PlayerInfoView()
      {
         super();
         initView();
         initProperties();
         initPos();
         creatCells();
         initEvents();
         cardGuide1();
         checkGuardCoreGuide();
      }
      
      private function cardGuide1() : void
      {
         var _loc1_:* = null;
         if(!PlayerManager.Instance.Self.isNewOnceFinish(125))
         {
            if(PlayerManager.Instance.Self.Grade == 14 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(25)))
            {
               _loc1_ = PlayerManager.Instance.Self.cardBagDic;
               if(_loc1_.length > 0)
               {
                  cardGuide2(null);
               }
               else
               {
                  NewHandContainer.Instance.showArrow(141,0,new Point(-150,0),"asset.trainer.txtCardGuide1","guide.card.txtPos1",this);
                  PlayerManager.Instance.Self.cardBagDic.addEventListener("add",cardGuide2);
               }
            }
         }
      }
      
      private function cardGuide2(param1:DictionaryEvent) : void
      {
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("add",cardGuide2);
         NewHandContainer.Instance.showArrow(141,180,new Point(294,157),"","",LayerManager.Instance.getLayerByType(2),0,true);
      }
      
      public function checkGuardCoreGuide() : void
      {
         if(_showSelfOperation && _info && _info.ID == PlayerManager.Instance.Self.ID && PlayerManager.Instance.Self.Grade >= 50 && !PlayerManager.Instance.Self.isNewOnceFinish(140))
         {
            NewHandContainer.Instance.showArrow(150,180,new Point(308,249),"","",this,0,true);
         }
      }
      
      public function checkGuide() : void
      {
         var _loc1_:int = 0;
         if(_showSelfOperation && _info && _info.isSelf)
         {
            _loc1_ = PlayerManager.Instance.Self.Grade;
            if(_loc1_ >= 50 && !PlayerManager.Instance.Self.isNewOnceFinish(140))
            {
               NewHandContainer.Instance.showArrow(150,180,new Point(308,249),"","",this,0,true);
            }
            else if(_loc1_ >= 70 && !PlayerManager.Instance.Self.isNewOnceFinish(160))
            {
               NewHandContainer.Instance.showArrow(151,180,new Point(310,169),"","",this,0,true);
            }
            else if(_loc1_ >= 32 && !PlayerManager.Instance.Self.isNewOnceFinish(161))
            {
               NewHandContainer.Instance.showArrow(152,180,new Point(156,169),"","",this,0,true);
            }
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bagBGAsset2");
         addChild(_bg);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.view.bg");
         addChild(_bg1);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.view.ddtbg");
         _bg2.visible = _showSelfOperation;
         addChild(_bg2);
         _dragDropArea = new PersonalInfoDragInArea();
         addChild(_dragDropArea);
         _textBg = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextView");
         addChild(_textBg);
         _textBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextViewI");
         addChild(_textBg1);
         _textBg2 = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextViewII");
         addChild(_textBg2);
         _textBg3 = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextViewIII");
         addChild(_textBg3);
         _textBg4 = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextViewIV");
         addChild(_textBg4);
         _textBg5 = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextViewV");
         addChild(_textBg5);
         _textBg6 = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfoTextViewVI");
         addChild(_textBg6);
         _gongxunbg = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.view.gongxunBg");
         addChild(_gongxunbg);
         _honorNameTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewNameText");
         if(PathManager.solveAchieveEnable())
         {
            addChild(_honorNameTxt);
         }
         _honorNameTxt.setTextFormat(_honorNameTxt.getTextFormat());
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewNickNameText");
         _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
         addChild(_attestBtn);
         _attestBtn.visible = false;
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewConsortiaText");
         addChild(_consortiaTxt);
         _bagDefinitionBtnI = ComponentFactory.Instance.creat("bag.DefinitionBtnI");
         addChild(_bagDefinitionBtnI);
         _bagDefinitionBtnII = ComponentFactory.Instance.creat("bag.DefinitionBtnII");
         addChild(_bagDefinitionBtnII);
         _bagDefinitionGroup = new SelectedButtonGroup();
         _bagDefinitionGroup.addSelectItem(_bagDefinitionBtnI);
         _bagDefinitionGroup.addSelectItem(_bagDefinitionBtnII);
         _bagDefinitionBtnI.visible = false;
         _bagDefinitionBtnII.visible = false;
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewAttackText");
         addChild(_attackTxt);
         _attackButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.AttackButton");
         _attackButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.attact");
         _attackButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.attactDetail");
         _attackButton.propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.propertySourceTxt",0,0,0,0,0,0,0,0);
         ShowTipManager.Instance.addTip(_attackButton);
         addChild(_attackButton);
         _agilityTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewAgilityText");
         addChild(_agilityTxt);
         _agilityButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.AgilityButton");
         _agilityButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.agility");
         _agilityButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.agilityDetail");
         _agilityButton.propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.propertySourceTxt",0,0,0,0,0,0,0,0,0);
         ShowTipManager.Instance.addTip(_agilityButton);
         addChild(_agilityButton);
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewDefenceText");
         addChild(_defenceTxt);
         _defenceButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.DefenceButton");
         _defenceButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.defense");
         _defenceButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.defenseDetail");
         _defenceButton.propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.propertySourceTxt",0,0,0,0,0,0,0,0);
         ShowTipManager.Instance.addTip(_defenceButton);
         addChild(_defenceButton);
         _luckTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewLuckText");
         addChild(_luckTxt);
         _luckButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.LuckButton");
         _luckButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.luck");
         _luckButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.luckDetail");
         _luckButton.propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.propertySourceTxt",0,0,0,0,0,0,0,0);
         ShowTipManager.Instance.addTip(_luckButton);
         addChild(_luckButton);
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewMagicAttackText");
         addChild(_magicAttackTxt);
         _magicAttackButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.MagicAttackButton");
         _magicAttackButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicAttack");
         _magicAttackButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicAttackDetail");
         _magicAttackButton.propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicAttackDefencePropertySourceTxt",0);
         ShowTipManager.Instance.addTip(_magicAttackButton);
         addChild(_magicAttackButton);
         _magicDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewMagicDefenceText");
         addChild(_magicDefenceTxt);
         _magicDefenceButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.MagicDefenceButton");
         _magicDefenceButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicDefence");
         _magicDefenceButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicDefenceDetail");
         _magicDefenceButton.propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicAttackDefencePropertySourceTxt",0);
         ShowTipManager.Instance.addTip(_magicDefenceButton);
         addChild(_magicDefenceButton);
         _damageTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewDamageText");
         addChild(_damageTxt);
         _damageButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.DamageButton");
         _damageButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.damage");
         _damageButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.damageDetail");
         (_damageButton as GlowPropButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.damagePropertySourceTxt",0,0,0);
         ShowTipManager.Instance.addTip(_damageButton);
         addChild(_damageButton);
         _armorTxt = ComponentFactory.Instance.creatComponentByStylename("personInfoViewArmorText");
         addChild(_armorTxt);
         _armorButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.ArmorButton");
         _armorButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.recovery");
         _armorButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.recoveryDetail");
         (_armorButton as GlowPropButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.recoveryPropertySourceTxt",0,0,0);
         ShowTipManager.Instance.addTip(_armorButton);
         addChild(_armorButton);
         _HPText = ComponentFactory.Instance.creatComponentByStylename("personInfoViewHPText");
         addChild(_HPText);
         _hpButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.HPButton");
         _hpButton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.hp");
         _hpButton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.hpDetail");
         (_hpButton as GlowPropButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.hpPropertySourceTxt",0,0,0,0,0,0,0,0,0,0);
         ShowTipManager.Instance.addTip(_hpButton);
         addChild(_hpButton);
         _vitality = ComponentFactory.Instance.creatComponentByStylename("personInfoViewVitalityText");
         addChild(_vitality);
         _vitalityBuntton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.VitalityButton");
         _vitalityBuntton.property = LanguageMgr.GetTranslation("tank.view.personalinfoII.energy");
         _vitalityBuntton.detail = LanguageMgr.GetTranslation("tank.view.personalinfoII.energyDetail");
         ShowTipManager.Instance.addTip(_vitalityBuntton);
         addChild(_vitalityBuntton);
         _storeBtn = ComponentFactory.Instance.creatComponentByStylename("personInfoViewStoreButton");
         _storeBtn.tipData = LanguageMgr.GetTranslation("tank.view.shortcutforge.tip");
         addChild(_storeBtn);
         _storeBtn.visible = true;
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("addFriendBtn1");
         PositionUtils.setPos(_addFriendBtn,"bagAndInfo.FritendBtn.Pos");
         _addFriendBtn.text = LanguageMgr.GetTranslation("tank.view.im.addFriendBtn");
         addChild(_addFriendBtn);
         _reputeField = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.ReputeField");
         addChild(_reputeField);
         _gesteField = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.GesteField");
         addChild(_gesteField);
         _offerLabel = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.OfferLabel");
         addChild(_offerLabel);
         _offerLabel.visible = false;
         _offerSourcePosition = new Point(_offerLabel.x,_offerLabel.y);
         _dutyField = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.DutyField");
         addChild(_dutyField);
         _playerInfoEffortHonorView = new PlayerInfoEffortHonorView();
         if(PathManager.solveAchieveEnable())
         {
            addChild(_playerInfoEffortHonorView);
         }
         _showEquip = new Sprite();
         addChild(_showEquip);
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.bagAndInfo.iconContainer");
         _showEquip.addChild(_iconContainer);
         _showCard = new Sprite();
         addChild(_showCard);
         _showCard.visible = false;
         _battle = ComponentFactory.Instance.creatComponentByStylename("personInfoViewBattleText");
         _showEquip.addChild(_battle);
         _progressLevel = ComponentFactory.Instance.creatComponentByStylename("LevelProgress");
         _showEquip.addChild(_progressLevel);
         _progressLevel.tipStyle = "ddt.view.tips.OneLineTip";
         _progressLevel.tipDirctions = "3,7,6";
         _progressLevel.tipGapV = 4;
         _hideGlassBtn = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         _showEquip.addChild(_hideGlassBtn);
         _hideHatBtn = ComponentFactory.Instance.creatComponentByStylename("personanHideGlassCheckBox");
         _showEquip.addChild(_hideHatBtn);
         _hideSuitBtn = ComponentFactory.Instance.creatComponentByStylename("personanHideSuitCheckBox");
         _showEquip.addChild(_hideSuitBtn);
         _hideWingBtn = ComponentFactory.Instance.creatComponentByStylename("personanHideWingCheckBox");
         _showEquip.addChild(_hideWingBtn);
         _buyAvatar = ComponentFactory.Instance.creatComponentByStylename("addFriendBtn2");
         _buyAvatar.text = LanguageMgr.GetTranslation("ddt.bagandinfo.buyOtherCloth");
         _buyAvatar.x = 181;
         _buyAvatar.y = 74;
         _showEquip.addChild(_buyAvatar);
         _cellContent = new Sprite();
         _showEquip.addChild(_cellContent);
         _attackTxt1 = ComponentFactory.Instance.creatComponentByStylename("personInfoViewAttackText");
         addChild(_attackTxt1);
         PositionUtils.setPos(_attackTxt1,"personInfoViewAttackTextPos");
         _attackTxt1.visible = false;
         _agilityTxt1 = ComponentFactory.Instance.creatComponentByStylename("personInfoViewAgilityText");
         addChild(_agilityTxt1);
         PositionUtils.setPos(_agilityTxt1,"personInfoViewAgilityPos");
         _agilityTxt1.visible = false;
         _defenceTxt1 = ComponentFactory.Instance.creatComponentByStylename("personInfoViewDefenceText");
         addChild(_defenceTxt1);
         PositionUtils.setPos(_defenceTxt1,"personInfoViewDefencePos");
         _defenceTxt1.visible = false;
         _luckTxt1 = ComponentFactory.Instance.creatComponentByStylename("personInfoViewLuckText");
         addChild(_luckTxt1);
         PositionUtils.setPos(_luckTxt1,"personInfoViewLuckPos");
         _luckTxt1.visible = false;
         _openNecklacePtetrochemicalView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.NecklacePtetrochemicalView.OpenBtn");
         addChild(_openNecklacePtetrochemicalView);
         _ringSystemBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.OpenBtn");
         addChild(_ringSystemBtn);
         _trailEliteBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.OpenBtn");
         addChild(_trailEliteBtn);
         _amuletBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.enterFrameBtn");
         addChild(_amuletBtn);
         FineSuitTipsSimple;
         PlayerManualProTips;
         _fineSuitIcon = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tipsSimple.Icon");
         _showEquip.addChild(_fineSuitIcon);
         _explorerIcon = ComponentFactory.Instance.creatComponentByStylename("explorerManual.playerManualEnter.levIcon");
         _showEquip.addChild(_explorerIcon);
         _explorerIcon.buttonMode = true;
         _teamIcon = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.playerinfoView.teamIcon");
         _teamIcon.visible = false;
         _showEquip.addChild(_teamIcon);
      }
      
      protected function addArmShellBtn() : void
      {
         if(_showSelfOperation && _armShellBitmapBtn == null)
         {
            _armShellBitmapBtn = ComponentFactory.Instance.creatComponentByStylename("core.isArmShellBitmapBtn");
            _armShellBitmapBtn.addEventListener("click",__armShellBitmapBtnClickHandler);
            addChild(_armShellBitmapBtn);
         }
      }
      
      protected function removeArmShellBtn() : void
      {
         if(_armShellBitmapBtn)
         {
            _armShellBitmapBtn.removeEventListener("click",__armShellBitmapBtnClickHandler);
            ObjectUtils.disposeObject(_armShellBitmapBtn);
            _armShellBitmapBtn = null;
         }
      }
      
      protected function __armShellBitmapBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ArmShellManager.instance.showArmShellFrame();
      }
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         dispatchEvent(new ShortcutBuyEvent(param1.ItemID,param1.ItemNum));
      }
      
      private function createCardEquip() : void
      {
         if(!_cardEquipView)
         {
            CardManager.Instance.addEventListener("bagEquipViewComplete",__cardViewComplete);
            CardManager.Instance.showView(0);
         }
      }
      
      protected function __cardViewComplete(param1:CardSystemEvent) : void
      {
         _cardEquipView = param1.info;
         _showCard.addChild(_cardEquipView);
         if(_info)
         {
            _cardEquipView["playerInfo"] = _info;
            _cardEquipView["showSelfOperation"] = _showSelfOperation;
         }
         _cardEquipView["clickEnable"] = _switchShowII;
         SocketManager.Instance.out.getPlayerCardInfo(_info.ID);
      }
      
      public function switchShow(param1:Boolean) : void
      {
         _isTextTips = param1;
         _showEquip.visible = !param1;
         _showCard.visible = param1;
         _bg.visible = !param1;
         _bg1.visible = !param1;
         _bg2.visible = _showSelfOperation;
         _nickNameTxt.visible = !param1;
         _consortiaTxt.visible = !param1;
         _dutyField.visible = !param1;
         _reputeField.visible = !param1;
         _damageTxt.visible = !param1;
         _damageButton.visible = !param1;
         _armorTxt.visible = !param1;
         _armorButton.visible = !param1;
         _HPText.visible = !param1;
         _hpButton.visible = !param1;
         _vitality.visible = !param1;
         _vitalityBuntton.visible = !param1;
         if(_vipName != null)
         {
            _vipName.visible = !param1;
            _isVisible = !param1;
         }
         _textBg1.visible = !param1;
         _textBg2.visible = !param1;
         _textBg3.visible = !param1;
         _textBg4.visible = !param1;
         _textBg5.visible = !param1;
         _textBg6.visible = !param1;
         _attackTxt.visible = !param1;
         _attackButton.visible = !param1;
         _agilityTxt.visible = !param1;
         _agilityButton.visible = !param1;
         _defenceTxt.visible = !param1;
         _defenceButton.visible = !param1;
         _luckTxt.visible = !param1;
         _luckButton.visible = !param1;
         _magicAttackTxt.visible = !param1;
         _magicAttackButton.visible = !param1;
         _magicDefenceTxt.visible = !param1;
         _magicDefenceButton.visible = !param1;
         _attackTxt1.visible = param1;
         _agilityTxt1.visible = param1;
         _defenceTxt1.visible = param1;
         _luckTxt1.visible = param1;
         __onUpdatePlayerProperty(null);
         if(param1 && _cardEquipView == null)
         {
            createCardEquip();
         }
         _openNecklacePtetrochemicalView.visible = _showSelfOperation && _showEquip.visible;
         if(_armShellBitmapBtn)
         {
            _armShellBitmapBtn.visible = !param1;
         }
         _trailEliteBtn.visible = _showSelfOperation && !param1;
      }
      
      public function cardEquipShine(param1:CardInfo) : void
      {
         if(param1.templateInfo.Property8 == "1")
         {
            _cardEquipView["shineMain"]();
         }
         else
         {
            _cardEquipView["shineVice"]();
         }
      }
      
      public function switchShowII(param1:Boolean) : void
      {
         _switchShowII = !param1;
         switchShow(param1);
         if(_cardEquipView)
         {
            _cardEquipView["clickEnable"] = _showSelfOperation;
         }
         _addFriendBtn.visible = !param1;
         if(_info.ID == PlayerManager.Instance.Self.ID)
         {
            _addFriendBtn.visible = false;
         }
      }
      
      private function initProperties() : void
      {
         _storeBtn.transparentEnable = true;
         _hideHatBtn.text = LanguageMgr.GetTranslation("shop.ShopIITryDressView.hideHat");
         _hideGlassBtn.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.glass");
         _hideSuitBtn.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.suit");
         _hideWingBtn.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.wing");
      }
      
      private function initPos() : void
      {
         _cellPos = [ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos1"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos2"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos3"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos4"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos5"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos6"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos7"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos8"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos9"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos10"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos11"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos12"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos13"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos14"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos15"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos16"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos17"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos18"),ComponentFactory.Instance.creatCustomObject("bagAndInfo.info.equip.pos19")];
      }
      
      private function initEvents() : void
      {
         _storeBtn.addEventListener("click",__storeBtnClickHandler);
         _addFriendBtn.addEventListener("click",__addFriendClickHandler);
         _buyAvatar.addEventListener("click",__buyAvatarClickHandler);
         _hideGlassBtn.addEventListener("click",__hideGlassClickHandler);
         _hideHatBtn.addEventListener("click",__hideHatClickHandler);
         _hideSuitBtn.addEventListener("click",__hideSuitClickHandler);
         _hideWingBtn.addEventListener("click",__hideWingClickHandler);
         _bagDefinitionGroup.addEventListener("change",_definitionGroupChange);
         _openNecklacePtetrochemicalView.addEventListener("click",__openNecklacePtetrochemicalView);
         _ringSystemBtn.addEventListener("click",__openRingSystemView);
         _trailEliteBtn.addEventListener("click",_openTrailEliteView);
         _amuletBtn.addEventListener("click",__onClickAmulet);
         _explorerIcon.addEventListener("click",__openExplorerHandler);
         PlayerManager.Instance.addEventListener("updatePlayerState",__onUpdatePlayerProperty);
         if(_teamIcon)
         {
            _teamIcon.addEventListener("click",__onClickTeam);
         }
      }
      
      private function __onClickTeam(param1:MouseEvent) : void
      {
         if(_info && _info.isSelf && _showSelfOperation)
         {
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.Grade < 26)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",26));
               return;
            }
            BagAndInfoManager.Instance.hideBagAndInfo();
            TeamManager.instance.showTeamFrame();
         }
      }
      
      private function __openExplorerHandler(param1:MouseEvent) : void
      {
         if(_info is SelfInfo)
         {
            SoundManager.instance.playButtonSound();
            ExplorerManualManager.instance.show();
            BagAndInfoManager.Instance.hideBagAndInfo();
            if(!PlayerManager.Instance.Self.isNewOnceFinish(161))
            {
               SocketManager.Instance.out.syncWeakStep(161);
            }
         }
      }
      
      protected function __openRingSystemView(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _ringSystemView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.ringSystemView");
         LayerManager.Instance.addToLayer(_ringSystemView,3,true,1);
         _ringSystemView.addEventListener("response",__onRingSystemClose);
      }
      
      private function _openTrailEliteView(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(BagAndInfoManager.Instance.trialEliteModel.isOpen)
         {
            _trailEliteView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView");
            LayerManager.Instance.addToLayer(_trailEliteView,3,true,1);
            _trailEliteView.addEventListener("response",__onTrailEliteSystemClose);
         }
      }
      
      protected function __onRingSystemClose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            SoundManager.instance.playButtonSound();
            _ringSystemView.removeEventListener("response",__onRingSystemClose);
            ObjectUtils.disposeObject(_ringSystemView);
            _ringSystemView = null;
         }
      }
      
      protected function __onTrailEliteSystemClose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            SoundManager.instance.playButtonSound();
            _trailEliteView.removeEventListener("response",__onTrailEliteSystemClose);
            ObjectUtils.disposeObject(_trailEliteView);
            _trailEliteView = null;
         }
      }
      
      protected function __openNecklacePtetrochemicalView(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _necklacePtetrochemicalView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.necklacePtetrochemicalView");
         _necklacePtetrochemicalView.show();
         _necklacePtetrochemicalView.addEventListener("response",__onNecklacePtetrochemicalClose);
      }
      
      protected function __onNecklacePtetrochemicalClose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            SoundManager.instance.playButtonSound();
            _necklacePtetrochemicalView.removeEventListener("response",__onNecklacePtetrochemicalClose);
            ObjectUtils.disposeObject(_necklacePtetrochemicalView);
            _necklacePtetrochemicalView = null;
         }
      }
      
      private function __onClickAmulet(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Bag.items[18] == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.notEquipAmulet"));
            return;
         }
         EquipAmuletManager.Instance.show();
      }
      
      protected function __onUpdatePlayerProperty(param1:Event) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(_info.propertyAddition == null)
         {
            return;
         }
         var _loc4_:Vector.<GlowPropButton> = Vector.<GlowPropButton>([_attackButton,_defenceButton,_agilityButton,_luckButton]);
         var _loc12_:Array = ["Attack","Defence","Agility","Luck"];
         var _loc9_:int = 0;
         var _loc23_:String = LanguageMgr.GetTranslation("tank.data.EquipType.suit");
         var _loc5_:String = LanguageMgr.GetTranslation("tank.data.EquipType.gem");
         var _loc25_:int = 0;
         var _loc24_:* = _loc12_;
         for each(var _loc6_ in _loc12_)
         {
            _loc7_ = _info.getPropertyAdditionByType(_loc6_);
            if(_loc7_)
            {
               _loc8_ = LanguageMgr.GetTranslation("tank.view.personalinfoII.propertySourceTxt",_loc7_["Texp"],_loc7_["Card"],_loc7_["Pet"],_loc7_["Totem"],_loc7_["gem"],_loc7_["Bead"],_loc7_["Avatar"],_loc7_["MagicStone"],_loc7_["Temple"],_loc7_["mark"]);
               if(!PathManager.solveGemstoneSwitch)
               {
                  _loc8_ = LanguageMgr.GetTranslation("tank.view.personalinfoII.propertySourceTxt.noGemstone",_loc7_["Texp"],_loc7_["Card"],_loc7_["Pet"],_loc7_["Totem"],_loc7_["Bead"],_loc7_["Avatar"],_loc7_["MagicStone"],_loc7_["Temple"]);
               }
               if(PathManager.suitEnable)
               {
                  _loc8_ = _loc8_ + ("\n" + _loc23_ + "+" + _loc7_["Suit"]);
               }
               _loc4_[_loc9_].propertySource = _loc8_;
            }
            if(_loc9_ < 4)
            {
               _loc9_++;
               continue;
            }
            break;
         }
         var _loc21_:DictionaryData = _info.getPropertyAdditionByType("MagicAttack");
         if(_loc21_)
         {
            GlowPropButton(_magicAttackButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicAttackDefencePropertySourceTxt",_loc21_["MagicStone"],_loc21_["Horse"],_loc21_["HorsePicCherish"],_loc21_["Enchant"],_loc21_["Suit"],_loc21_["Texp"],_loc21_["Card"],_loc21_["mark"]);
         }
         var _loc19_:DictionaryData = _info.getPropertyAdditionByType("MagicDefence");
         if(_loc19_)
         {
            GlowPropButton(_magicDefenceButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.magicDefencePropertySourceTxt",_loc19_["MagicStone"],_loc19_["Horse"],_loc19_["HorsePicCherish"],_loc19_["Enchant"],_loc19_["Suit"],_loc19_["Texp"],_loc19_["Temple"],_loc19_["Card"],_loc19_["mark"]);
         }
         var _loc2_:DictionaryData = _info.getPropertyAdditionByType("HP");
         if(_loc2_)
         {
            GlowPropButton(_hpButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.hpPropertySourceTxt",_loc2_["Texp"],_loc2_["Pet"],_loc2_["Totem"],_loc2_["Bead"],_loc2_["Avatar"],_loc2_["Horse"],_loc2_["HorsePicCherish"],_loc2_["Temple"],_info.horseAmuletHp,_loc2_["mark"]);
            if(PathManager.solveGemstoneSwitch)
            {
               GlowPropButton(_hpButton).propertySource = GlowPropButton(_hpButton).propertySource + ("\n" + _loc5_ + "+" + _loc2_["gem"]);
            }
            if(PathManager.suitEnable && _loc2_)
            {
               GlowPropButton(_hpButton).propertySource = GlowPropButton(_hpButton).propertySource + ("\n" + _loc23_ + "+" + _loc2_["Suit"]);
            }
         }
         var _loc15_:DictionaryData = _info.getPropertyAdditionByType("Armor");
         var _loc22_:int = 0;
         var _loc14_:int = 0;
         var _loc17_:int = 0;
         var _loc16_:int = 0;
         var _loc20_:int = 0;
         var _loc18_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         if(_loc15_)
         {
            _loc22_ = _loc15_["Totem"];
            _loc14_ = _loc15_["Bead"];
            _loc17_ = _loc15_["Avatar"];
            _loc16_ = _loc15_["Horse"];
            _loc20_ = _loc15_["HorsePicCherish"];
            _loc18_ = _loc15_["Pet"];
            _loc13_ = _loc15_["Temple"];
            _loc11_ = _loc15_["mark"];
         }
         var _loc3_:DictionaryData = _info.getPropertyAdditionByType("Guard");
         GlowPropButton(_armorButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.recoveryPropertySourceTxt",StaticFormula.getCardRecoveryAddition(_info),_loc22_,_loc14_,_loc17_,_loc16_,_loc20_,_loc18_,_loc13_,_loc11_);
         if(PathManager.suitEnable && _loc3_)
         {
            GlowPropButton(_armorButton).propertySource = GlowPropButton(_armorButton).propertySource + ("\n" + _loc23_ + "+" + _loc3_["Suit"]);
         }
         var _loc10_:DictionaryData = _info.getPropertyAdditionByType("Damage");
         _loc22_ = 0;
         _loc14_ = 0;
         _loc17_ = 0;
         if(_loc10_)
         {
            _loc22_ = _loc10_["Totem"];
            _loc14_ = _loc10_["Bead"];
            _loc17_ = _loc10_["Avatar"];
            _loc16_ = _loc10_["Horse"];
            _loc20_ = _loc10_["HorsePicCherish"];
            _loc18_ = _loc10_["mark"];
         }
         GlowPropButton(_damageButton).propertySource = LanguageMgr.GetTranslation("tank.view.personalinfoII.damagePropertySourceTxt",StaticFormula.getCardDamageAddition(_info),_loc22_,_loc14_,_loc17_,_loc16_,_loc20_,_loc18_);
         if(PathManager.suitEnable && _loc10_)
         {
            GlowPropButton(_damageButton).propertySource = GlowPropButton(_damageButton).propertySource + ("\n" + _loc23_ + "+" + _loc10_["Suit"]);
         }
         if(PlayerManager.Instance.Self.Bag.items[12])
         {
            if(!_openNecklacePtetrochemicalView.parent)
            {
               addChild(_openNecklacePtetrochemicalView);
            }
         }
         else if(_openNecklacePtetrochemicalView.parent)
         {
            _openNecklacePtetrochemicalView.parent.removeChild(_openNecklacePtetrochemicalView);
         }
         showHideSmallBtn();
      }
      
      private function showHideSmallBtn() : void
      {
         var _loc2_:* = null;
         _ringSystemBtn.visible = _showSelfOperation && _showEquip.visible?PlayerManager.Instance.Self.Bag.items[16]:false;
         var _loc1_:Boolean = _showSelfOperation && _showEquip.visible?PlayerManager.Instance.Self.Bag.items[18]:false;
         if(_loc1_)
         {
            _loc2_ = PlayerManager.Instance.Self.Bag.items[18] as InventoryItemInfo;
            if(_loc2_.CategoryID != 19)
            {
               _amuletBtn.visible = true;
            }
            else
            {
               _amuletBtn.visible = false;
            }
         }
         else
         {
            _amuletBtn.visible = false;
         }
      }
      
      private function removeEvent() : void
      {
         _storeBtn.removeEventListener("click",__storeBtnClickHandler);
         _addFriendBtn.removeEventListener("click",__addFriendClickHandler);
         _buyAvatar.removeEventListener("click",__buyAvatarClickHandler);
         _hideGlassBtn.removeEventListener("click",__hideGlassClickHandler);
         _hideHatBtn.removeEventListener("click",__hideHatClickHandler);
         _hideSuitBtn.removeEventListener("click",__hideSuitClickHandler);
         _hideWingBtn.removeEventListener("click",__hideWingClickHandler);
         _openNecklacePtetrochemicalView.removeEventListener("click",__openNecklacePtetrochemicalView);
         _ringSystemBtn.removeEventListener("click",__openRingSystemView);
         _trailEliteBtn.removeEventListener("click",_openTrailEliteView);
         _amuletBtn.removeEventListener("click",__onClickAmulet);
         if(_teamIcon)
         {
            _teamIcon.removeEventListener("click",__onClickTeam);
         }
         _explorerIcon.removeEventListener("click",__openExplorerHandler);
         if(_info is PlayerInfo)
         {
            _info.Bag.removeEventListener("update",__updateCells);
            _info.removeEventListener("propertychange",__changeHandler);
            if(_info is SelfInfo)
            {
               (_info as SelfInfo).magicStoneBag.removeEventListener("update",__equipMagicStone);
            }
         }
         PlayerManager.Instance.removeEventListener("VIPStateChange",__upVip);
         _bagDefinitionGroup.removeEventListener("change",_definitionGroupChange);
         PlayerManager.Instance.removeEventListener("updatePlayerState",__onUpdatePlayerProperty);
         CardManager.Instance.removeEventListener("bagEquipViewComplete",__cardViewComplete);
      }
      
      private function __storeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade < 5)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
            return;
         }
         BagStore.instance.isFromBagFrame = true;
         BagStore.instance.openStore();
      }
      
      private function __addFriendClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.addFriend(_info.NickName);
      }
      
      private function __buyAvatarClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ShopBuyManager.Instance.buyAvatar(_info);
      }
      
      private function __hideGlassClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendHideLayer(2,_hideGlassBtn.selected);
      }
      
      private function __hideHatClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendHideLayer(1,_hideHatBtn.selected);
      }
      
      private function __hideSuitClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendHideLayer(13,_hideSuitBtn.selected);
      }
      
      private function __hideWingClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendHideLayer(15,_hideWingBtn.selected);
      }
      
      private function creatCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Vector.<PersonalInfoCell>();
         _loc2_ = 0;
         while(_loc2_ < 19)
         {
            _loc1_ = CellFactory.instance.createPersonalInfoCell(_loc2_) as PersonalInfoCell;
            switch(int(_loc2_))
            {
               case 0:
               case 1:
               case 2:
               case 3:
               case 4:
               case 5:
                  break;
               default:
               default:
               default:
               default:
               default:
               case 11:
               default:
               case 13:
                  _loc1_.addEventListener("itemclick",__cellClickHandler);
                  _loc1_.addEventListener("doubleclick",__cellDoubleClickHandler);
            }
            _loc1_.x = _cellPos[_loc2_].x;
            _loc1_.y = _cellPos[_loc2_].y;
            _cellContent.addChild(_loc1_);
            _cells.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function clearCells() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cells.length)
         {
            if(_cells[_loc1_])
            {
               if(_cells[_loc1_].hasEventListener("itemclick"))
               {
                  _cells[_loc1_].removeEventListener("itemclick",__cellClickHandler);
               }
               if(_cells[_loc1_].hasEventListener("doubleclick"))
               {
                  _cells[_loc1_].removeEventListener("doubleclick",__cellDoubleClickHandler);
               }
               if(_cells[_loc1_].parent)
               {
                  _cells[_loc1_].parent.removeChild(_cells[_loc1_] as PersonalInfoCell);
               }
               _cells[_loc1_].dispose();
               _cells[_loc1_] = null;
            }
            _loc1_++;
         }
      }
      
      public function set info(param1:*) : void
      {
         PlayerInfoViewControl.currentPlayer = param1;
         if(_info == param1)
         {
            return;
         }
         if(PlayerInfoViewControl._isBattle)
         {
            _info = param1;
            updateView(PlayerInfoViewControl._isBattle);
            return;
         }
         if(_info)
         {
            _info.removeEventListener("propertychange",__changeHandler);
            PlayerManager.Instance.removeEventListener("VIPStateChange",__upVip);
            PlayerManager.Instance.removeEventListener("equip",__onBeadBagUpdate);
            _info.Bag.removeEventListener("update",__updateCells);
            if(_info is SelfInfo)
            {
               (_info as SelfInfo).magicStoneBag.removeEventListener("update",__equipMagicStone);
            }
            _info = null;
         }
         _info = param1;
         if(_info)
         {
            _info.addEventListener("propertychange",__changeHandler);
            PlayerManager.Instance.addEventListener("VIPStateChange",__upVip);
            _info.Bag.addEventListener("update",__updateCells);
            if(_info is SelfInfo)
            {
               (_info as SelfInfo).magicStoneBag.addEventListener("update",__equipMagicStone);
            }
            if(_cardEquipView)
            {
               _cardEquipView["playerInfo"] = _info;
            }
         }
         updateView();
      }
      
      protected function __onBeadBagUpdate(param1:Event) : void
      {
         updatePersonInfo();
      }
      
      private function __changeHandler(param1:PlayerPropertyEvent) : void
      {
         updatePersonInfo();
         updateHide();
         updateIcons();
         setTexpViewProTxt();
         if(_info && _characterSprite)
         {
            _characterSprite.info = _info;
         }
      }
      
      private function __upVip(param1:Event) : void
      {
         __changeHandler(null);
      }
      
      private function __updateCells(param1:BagEvent) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1.changedSlots;
         for(_loc2_ in param1.changedSlots)
         {
            if(_loc2_ <= 30 && _loc2_ != 20)
            {
               _cells[_loc2_].info = _info.Bag.getItemAt(_loc2_);
            }
            if(GemstoneManager.Instance.getByPlayerInfoList(_loc2_,_info.ID))
            {
               if(_cells[_loc2_].info)
               {
                  (_cells[_loc2_].info as InventoryItemInfo).gemstoneList = GemstoneManager.Instance.getByPlayerInfoList(_loc2_,_info.ID);
               }
            }
         }
         updateCells();
      }
      
      private function __equipMagicStone(param1:BagEvent) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1.changedSlots;
         for(_loc2_ in param1.changedSlots)
         {
            if(_loc2_ <= 30)
            {
               updateCells();
               break;
            }
         }
      }
      
      private function __cellClickHandler(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         if(_showSelfOperation)
         {
            _loc2_ = param1.data as PersonalInfoCell;
            _loc2_.dragStart();
         }
      }
      
      private function __cellDoubleClickHandler(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_info && _info.ID != PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_showSelfOperation)
         {
            _loc2_ = param1.data as PersonalInfoCell;
            if(_loc2_ && _loc2_.info)
            {
               _loc3_ = _loc2_.info as InventoryItemInfo;
               SocketManager.Instance.out.sendMoveGoods(0,_loc3_.Place,0,-1,_loc3_.Count);
            }
         }
      }
      
      private function updateView(param1:Boolean = false) : void
      {
         if(param1)
         {
            updatePersonInfo();
            updateCharacter();
            return;
         }
         updateCharacter();
         updateCells();
         updatePersonInfo();
         updateHide();
         updateIcons();
         updateShowOperation();
         addArmShellBtn();
      }
      
      private function updateHide() : void
      {
         if(_info)
         {
            _hideGlassBtn.selected = _info.getGlassHide();
            _hideHatBtn.selected = _info.getHatHide();
            _hideSuitBtn.selected = _info.getSuitesHide();
            _hideWingBtn.selected = _info.wingHide;
         }
      }
      
      private function updateCharacter() : void
      {
         if(_info)
         {
            if(_character)
            {
               _character.dispose();
               _character = null;
            }
            _character = CharactoryFactory.createCharacter(_info,"room") as RoomCharacter;
            _character.showGun = false;
            _character.show(false,-1);
            _character.x = 267;
            _character.y = 108;
            _showEquip.addChildAt(_character,0);
            if(!_characterSprite)
            {
               _characterSprite = new TexpInfoTipArea();
               _characterSprite.x = _character.x;
               _characterSprite.y = _character.y;
               _characterSprite.scaleX = -1;
               _showEquip.addChildAt(_characterSprite,0);
            }
            _characterSprite.info = _info;
         }
         else
         {
            _character.dispose();
            _character = null;
            ObjectUtils.disposeObject(_characterSprite);
            _characterSprite = null;
         }
      }
      
      private function updateCells() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = _cells;
         for each(var _loc3_ in _cells)
         {
            if(_info)
            {
               _loc2_ = _info.Bag.getItemAt(_loc3_.place);
               _loc3_.info = _loc2_;
               if(_loc2_)
               {
                  _loc2_.gemstoneList = GemstoneManager.Instance.getByPlayerInfoList(_loc3_.place,_info.ID);
                  if(_info == PlayerManager.Instance.Self)
                  {
                     _loc1_ = PlayerManager.Instance.Self.magicStoneBag.getItemAt(_loc3_.place);
                     if(!_loc1_)
                     {
                        _loc2_.magicStoneAttr = null;
                     }
                     else
                     {
                        _loc4_ = new MagicStoneInfo();
                        _loc4_.templateId = _loc1_.TemplateID;
                        _loc4_.level = _loc1_.StrengthenLevel;
                        _loc4_.attack = _loc1_.AttackCompose;
                        _loc4_.defence = _loc1_.DefendCompose;
                        _loc4_.agility = _loc1_.AgilityCompose;
                        _loc4_.luck = _loc1_.LuckCompose;
                        _loc4_.magicAttack = _loc1_.MagicAttack;
                        _loc4_.magicDefence = _loc1_.MagicDefence;
                        _loc2_.magicStoneAttr = _loc4_;
                        _loc2_.RingExp = _info.RingExp;
                     }
                  }
               }
               continue;
            }
            break;
         }
         if(PlayerManager.Instance.Self.Bag.items[12])
         {
            if(!_openNecklacePtetrochemicalView.parent)
            {
               addChild(_openNecklacePtetrochemicalView);
            }
         }
         else if(_openNecklacePtetrochemicalView.parent)
         {
            _openNecklacePtetrochemicalView.parent.removeChild(_openNecklacePtetrochemicalView);
         }
         showHideSmallBtn();
      }
      
      private function getList(param1:int) : Vector.<GemstListInfo>
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(PlayerManager.Instance.gemstoneInfoList[_loc2_])
            {
               if(param1 == PlayerManager.Instance.gemstoneInfoList[_loc2_].equipPlace)
               {
                  return PlayerManager.Instance.gemstoneInfoList[_loc2_].list;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      public function allowLvIconClick() : void
      {
         if(_levelIcon && _info.isSelf)
         {
            _levelIcon.allowClick();
         }
      }
      
      private function updateIcons() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         if(_info)
         {
            if(_levelIcon == null)
            {
               _levelIcon = ComponentFactory.Instance.creatCustomObject("asset.bagAndInfo.levelIcon");
               if(_info.IsVIP)
               {
                  _levelIcon.x = _levelIcon.x + 1;
               }
            }
            _levelIcon.setSize(0);
            _loc2_ = 1;
            if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "fightLabGameView")
            {
               _loc3_ = getDefinitionByName("gameCommon.GameControl");
               if(_loc3_)
               {
                  _loc2_ = _loc3_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID) == null?-1:_loc3_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID).team;
               }
            }
            _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false,_loc2_);
            _showEquip.addChild(_levelIcon);
            if(_info.SpouseID > 0)
            {
               if(_marriedIcon == null)
               {
                  _marriedIcon = ComponentFactory.Instance.creatCustomObject("asset.bagAndInfo.MarriedIcon");
               }
               _marriedIcon.tipData = {
                  "nickName":_info.SpouseName,
                  "gender":_info.Sex
               };
               _iconContainer.addChild(_marriedIcon);
            }
            else if(_marriedIcon)
            {
               _marriedIcon.dispose();
               _marriedIcon = null;
            }
            if(_info.Grade >= GuardCoreManager.instance.guardCoreMinLevel)
            {
               if(_guardCore == null)
               {
                  _guardCore = ComponentFactory.Instance.creatComponentByStylename("core.guardCoreIcon");
                  _guardCore.setup(_info,_showSelfOperation);
                  _iconContainer.addChild(_guardCore);
               }
               else
               {
                  if(_iconContainer.contains(_guardCore))
                  {
                     _iconContainer.removeChild(_guardCore);
                  }
                  _iconContainer.addChild(_guardCore);
               }
            }
            if(_fineSuitIcon)
            {
               _fineSuitIcon.tipData = _info.fineSuitExp;
               _loc5_ = FineSuitManager.Instance.getSuitVoByExp(_info.fineSuitExp);
               _loc4_ = _loc5_.level / 14;
               _fineSuitIcon.setFrame(Math.min(_loc4_ + 1,5));
            }
            if(_explorerIcon && PlayerManager.Instance.Self.Grade >= 32)
            {
               _explorerIcon.visible = true;
               _explorerIcon.tipData = _info.manualProInfo;
               _loc1_ = _info.manualProInfo.manual_Level;
               _explorerIcon.setFrame(Math.min(int((_loc1_ - 1) / 5) + 1,4));
            }
            else
            {
               _explorerIcon.visible = false;
            }
            if(_info.Grade >= 26)
            {
               if(_info.teamID == 0 && _info.teamScore == 0)
               {
                  _teamIcon.setFrame(1);
               }
               else
               {
                  _teamIcon.setFrame(_info.teamDivision + 2);
               }
               _teamIcon.visible = true;
            }
            else
            {
               _teamIcon.visible = false;
            }
            _teamIcon.tipData = _info;
            var _loc6_:* = _info.isSelf && _showSelfOperation;
            _teamIcon.buttonMode = _loc6_;
            _explorerIcon.buttonMode = _loc6_;
         }
         else
         {
            if(_levelIcon)
            {
               _levelIcon.dispose();
               _levelIcon = null;
            }
            if(_marriedIcon)
            {
               _marriedIcon.dispose();
               _marriedIcon = null;
            }
         }
      }
      
      private function checkDDTKingGradeGuide() : void
      {
         if(PlayerManager.Instance.Self.isNewOnceFinish(160))
         {
         }
      }
      
      private function updatePersonInfo() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         if(_info == null)
         {
            return;
         }
         if(PlayerInfoViewControl._isBattle)
         {
            _attackTxt.htmlText = getHtmlTextByString(String(_info.Attack <= 0?"":_info.Attack),0);
            _defenceTxt.htmlText = getHtmlTextByString(String(_info.Defence <= 0?"":_info.Defence),0);
            _agilityTxt.htmlText = getHtmlTextByString(String(_info.Agility <= 0?"":_info.Agility),0);
            _luckTxt.htmlText = getHtmlTextByString(String(_info.Luck <= 0?"":_info.Luck),0);
            _magicAttackTxt.htmlText = getHtmlTextByString(String(_info.MagicAttack <= 0?"":_info.MagicAttack),0);
            _magicDefenceTxt.htmlText = getHtmlTextByString(String(_info.MagicDefence <= 0?"":_info.MagicDefence),0);
            _damageTxt.htmlText = getHtmlTextByString(String(_info.Damage),1);
            _armorTxt.htmlText = getHtmlTextByString(String(_info.Guard),1);
            _HPText.htmlText = getHtmlTextByString(String(_info.Blood),1);
            _vitality.htmlText = getHtmlTextByString(String(_info.Energy),1);
            return;
         }
         __onUpdatePlayerProperty(null);
         _reputeField.text = _info == null?"":_info.Repute.toString();
         _gesteField.text = _info == null?"":_info.Offer.toString();
         _dutyField.text = _info.DutyName == null || _info.DutyName == ""?"":_info.ConsortiaID > 0?"< " + _info.DutyName + " >":"";
         _honorNameTxt.text = _info.honor == null?"":_info.honor;
         _nickNameTxt.text = _info.NickName == null?"":_info.NickName;
         if(_info.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(114,_info.typeVIP);
            _vipName.x = _nickNameTxt.x;
            _vipName.y = _nickNameTxt.y;
            _vipName.text = _nickNameTxt.text;
            _vipName.visible = _isVisible;
            addChild(_vipName);
            DisplayUtils.removeDisplay(_nickNameTxt);
         }
         else
         {
            addChild(_nickNameTxt);
            DisplayUtils.removeDisplay(_vipName);
         }
         _consortiaTxt.text = _info.ConsortiaName == null?"":_info.ConsortiaID > 0?_info.ConsortiaName:"";
         _dutyField.x = _consortiaTxt.x + _consortiaTxt.width + 6;
         if(_dutyField.x + _dutyField.width > 267)
         {
            _dutyField.autoSize = "none";
            _dutyField.isAutoFitLength = true;
            _loc3_ = 260 - _dutyField.x;
            _dutyField.width = _loc3_;
         }
         if(_info.ID == PlayerManager.Instance.Self.ID)
         {
            _gesteField.visible = true;
            _gongxunbg.visible = true;
            _bg2.visible = _showSelfOperation;
         }
         else
         {
            _storeBtn.visible = true;
            _storeBtn.enable = false;
            _gesteField.visible = false;
            _gongxunbg.visible = false;
            _bg2.visible = false;
         }
         if(_info.ConsortiaID > 0 && _dutyField.x + _dutyField.width > _offerSourcePosition.x)
         {
            _offerLabel.x = _dutyField.x + _dutyField.width;
         }
         else
         {
            _offerLabel.x = _offerSourcePosition.x + 32;
         }
         PowerUpMovieManager.isInPlayerInfoView = true;
         if(_info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            _attackTxt.htmlText = getHtmlTextByString(String(_info.Attack <= 0?"":_info.Attack),0);
            _defenceTxt.htmlText = getHtmlTextByString(String(_info.Defence <= 0?"":_info.Defence),0);
            _agilityTxt.htmlText = getHtmlTextByString(String(_info.Agility <= 0?"":_info.Agility),0);
            _luckTxt.htmlText = getHtmlTextByString(String(_info.Luck <= 0?"":_info.Luck),0);
            _magicAttackTxt.htmlText = getHtmlTextByString(String(_info.MagicAttack <= 0?"":_info.MagicAttack),0);
            _magicDefenceTxt.htmlText = getHtmlTextByString(String(_info.MagicDefence <= 0?"":_info.MagicDefence),0);
            _damageTxt.htmlText = getHtmlTextByString(String(Math.round(StaticFormula.getDamage(_info)) <= 0?"":Math.round(StaticFormula.getDamage(_info))),1);
            _armorTxt.htmlText = getHtmlTextByString(String(StaticFormula.getRecovery(_info) <= 0?"":StaticFormula.getRecovery(_info)),1);
            _HPText.htmlText = getHtmlTextByString(String(StaticFormula.getMaxHp(_info)),1);
            _vitality.htmlText = getHtmlTextByString(String(StaticFormula.getEnergy(_info) <= 0?"":StaticFormula.getEnergy(_info)),1);
            if(_info.isSelf)
            {
               _battle.htmlText = getHtmlTextByString(String(_info.FightPower),2);
            }
            else if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "fightLabGameView")
            {
               _loc2_ = getDefinitionByName("gameCommon.GameControl");
               if(_loc2_)
               {
                  if(_loc2_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID) != null && _loc2_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID).team == _loc2_.Instance.Current.selfGamePlayer.team)
                  {
                     _battle.htmlText = getHtmlTextByString(_info == null?"":_info.FightPower.toString(),2);
                  }
                  else
                  {
                     _battle.htmlText = "";
                  }
               }
            }
            else
            {
               _battle.htmlText = getHtmlTextByString(_info == null?"":_info.FightPower.toString(),2);
            }
         }
         else
         {
            if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "fightLabGameView")
            {
               if(RoomManager.Instance.current.selfRoomPlayer.playerInfo.ID == _info.ID)
               {
                  _battle.htmlText = getHtmlTextByString(_info == null?"":_info.FightPower.toString(),2);
               }
               else
               {
                  _loc2_ = getDefinitionByName("gameCommon.GameControl");
                  if(_loc2_)
                  {
                     if(_loc2_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID) != null && _loc2_.Instance.Current.findLivingByPlayerID(_info.ID,_info.ZoneID).team == _loc2_.Instance.Current.selfGamePlayer.team)
                     {
                        _battle.htmlText = getHtmlTextByString(_info == null?"":_info.FightPower.toString(),2);
                     }
                     else
                     {
                        _battle.htmlText = "";
                     }
                  }
               }
            }
            else
            {
               _battle.htmlText = getHtmlTextByString(_info == null?"":_info.FightPower.toString(),2);
            }
            _attackTxt.htmlText = _info == null?"":getHtmlTextByString(String(_info.Attack < 0?0:_info.Attack),0);
            _agilityTxt.htmlText = _info == null?"":getHtmlTextByString(String(_info.Agility < 0?0:_info.Agility),0);
            _defenceTxt.htmlText = _info == null?"":getHtmlTextByString(String(_info.Defence < 0?0:_info.Defence),0);
            _luckTxt.htmlText = _info == null?"":getHtmlTextByString(String(_info.Luck < 0?0:_info.Luck),0);
            _magicAttackTxt.htmlText = getHtmlTextByString(String(_info.MagicAttack <= 0?0:_info.MagicAttack),0);
            _magicDefenceTxt.htmlText = getHtmlTextByString(String(_info.MagicDefence <= 0?0:_info.MagicDefence),0);
            _damageTxt.htmlText = _info == null?"":getHtmlTextByString(String(Math.round(StaticFormula.getDamage(_info))),1);
            _armorTxt.htmlText = _info == null?"":getHtmlTextByString(String(StaticFormula.getRecovery(_info)),1);
            _HPText.htmlText = _info == null?"":getHtmlTextByString(String(StaticFormula.getMaxHp(_info)),1);
            _vitality.htmlText = _info == null?"":getHtmlTextByString(String(StaticFormula.getEnergy(_info)),1);
         }
         if(_info)
         {
            _progressLevel.setProgress(Experience.getExpPercent(_info.Grade,_info.GP) * 100,100);
            _loc1_ = Experience.expericence[_info.Grade] - Experience.expericence[_info.Grade - 1];
            _loc4_ = _info.GP - Experience.expericence[_info.Grade - 1];
            if(_info.Grade < Experience.expericence.length)
            {
               _loc4_ = _loc4_ > _loc1_?_loc1_:int(_loc4_);
            }
            if((StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d") && _info.ZoneID != 0 && _info.ZoneID != PlayerManager.Instance.Self.ZoneID)
            {
               _progressLevel.tipData = "0/" + _loc1_;
            }
            else if(_loc4_ > 0 && _info.Grade < Experience.expericence.length)
            {
               _progressLevel.tipData = _loc4_ + "/" + _loc1_;
            }
            else if(_info.Grade == Experience.expericence.length)
            {
               _progressLevel.tipData = _loc4_ + "/0";
            }
            else
            {
               _progressLevel.tipData = "0/" + _loc1_;
            }
         }
         if(_info && _info.ID == PlayerManager.Instance.Self.ID)
         {
            _definitionGroupChange();
         }
         _attestBtn.visible = _info.isAttest;
      }
      
      private function setTexpViewProTxt() : void
      {
         var _loc4_:DictionaryData = _info.getPropertyAdditionByType("Attack");
         var _loc3_:DictionaryData = _info.getPropertyAdditionByType("Defence");
         var _loc1_:DictionaryData = _info.getPropertyAdditionByType("Agility");
         var _loc2_:DictionaryData = _info.getPropertyAdditionByType("Luck");
         if(!_loc1_)
         {
            return;
         }
         _attackTxt1.htmlText = _info == null?"":getHtmlTextByString(String(_loc4_["Card"] < 0?0:_loc4_["Card"]),0);
         _agilityTxt1.htmlText = _info == null?"":getHtmlTextByString(String(_loc1_["Card"] < 0?0:_loc1_["Card"]),0);
         _defenceTxt1.htmlText = _info == null?"":getHtmlTextByString(String(_loc3_["Card"] < 0?0:_loc3_["Card"]),0);
         _luckTxt1.htmlText = _info == null?"":getHtmlTextByString(String(_loc2_["Card"] < 0?0:_loc2_["Card"]),0);
      }
      
      private function getHtmlTextByString(param1:String, param2:int) : String
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         switch(int(param2))
         {
            case 0:
               _loc4_ = "<TEXTFORMAT LEADING=\'-1\'><P ALIGN=\'CENTER\'><FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FFF6C9\' ><B>";
               _loc3_ = "</B></FONT></P></TEXTFORMAT>";
               break;
            case 1:
               _loc4_ = "<TEXTFORMAT LEADING=\'-1\'><P ALIGN=\'CENTER\'><FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FFF6C9\' LETTERSPACING=\'0\' KERNING=\'1\'><B>";
               _loc3_ = "</B></FONT></P></TEXTFORMAT>";
               break;
            case 2:
               _loc4_ = "<TEXTFORMAT LEADING=\'-1\'><P ALIGN=\'CENTER\'><FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FFF6C9\' LETTERSPACING=\'0\' KERNING=\'1\'><B>";
               _loc3_ = "</B></FONT></P></TEXTFORMAT>";
         }
         return _loc4_ + param1 + _loc3_;
      }
      
      public function dispose() : void
      {
         PowerUpMovieManager.isInPlayerInfoView = false;
         removeEvent();
         clearCells();
         if(parent)
         {
            parent.removeChild(this);
         }
         removeArmShellBtn();
         ObjectUtils.disposeObject(_attackTxt);
         _attackTxt = null;
         ObjectUtils.disposeObject(_agilityTxt);
         _agilityTxt = null;
         ObjectUtils.disposeObject(_defenceTxt);
         _defenceTxt = null;
         ObjectUtils.disposeObject(_luckTxt);
         _luckTxt = null;
         ObjectUtils.disposeObject(_magicAttackTxt);
         _magicAttackTxt = null;
         ObjectUtils.disposeObject(_magicDefenceTxt);
         _magicDefenceTxt = null;
         ObjectUtils.disposeObject(_damageTxt);
         _damageTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_HPText);
         _HPText = null;
         ObjectUtils.disposeObject(_vitality);
         _vitality = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_guardCore);
         _guardCore = null;
         ObjectUtils.disposeObject(_iconContainer);
         _iconContainer = null;
         _marriedIcon = null;
         if(_attackButton)
         {
            ShowTipManager.Instance.removeTip(_attackButton);
            ObjectUtils.disposeObject(_attackButton);
            _attackButton = null;
         }
         if(_agilityButton)
         {
            ShowTipManager.Instance.removeTip(_agilityButton);
            ObjectUtils.disposeObject(_agilityButton);
            _agilityButton = null;
         }
         if(_defenceButton)
         {
            ShowTipManager.Instance.removeTip(_defenceButton);
            ObjectUtils.disposeObject(_defenceButton);
            _defenceButton = null;
         }
         if(_luckButton)
         {
            ShowTipManager.Instance.removeTip(_luckButton);
            ObjectUtils.disposeObject(_luckButton);
            _luckButton = null;
         }
         if(_magicAttackButton)
         {
            ShowTipManager.Instance.removeTip(_magicAttackButton);
            ObjectUtils.disposeObject(_magicAttackButton);
            _magicAttackButton = null;
         }
         if(_magicDefenceButton)
         {
            ShowTipManager.Instance.removeTip(_magicDefenceButton);
            ObjectUtils.disposeObject(_magicDefenceButton);
            _magicDefenceButton = null;
         }
         if(_damageButton)
         {
            ShowTipManager.Instance.removeTip(_damageButton);
            ObjectUtils.disposeObject(_damageButton);
            _damageButton = null;
         }
         if(_armorButton)
         {
            ShowTipManager.Instance.removeTip(_armorButton);
            ObjectUtils.disposeObject(_armorButton);
            _armorButton = null;
         }
         if(_hpButton)
         {
            ShowTipManager.Instance.removeTip(_hpButton);
            ObjectUtils.disposeObject(_hpButton);
            _hpButton = null;
         }
         if(_vitalityBuntton)
         {
            ShowTipManager.Instance.removeTip(_vitalityBuntton);
            ObjectUtils.disposeObject(_vitalityBuntton);
            _vitalityBuntton = null;
         }
         ObjectUtils.disposeObject(_fineSuitIcon);
         _fineSuitIcon = null;
         ObjectUtils.disposeObject(_explorerIcon);
         _explorerIcon = null;
         ObjectUtils.disposeObject(_teamIcon);
         _teamIcon = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_showEquip);
         ObjectUtils.disposeObject(_textBg);
         _textBg = null;
         ObjectUtils.disposeObject(_textBg1);
         _textBg1 = null;
         ObjectUtils.disposeObject(_textBg2);
         _textBg2 = null;
         ObjectUtils.disposeObject(_textBg3);
         _textBg3 = null;
         ObjectUtils.disposeObject(_textBg4);
         _textBg4 = null;
         ObjectUtils.disposeObject(_textBg5);
         _textBg5 = null;
         ObjectUtils.disposeObject(_textBg6);
         _textBg6 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         _showEquip = null;
         ObjectUtils.disposeObject(_showCard);
         _showCard = null;
         ObjectUtils.disposeObject(_cardEquipView);
         _cardEquipView = null;
         CardManager.Instance.disposeView(0);
         ObjectUtils.disposeObject(_honorNameTxt);
         _honorNameTxt = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_battle);
         _battle = null;
         ObjectUtils.disposeObject(_character);
         _character = null;
         ObjectUtils.disposeObject(_characterSprite);
         _characterSprite = null;
         ObjectUtils.disposeObject(_progressLevel);
         _progressLevel = null;
         ObjectUtils.disposeObject(_reputeField);
         _reputeField = null;
         ObjectUtils.disposeObject(_gesteField);
         _gesteField = null;
         ObjectUtils.disposeObject(_dutyField);
         _dutyField = null;
         ObjectUtils.disposeObject(_levelIcon);
         _levelIcon = null;
         ObjectUtils.disposeObject(_hideGlassBtn);
         _hideGlassBtn = null;
         ObjectUtils.disposeObject(_hideHatBtn);
         _hideHatBtn = null;
         ObjectUtils.disposeObject(_hideSuitBtn);
         _hideSuitBtn = null;
         ObjectUtils.disposeObject(_hideWingBtn);
         _hideWingBtn = null;
         ObjectUtils.disposeObject(_storeBtn);
         _storeBtn = null;
         ObjectUtils.disposeObject(_addFriendBtn);
         _addFriendBtn = null;
         ObjectUtils.disposeObject(_buyAvatar);
         _buyAvatar = null;
         ObjectUtils.disposeObject(_bagDefinitionBtnI);
         _bagDefinitionBtnI = null;
         ObjectUtils.disposeObject(_bagDefinitionGroup);
         _bagDefinitionGroup = null;
         ObjectUtils.disposeObject(_bagDefinitionBtnII);
         _bagDefinitionBtnII = null;
         ObjectUtils.disposeObject(_playerInfoEffortHonorView);
         _playerInfoEffortHonorView = null;
         ObjectUtils.disposeObject(_cellContent);
         _cellContent = null;
         ObjectUtils.disposeObject(_offerLabel);
         _offerLabel = null;
         ObjectUtils.disposeObject(_attestBtn);
         _attestBtn = null;
         ObjectUtils.disposeObject(_dragDropArea);
         _dragDropArea = null;
         ObjectUtils.disposeObject(_openNecklacePtetrochemicalView);
         _openNecklacePtetrochemicalView = null;
         ObjectUtils.disposeObject(_ringSystemBtn);
         _ringSystemBtn = null;
         ObjectUtils.disposeObject(_trailEliteBtn);
         _trailEliteBtn = null;
         ObjectUtils.disposeObject(_amuletBtn);
         _amuletBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _info = null;
         _energyData = null;
      }
      
      public function startShine(param1:ItemTemplateInfo) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1.NeedSex == 0 || param1.NeedSex == (!!PlayerManager.Instance.Self.Sex?1:2))
         {
            _loc2_ = getCellIndex(param1).split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(int(_loc2_[_loc3_]) >= 0)
               {
                  (_cells[int(_loc2_[_loc3_])] as PersonalInfoCell).shine();
               }
               _loc3_++;
            }
         }
      }
      
      public function stopShine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            (_loc1_ as PersonalInfoCell).stopShine();
         }
         if(_cardEquipView)
         {
            _cardEquipView["stopShine"]();
         }
      }
      
      private function getCellIndex(param1:ItemTemplateInfo) : String
      {
         if(EquipType.isWeddingRing(param1))
         {
            return "9,10,16";
         }
         var _loc2_:* = param1.CategoryID;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(5 !== _loc2_)
                     {
                        if(6 !== _loc2_)
                        {
                           if(7 !== _loc2_)
                           {
                              if(8 !== _loc2_)
                              {
                                 if(28 !== _loc2_)
                                 {
                                    if(9 !== _loc2_)
                                    {
                                       if(29 !== _loc2_)
                                       {
                                          if(13 !== _loc2_)
                                          {
                                             if(14 !== _loc2_)
                                             {
                                                if(15 !== _loc2_)
                                                {
                                                   if(16 !== _loc2_)
                                                   {
                                                      if(17 !== _loc2_)
                                                      {
                                                         if(19 !== _loc2_)
                                                         {
                                                            if(70 !== _loc2_)
                                                            {
                                                               if(27 !== _loc2_)
                                                               {
                                                                  if(40 !== _loc2_)
                                                                  {
                                                                     return "-1";
                                                                  }
                                                                  return "17";
                                                               }
                                                               return "6";
                                                            }
                                                         }
                                                         return "18";
                                                      }
                                                      return "15";
                                                   }
                                                   return "14";
                                                }
                                                return "13";
                                             }
                                             return "12";
                                          }
                                          return "11";
                                       }
                                    }
                                    return "9,10";
                                 }
                              }
                              return "7,8";
                           }
                           return "6";
                        }
                        return "5";
                     }
                     return "4";
                  }
                  return "3";
               }
               return "2";
            }
            return "1";
         }
         return "0";
      }
      
      public function get showSelfOperation() : Boolean
      {
         return _showSelfOperation;
      }
      
      public function set showSelfOperation(param1:Boolean) : void
      {
         _showSelfOperation = param1;
         updateShowOperation();
      }
      
      private function updateShowOperation() : void
      {
         _honorNameTxt.visible = !showSelfOperation;
         _playerInfoEffortHonorView.visible = showSelfOperation;
         _storeBtn.visible = true;
         _storeBtn.enable = _showSelfOperation;
         _buyAvatar.visible = !_showSelfOperation && _info != null && (_info.ZoneID == 0 || _info.ZoneID == PlayerManager.Instance.Self.ZoneID) && PlayerManager.Instance.Self.Grade > 2 && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fighting3d" && StateManager.currentStateType != "fightLabGameView" && StateManager.currentStateType != "trainer1" && StateManager.currentStateType != "trainer2" && StateManager.currentStateType != "hotSpringRoom" && StateManager.currentStateType != "churchRoom" && StateManager.currentStateType != "littleGame" && StateManager.currentStateType != "roomLoading";
         if(_info is SelfInfo)
         {
            _buyAvatar.visible = false;
         }
         else if(_info)
         {
            createVipAndKing();
         }
         var _loc1_:* = _showSelfOperation;
         _hideWingBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _hideSuitBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _hideHatBtn.visible = _loc1_;
         _hideGlassBtn.visible = _loc1_;
         _addFriendBtn.visible = !_showSelfOperation && _info != null && _info.ID != PlayerManager.Instance.Self.ID && (_info.ZoneID == 0 || _info.ZoneID == PlayerManager.Instance.Self.ZoneID);
         _loc1_ = _showSelfOperation && _showEquip.visible;
         _amuletBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _ringSystemBtn.visible = _loc1_;
         _openNecklacePtetrochemicalView.visible = _loc1_;
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "fightLabGameView")
         {
            if(_openNecklacePtetrochemicalView.parent)
            {
               _openNecklacePtetrochemicalView.parent.removeChild(_openNecklacePtetrochemicalView);
            }
            if(_ringSystemBtn.parent)
            {
               _ringSystemBtn.parent.removeChild(_ringSystemBtn);
            }
            if(_amuletBtn.parent)
            {
               _amuletBtn.parent.removeChild(_amuletBtn);
            }
         }
         else
         {
            if(!_openNecklacePtetrochemicalView.parent && PlayerManager.Instance.Self.Bag.items[12])
            {
               addChild(_openNecklacePtetrochemicalView);
            }
            if(!_ringSystemBtn.parent && PlayerManager.Instance.Self.Bag.items[16])
            {
               addChild(_ringSystemBtn);
            }
            if(!_amuletBtn.parent && PlayerManager.Instance.Self.Bag.items[18])
            {
               addChild(_amuletBtn);
            }
         }
         if(!_info || _info.ID != PlayerManager.Instance.Self.ID || !_showSelfOperation)
         {
            _bagDefinitionBtnI.visible = false;
            _bagDefinitionBtnII.visible = false;
            return;
         }
         _bagDefinitionBtnI.visible = true;
         _bagDefinitionBtnII.visible = true;
         if(_info)
         {
            if(_info.IsShowConsortia && _info.ConsortiaName)
            {
               _bagDefinitionGroup.selectIndex = 1;
            }
            else if(!_info.IsShowConsortia && EffortManager.Instance.getHonorArray().length > 0)
            {
               _bagDefinitionGroup.selectIndex = 0;
            }
            else if(!_info.IsShowConsortia && _info.ConsortiaName)
            {
               _bagDefinitionGroup.selectIndex = 1;
            }
            else if(_info.IsShowConsortia && EffortManager.Instance.getHonorArray().length > 0)
            {
               _bagDefinitionGroup.selectIndex = 0;
            }
            else
            {
               _bagDefinitionBtnI.visible = false;
               _bagDefinitionBtnII.visible = false;
            }
         }
      }
      
      private function createVipAndKing() : void
      {
         if(_info.IsVIP)
         {
            if(_vipIcon == null)
            {
               _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.bagAndInfo.VipIcon");
               _iconContainer.addChild(_vipIcon);
            }
            _vipIcon.setInfo(_info);
            if(!_info.IsVIP)
            {
               _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               _vipIcon.filters = null;
            }
         }
         else if(_vipIcon)
         {
            _vipIcon.dispose();
            _vipIcon = null;
         }
         if(_marriedIcon)
         {
            if(_iconContainer.contains(_marriedIcon))
            {
               _iconContainer.removeChild(_marriedIcon);
               _iconContainer.addChild(_marriedIcon);
            }
         }
         if(_guardCore)
         {
            if(_iconContainer.contains(_guardCore))
            {
               _iconContainer.removeChild(_guardCore);
               _iconContainer.addChild(_guardCore);
            }
         }
      }
      
      private function getShowAcademyIcon() : Boolean
      {
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "fightLabGameView")
         {
            if(_info.apprenticeshipState != 0)
            {
               return true;
            }
            return false;
         }
         if(_info.ID == PlayerManager.Instance.Self.ID)
         {
            return true;
         }
         if(_info.apprenticeshipState != 0)
         {
            return true;
         }
         return false;
      }
      
      public function setAchvEnable(param1:Boolean) : void
      {
         _achvEnable = param1;
         updateShowOperation();
      }
      
      private function _definitionGroupChange(param1:Event = null) : void
      {
         if(param1 != null)
         {
            SoundManager.instance.play("008");
         }
         var _loc2_:Array = EffortManager.Instance.getHonorArray();
         if(_loc2_.length < 1 && !_info.ConsortiaName)
         {
            _bagDefinitionBtnI.visible = false;
            _bagDefinitionBtnII.visible = false;
            return;
         }
         if(_bagDefinitionGroup.selectIndex == 0)
         {
            if(_loc2_.length < 1)
            {
               if(param1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagInfo.notDesignation"));
               }
               _bagDefinitionGroup.selectIndex = 1;
            }
            else if(param1)
            {
               PlayerManager.Instance.Self.IsShowConsortia = false;
               SocketManager.Instance.dispatchEvent(new NewHallEvent("newhallupdatetitle"));
            }
         }
         else if(!_info.ConsortiaName)
         {
            if(param1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagInfo.notSociaty"));
            }
            _bagDefinitionGroup.selectIndex = 0;
         }
         else if(param1)
         {
            PlayerManager.Instance.Self.IsShowConsortia = true;
            SocketManager.Instance.dispatchEvent(new NewHallEvent("newhallupdatetitle"));
         }
         if(param1)
         {
            SocketManager.Instance.out.sendChangeDesignation(PlayerManager.Instance.Self.IsShowConsortia);
         }
      }
      
      public function get openNecklacePtetrochemicalView() : SimpleBitmapButton
      {
         return _openNecklacePtetrochemicalView;
      }
      
      public function set openNecklacePtetrochemicalView(param1:SimpleBitmapButton) : void
      {
         _openNecklacePtetrochemicalView = param1;
      }
   }
}
