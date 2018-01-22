package gameCommon.view.card
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.model.BeadInfo;
   import com.greensock.TweenLite;
   import com.greensock.easing.Quint;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.cmd.CmdCheckBagLockedPSWNeeds;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   import room.RoomManager;
   import vip.VipController;
   
   public class LuckyCard extends Sprite implements Disposeable
   {
      
      public static const AFTER_GAME_CARD:int = 0;
      
      public static const WITHIN_GAME_CARD:int = 1;
      
      private static const TAKE_CARD_FEE:int = 500;
       
      
      public var allowClick:Boolean;
      
      public var msg:String;
      
      public var isPayed:Boolean;
      
      private var _idx:int;
      
      private var _cardType:int;
      
      private var _luckCardBuffType:int;
      
      private var _luckyCardMc:MovieClip;
      
      private var _info:Player;
      
      private var _templateID:int;
      
      private var _count:int;
      
      private var _isVip:Boolean;
      
      private var _nickName:FilterFrameText;
      
      private var _itemName:FilterFrameText;
      
      private var _vipNameTxt:GradientText;
      
      private var _itemCell:BagCell;
      
      private var _itemGoldTxt:Bitmap;
      
      private var _itemBitmap:Bitmap;
      
      private var _goldTxt:FilterFrameText;
      
      private var _overShape:Sprite;
      
      private var _overEffect:GlowFilter;
      
      private var _overEffectPoint:Point;
      
      private var _payAlert:BaseAlerFrame;
      
      private var _NickName:String;
      
      private var tPrice:int;
      
      public function LuckyCard(param1:int, param2:int, param3:int = 0){super();}
      
      private function init() : void{}
      
      private function __checkMovie(param1:Event) : void{}
      
      public function set enabled(param1:Boolean) : void{}
      
      private function __onRollOver(param1:MouseEvent = null) : void{}
      
      private function __onRollOut(param1:MouseEvent = null) : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      private function payAlert() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      public function play(param1:Player, param2:int, param3:int, param4:Boolean, param5:Boolean = false) : void{}
      
      private function setCardLabel(param1:int) : void{}
      
      private function openNormalCard() : void{}
      
      private function openVipCard() : void{}
      
      private function showResult() : void{}
      
      public function dispose() : void{}
   }
}
