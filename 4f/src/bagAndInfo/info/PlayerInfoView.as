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
      
      public function PlayerInfoView(){super();}
      
      private function cardGuide1() : void{}
      
      private function cardGuide2(param1:DictionaryEvent) : void{}
      
      public function checkGuardCoreGuide() : void{}
      
      public function checkGuide() : void{}
      
      private function initView() : void{}
      
      protected function addArmShellBtn() : void{}
      
      protected function removeArmShellBtn() : void{}
      
      protected function __armShellBitmapBtnClickHandler(param1:MouseEvent) : void{}
      
      private function removeFromStageHandler(param1:Event) : void{}
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void{}
      
      private function createCardEquip() : void{}
      
      protected function __cardViewComplete(param1:CardSystemEvent) : void{}
      
      public function switchShow(param1:Boolean) : void{}
      
      public function cardEquipShine(param1:CardInfo) : void{}
      
      public function switchShowII(param1:Boolean) : void{}
      
      private function initProperties() : void{}
      
      private function initPos() : void{}
      
      private function initEvents() : void{}
      
      private function __onClickTeam(param1:MouseEvent) : void{}
      
      private function __openExplorerHandler(param1:MouseEvent) : void{}
      
      protected function __openRingSystemView(param1:MouseEvent) : void{}
      
      private function _openTrailEliteView(param1:MouseEvent) : void{}
      
      protected function __onRingSystemClose(param1:FrameEvent) : void{}
      
      protected function __onTrailEliteSystemClose(param1:FrameEvent) : void{}
      
      protected function __openNecklacePtetrochemicalView(param1:MouseEvent) : void{}
      
      protected function __onNecklacePtetrochemicalClose(param1:FrameEvent) : void{}
      
      private function __onClickAmulet(param1:MouseEvent) : void{}
      
      protected function __onUpdatePlayerProperty(param1:Event) : void{}
      
      private function showHideSmallBtn() : void{}
      
      private function removeEvent() : void{}
      
      private function __storeBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __addFriendClickHandler(param1:MouseEvent) : void{}
      
      private function __buyAvatarClickHandler(param1:MouseEvent) : void{}
      
      private function __hideGlassClickHandler(param1:MouseEvent) : void{}
      
      private function __hideHatClickHandler(param1:Event) : void{}
      
      private function __hideSuitClickHandler(param1:MouseEvent) : void{}
      
      private function __hideWingClickHandler(param1:MouseEvent) : void{}
      
      private function creatCells() : void{}
      
      private function clearCells() : void{}
      
      public function set info(param1:*) : void{}
      
      protected function __onBeadBagUpdate(param1:Event) : void{}
      
      private function __changeHandler(param1:PlayerPropertyEvent) : void{}
      
      private function __upVip(param1:Event) : void{}
      
      private function __updateCells(param1:BagEvent) : void{}
      
      private function __equipMagicStone(param1:BagEvent) : void{}
      
      private function __cellClickHandler(param1:CellEvent) : void{}
      
      private function __cellDoubleClickHandler(param1:CellEvent) : void{}
      
      private function updateView(param1:Boolean = false) : void{}
      
      private function updateHide() : void{}
      
      private function updateCharacter() : void{}
      
      private function updateCells() : void{}
      
      private function getList(param1:int) : Vector.<GemstListInfo>{return null;}
      
      public function allowLvIconClick() : void{}
      
      private function updateIcons() : void{}
      
      private function checkDDTKingGradeGuide() : void{}
      
      private function updatePersonInfo() : void{}
      
      private function setTexpViewProTxt() : void{}
      
      private function getHtmlTextByString(param1:String, param2:int) : String{return null;}
      
      public function dispose() : void{}
      
      public function startShine(param1:ItemTemplateInfo) : void{}
      
      public function stopShine() : void{}
      
      private function getCellIndex(param1:ItemTemplateInfo) : String{return null;}
      
      public function get showSelfOperation() : Boolean{return false;}
      
      public function set showSelfOperation(param1:Boolean) : void{}
      
      private function updateShowOperation() : void{}
      
      private function createVipAndKing() : void{}
      
      private function getShowAcademyIcon() : Boolean{return false;}
      
      public function setAchvEnable(param1:Boolean) : void{}
      
      private function _definitionGroupChange(param1:Event = null) : void{}
      
      public function get openNecklacePtetrochemicalView() : SimpleBitmapButton{return null;}
      
      public function set openNecklacePtetrochemicalView(param1:SimpleBitmapButton) : void{}
   }
}
