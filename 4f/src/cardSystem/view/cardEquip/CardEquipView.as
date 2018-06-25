package cardSystem.view.cardEquip{   import baglocked.BaglockedManager;   import cardSystem.CardControl;   import cardSystem.CardManager;   import cardSystem.CardTemplateInfoManager;   import cardSystem.GrooveInfoManager;   import cardSystem.data.CardGrooveInfo;   import cardSystem.data.CardInfo;   import cardSystem.data.GrooveInfo;   import cardSystem.elements.CardCell;   import cardSystem.view.CardPropress;   import cardSystem.view.CardSelect;   import cardSystem.view.CardSmallPropress;   import com.greensock.TweenLite;   import com.greensock.easing.Quad;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyAlertBase;   import ddt.command.QuickBuyFrame;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import ddt.view.tips.OneLineTip;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import quest.TaskManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import trainer.view.NewHandContainer;      public class CardEquipView extends Sprite implements Disposeable   {                   private var _background:Bitmap;            private var _background1:ScaleBitmapImage;            private var _title:Bitmap;            public var _equipCells:Vector.<CardCell>;            private var _playerInfo:PlayerInfo;            private var _viceCardBit:Vector.<Bitmap>;            private var _mainCardBit:Bitmap;            private var _clickEnable:Boolean = true;            private var _cell3MouseSprite:Sprite;            private var _cell4MouseSprite:Sprite;            private var _open3Btn:TextButton;            private var _open4Btn:TextButton;            private var _dragArea:CardEquipDragArea;            private var _collectBtn:TextButton;            private var _resetSoulBtn:TextButton;            private var _cardBtn:TextButton;            private var _buyCardBoxBtn:TextButton;            private var _cardList:CardSelect;            private var _attackBg:Bitmap;            private var _agilityBg:Bitmap;            private var _defenceBg:Bitmap;            private var _luckBg:Bitmap;            private var _background2:MovieImage;            private var _line:MovieImage;            private var _textBg:Scale9CornerImage;            private var _textBg1:Scale9CornerImage;            private var _textBg2:Scale9CornerImage;            private var _textBg3:Scale9CornerImage;            private var _levelPorgress:CardPropress;            private var _levelPorgress1:CardSmallPropress;            private var _levelPorgress2:CardSmallPropress;            private var _levelPorgress3:CardSmallPropress;            private var _levelPorgress4:CardSmallPropress;            private var _CardGrove:GrooveInfo;            private var _HunzhiBg:Bitmap;            private var _ballPlay:MovieClip;            private var _ballPlaySp:Component;            private var _ballPlaySpTip:OneLineTip;            private var _ballPlayCountTxt:FilterFrameText;            private var _levelTxt1:FilterFrameText;            private var _levelTxt2:FilterFrameText;            private var _levelTxt3:FilterFrameText;            private var _levelTxt4:FilterFrameText;            private var _levelTxt5:FilterFrameText;            private var _levelNumTxt1:FilterFrameText;            private var _levelNumTxt2:FilterFrameText;            private var _levelNumTxt3:FilterFrameText;            private var _levelNumTxt4:FilterFrameText;            private var _levelNumTxt5:FilterFrameText;            private var _GrooveTxt:FilterFrameText;            private var _btnHelp:BaseButton;            private var _quickBuyFrame:QuickBuyFrame;            private var _achievementBtn:SimpleBitmapButton;            private var _show3:Boolean;            private var _showSelfOperation:Boolean;            private var _tipsframe:BaseAlerFrame;            private var _selectedCheckButton:SelectedCheckButton;            private var _resetAlert:BaseAlerFrame;            private var _moneyConfirm:BaseAlerFrame;            private var _openFrame:BaseAlerFrame;            private var _configFrame:BaseAlerFrame;            public function CardEquipView() { super(); }
            public function set clickEnable(value:Boolean) : void { }
            private function cardGuide() : void { }
            private function cardGuideComplete(event:DictionaryEvent) : void { }
            private function initView() : void { }
            private function setCardsVisible(bool:Boolean) : void { }
            private function __ballPlaySpMouseOver(event:MouseEvent) : void { }
            private function __ballPlaySpMouseOut(event:MouseEvent) : void { }
            private function isBallPlaySpTip() : void { }
            protected function __onUpdateProperty(event:Event) : void { }
            private function createSprite(obj:CardCell) : Sprite { return null; }
            private function removeSprite(s:Sprite, openBtn:BaseButton) : void { }
            private function __showOpenBtn(event:MouseEvent) : void { }
            private function __hideOpenBtn(event:MouseEvent) : void { }
            public function shineMain() : void { }
            public function shineVice() : void { }
            public function stopShine() : void { }
            public function set playerInfo(value:PlayerInfo) : void { }
            public function get showSelfOperation() : Boolean { return false; }
            public function set showSelfOperation(value:Boolean) : void { }
            private function checkAchievementBtn() : void { }
            public function get playerInfo() : PlayerInfo { return null; }
            private function setCellsData() : void { }
            private function setCellPos() : void { }
            private function initEvent() : void { }
            private function __ballPlaySpClickHandler(event:MouseEvent) : void { }
            private function showBuyCardSoulTips() : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function tipsDispose() : void { }
            private function __onselectedCheckButtoClick(event:MouseEvent) : void { }
            protected function __buyCardBoxHandler(event:MouseEvent) : void { }
            private function __changeSoul(event:PlayerPropertyEvent) : void { }
            private function __getSoul(event:CrazyTankSocketEvent) : void { }
            private function removeEvent() : void { }
            private function __GetCard(event:PkgEvent) : void { }
            private function __collectHandler(event:MouseEvent) : void { }
            private function __resetSoulHandler(event:MouseEvent) : void { }
            private function __resetAlertResponse(event:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            private function __moneyConfirmHandler(evt:FrameEvent) : void { }
            private function __resetAllText() : void { }
            private function __cardHandler(event:MouseEvent) : void { }
            private function _openHandler(event:MouseEvent) : void { }
            private function __openFramehandler(event:FrameEvent) : void { }
            private function openActive() : void { }
            private function __configResponseHandler(event:FrameEvent) : void { }
            private function __remove(event:DictionaryEvent) : void { }
            private function __upData(event:DictionaryEvent) : void { }
            private function __onClickAchievement(e:MouseEvent) : void { }
            public function dispose() : void { }
            protected function __clickHandler(event:Event) : void { }
            protected function __doubleClickHandler(event:Event) : void { }
            protected function _cellOverEff(event:MouseEvent) : void { }
            protected function _cellOutEff(event:MouseEvent) : void { }
   }}