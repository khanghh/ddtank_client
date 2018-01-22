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
      
      public function LuckyCard(param1:int, param2:int, param3:int = 0)
      {
         super();
         _idx = param1;
         _cardType = param2;
         _luckCardBuffType = param3;
         init();
      }
      
      private function init() : void
      {
         buttonMode = true;
         _overShape = new Sprite();
         _overShape.graphics.lineStyle(1.8,16777215);
         _overShape.graphics.drawRoundRect(4,2,100,148,15,15);
         _overEffect = ComponentFactory.Instance.model.getSet("takeoutCard.LuckyCardOverFilter");
         _overShape.filters = [_overEffect];
         _luckyCardMc = ComponentFactory.Instance.creat("asset.takeoutCard.LuckyCard");
         _luckyCardMc.addEventListener("enterFrame",__checkMovie);
         addChild(_luckyCardMc);
      }
      
      private function __checkMovie(param1:Event) : void
      {
         if(_luckyCardMc.numChildren == 6)
         {
            if(_luckyCardMc.cardMc.totalFrames == 5)
            {
               _luckyCardMc.removeEventListener("enterFrame",__checkMovie);
               _luckyCardMc.cardMc.addFrameScript(_luckyCardMc.cardMc.totalFrames - 1,showResult);
            }
         }
      }
      
      public function set enabled(param1:Boolean) : void
      {
         buttonMode = param1;
         if(param1)
         {
            _overEffectPoint = new Point(y,y - 14);
            addEventListener("click",__onClick);
            addEventListener("rollOver",__onRollOver);
            addEventListener("rollOut",__onRollOut);
         }
         else
         {
            removeEventListener("click",__onClick);
            removeEventListener("rollOver",__onRollOver);
            removeEventListener("rollOut",__onRollOut);
            __onRollOut();
         }
      }
      
      private function __onRollOver(param1:MouseEvent = null) : void
      {
         if(!_overEffectPoint)
         {
            return;
         }
         addChild(_overShape);
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.3,{
            "y":_overEffectPoint.y,
            "ease":Quint.easeOut
         });
      }
      
      private function __onRollOut(param1:MouseEvent = null) : void
      {
         if(!_overEffectPoint)
         {
            return;
         }
         if(contains(_overShape))
         {
            removeChild(_overShape);
         }
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.3,{
            "y":_overEffectPoint.x,
            "ease":Quint.easeOut
         });
      }
      
      protected function __onClick(param1:MouseEvent) : void
      {
         if(allowClick)
         {
            SoundManager.instance.play("008");
            if(isPayed)
            {
               if(GameControl.Instance.Current.selfGamePlayer.hasGardGet)
               {
                  GameInSocketOut.sendPaymentTakeCard(_idx);
                  GameControl.Instance.Current.selfGamePlayer.hasGardGet = false;
                  enabled = false;
               }
               else
               {
                  if(new CmdCheckBagLockedPSWNeeds().excute(2) == true)
                  {
                     return;
                  }
                  payAlert();
               }
            }
            else
            {
               if(RoomManager.Instance.current.type == 10)
               {
                  GameInSocketOut.sendBossTakeOut(_idx);
               }
               else if(_cardType == 1)
               {
                  GameInSocketOut.sendBossTakeOut(_idx);
               }
               else
               {
                  GameInSocketOut.sendGameTakeOut(_idx);
               }
               enabled = false;
            }
         }
         else
         {
            MessageTipManager.getInstance().show(msg);
         }
      }
      
      private function payAlert() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = ServerConfigManager.instance.VIPTakeCardDisCount[PlayerManager.Instance.Self.VIPLevel - 1];
         var _loc2_:int = Math.floor(_loc3_ / 100 * 500);
         if(_loc3_ == 100 || _loc3_ == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.gameover.payConfirm.contentCommonNoDiscount",500);
            tPrice = 500;
         }
         else if(PlayerManager.Instance.Self.IsVIP)
         {
            tPrice = 500 - _loc2_;
            _loc1_ = LanguageMgr.GetTranslation("tank.gameover.payConfirm.contentVip",_loc2_,500 - _loc2_);
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.gameover.payConfirm.contentCommon",500,500 - Math.floor(_loc3_ / 100 * 500));
            tPrice = 500 - _loc2_;
         }
         _payAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.gameover.payConfirm.title"),_loc1_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",50,true,1);
         if(_payAlert.parent)
         {
            _payAlert.parent.removeChild(_payAlert);
         }
         LayerManager.Instance.addToLayer(_payAlert,3,true,2);
         _payAlert.addEventListener("response",onFrameResponse);
         __onRollOut();
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(_payAlert.isBand,tPrice,onCheckComplete);
         }
         else
         {
            if(_payAlert)
            {
               _payAlert.removeEventListener("response",onFrameResponse);
            }
            ObjectUtils.disposeObject(_payAlert);
            _payAlert = null;
         }
      }
      
      protected function onCheckComplete() : void
      {
         GameInSocketOut.sendPaymentTakeCard(_idx,CheckMoneyUtils.instance.isBind);
         enabled = false;
         if(_payAlert)
         {
            _payAlert.removeEventListener("response",onFrameResponse);
         }
         ObjectUtils.disposeObject(_payAlert);
         _payAlert = null;
      }
      
      public function play(param1:Player, param2:int, param3:int, param4:Boolean, param5:Boolean = false) : void
      {
         _info = param1;
         _templateID = param2;
         _count = param3;
         _isVip = param4;
         if(!param1 || !_info.isSelf)
         {
            _luckyCardMc.lightFrame.visible = false;
            _luckyCardMc.vipLightFrame.visible = false;
            _luckyCardMc.starMc.visible = false;
         }
         SoundManager.instance.play("048");
         if(param4)
         {
            openVipCard();
         }
         else
         {
            openNormalCard();
         }
         setCardLabel(!!param5?0:MapManager.Instance.curMapCardLabelType);
         enabled = false;
         if(_info)
         {
            _NickName = !!_info.playerInfo?_info.playerInfo.NickName:"";
         }
      }
      
      private function setCardLabel(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               _luckyCardMc["double"].gotoAndStop(1);
               break;
            case 1:
               _luckyCardMc["double"].gotoAndPlay(2);
         }
      }
      
      private function openNormalCard() : void
      {
         _luckyCardMc["lightFrame"].gotoAndPlay(2);
         _luckyCardMc["cardMc"].gotoAndPlay(2);
         _luckyCardMc["vipLightFrame"].gotoAndStop(1);
         _luckyCardMc["vipCardMc"].gotoAndStop(1);
         _luckyCardMc["starMc"].gotoAndPlay(2);
      }
      
      private function openVipCard() : void
      {
         _luckyCardMc["lightFrame"].gotoAndStop(1);
         _luckyCardMc["cardMc"].gotoAndPlay(2);
         _luckyCardMc["vipLightFrame"].gotoAndPlay(2);
         _luckyCardMc["vipCardMc"].gotoAndPlay(2);
         _luckyCardMc["starMc"].gotoAndPlay(2);
      }
      
      private function showResult() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         try
         {
            _luckyCardMc["cardMc"].stop();
         }
         catch(e:Error)
         {
            trace(e.message + "------------------------------------------------>");
            _loc4_ = 0;
         }
      }
      
      public function dispose() : void
      {
         if(_payAlert)
         {
            _payAlert.removeEventListener("response",onFrameResponse);
         }
         removeEventListener("click",__onClick);
         removeEventListener("rollOver",__onRollOver);
         removeEventListener("rollOut",__onRollOut);
         ObjectUtils.disposeObject(_luckyCardMc);
         _luckyCardMc = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
         ObjectUtils.disposeObject(_vipNameTxt);
         _vipNameTxt = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_itemGoldTxt);
         _itemGoldTxt = null;
         ObjectUtils.disposeObject(_itemBitmap);
         _itemBitmap = null;
         ObjectUtils.disposeObject(_goldTxt);
         _goldTxt = null;
         ObjectUtils.disposeObject(_payAlert);
         _payAlert = null;
         if(_overShape && _overShape.parent)
         {
            _overShape.parent.removeChild(_overShape);
         }
         _overShape = null;
         _overEffect = null;
         _overEffectPoint = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
