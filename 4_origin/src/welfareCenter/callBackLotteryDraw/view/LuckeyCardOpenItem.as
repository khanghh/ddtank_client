package welfareCenter.callBackLotteryDraw.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawController;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   
   public class LuckeyCardOpenItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _mc:MovieClip;
      
      private var _bagCell:BagCell;
      
      private var _orglX:int;
      
      private var _orglY:int;
      
      private var _border:MovieClip;
      
      private var _borderTweenLite:TweenLite;
      
      private var _tweenLite:TweenLite;
      
      private var _isClick:Boolean = false;
      
      private var _hasFlipOver:Boolean = false;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _manager:CallBackLotteryDrawManager;
      
      private var _award:Object;
      
      private var _maskSp:Sprite;
      
      public function LuckeyCardOpenItem(index:int, orglX:int, orglY:int)
      {
         super();
         _index = index;
         _manager = CallBackLotteryDrawManager.instance;
         _award = _manager.luckeyLotteryDrawModel.awardArr[_index];
         _orglX = orglX;
         _orglY = orglY;
         _mc = ComponentFactory.Instance.creat("luckeylotterydraw.cardOpen");
         _mc.stop();
         addChild(_mc);
         this.mouseChildren = false;
         _border = ComponentFactory.Instance.creat("luckeylotterydraw.cardMouseOverBorder");
         _border.x = 4;
         _border.y = 12;
         addChild(_border);
         _border.visible = false;
         this.x = _orglX;
         this.y = _orglY;
         this.buttonMode = true;
         _maskSp = new Sprite();
         this.addEventListener("rollOver",onCardOpenMCMouseHandler);
         this.addEventListener("rollOut",onCardOpenMCMouseHandler);
         this.addEventListener("click",onCardOpenMCMouseHandler);
         CallBackLotteryDrawManager.instance.addEventListener("event_op_back_buy",onBuy);
      }
      
      private function onCardOpenMCMouseHandler(evt:MouseEvent) : void
      {
         evt = evt;
         var eventType:String = evt.type;
         if(_hasFlipOver == false)
         {
            TweenLite.killTweensOf(_border);
            TweenLite.killTweensOf(this);
            if(eventType == "click")
            {
               SoundManager.instance.playButtonSound();
               _isClick = true;
               _border.visible = false;
               this.y = _orglY;
               LayerManager.Instance.addToLayer(_maskSp,3,true,2);
               SocketManager.Instance.out.buyCallLotteryDrawGood(1,_award["Index"],false);
            }
            else if(eventType == "rollOver")
            {
               _border.visible = true;
               _borderTweenLite = TweenLite.to(_border,0.5,{"alpha":1});
               _tweenLite = TweenLite.to(this,0.5,{"y":_orglY - 5});
            }
            else if(eventType == "rollOut")
            {
               _border.visible = false;
               _borderTweenLite = TweenLite.to(_border,0.5,{"alpha":0});
               _tweenLite = TweenLite.to(this,0.5,{"y":_orglY});
            }
         }
         else if(eventType == "click")
         {
            var target:* = evt.target;
            if(target == _buyBtn)
            {
               onAlertFrameResponse = function(evt:FrameEvent):void
               {
                  if(evt.responseCode == 3 || evt.responseCode == 2)
                  {
                     CheckMoneyUtils.instance.checkMoney(_payAlert.isBand,newPrice,onCheckComplete);
                  }
                  _payAlert.removeEventListener("response",onAlertFrameResponse);
                  ObjectUtils.disposeObject(_payAlert);
               };
               onCheckComplete = function():void
               {
                  LayerManager.Instance.addToLayer(_maskSp,3,true,2);
                  SocketManager.Instance.out.buyCallLotteryDrawGood(1,_award["Index"],CheckMoneyUtils.instance.isBind);
               };
               SoundManager.instance.playButtonSound();
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               var newPrice:int = _award["Cost"] * _award["LimitCount"] / 100;
               var msg:String = LanguageMgr.GetTranslation("callbacklotterdraw.buyGoodTip",newPrice,_award["InventoryItemInfo"].Name);
               var _payAlert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",50,true,1);
               _payAlert.enterEnable = false;
               _payAlert.addEventListener("response",onAlertFrameResponse);
            }
         }
      }
      
      public function playCardOpen() : void
      {
         _hasFlipOver = true;
         _mc.play();
         _mc.addEventListener("enterFrame",onCardOpenEnterFrame);
      }
      
      private function onCardOpenEnterFrame(evt:Event) : void
      {
         var cardFont3:* = null;
         var maskPic:* = null;
         if(_mc.currentFrame == 5)
         {
            _mc.gotoAndStop(5);
            cardFont3 = CallBackLotteryDrawController.instance.getCardShowFont(_award,"luckeylotterydraw");
            cardFont3.x = -5;
            cardFont3.y = 18;
            _mc["c1"].addChild(cardFont3);
            _buyBtn = UICreatShortcut.creatAndAdd("luckeylotterydraw.buyBtn",_mc["c1"]);
            _buyBtn.visible = _award["IsCanGet"];
            if(!_award["IsCanGet"])
            {
               maskPic = UICreatShortcut.creatAndAdd("luckeylotterydraw.pic7",_mc);
               PositionUtils.setPos(maskPic,"luckeylotterydraw.hasGetMask");
            }
            _mc.play();
         }
         else if(_mc.currentFrame == _mc.totalFrames)
         {
            _mc.removeEventListener("enterFrame",onCardOpenEnterFrame);
            _mc.stop();
            if(_isClick)
            {
               CallBackLotteryDrawManager.instance.dispatchEvent(new Event("click_card_open_play_over"));
            }
         }
      }
      
      public function getMCTotalFrames() : int
      {
         return _mc.totalFrames;
      }
      
      private function onBuy(evt:CEvent) : void
      {
         var maskPic:* = null;
         var data:Object = evt.data;
         if(data.index == _award["Index"])
         {
            if(data.res)
            {
               if(_manager.luckeyLotteryDrawModel.currPhaseHasGetCount == 1)
               {
                  playCardOpen();
                  CallBackLotteryDrawManager.instance.dispatchEvent(new CEvent("click_card_open_item",this));
               }
               else
               {
                  _buyBtn.visible = false;
               }
               maskPic = UICreatShortcut.creatAndAdd("luckeylotterydraw.pic7",_mc);
               PositionUtils.setPos(maskPic,"luckeylotterydraw.hasGetMask");
            }
            _maskSp.parent.removeChild(_maskSp);
         }
      }
      
      public function dispose() : void
      {
         this.removeEventListener("rollOver",onCardOpenMCMouseHandler);
         this.removeEventListener("rollOut",onCardOpenMCMouseHandler);
         this.removeEventListener("click",onCardOpenMCMouseHandler);
         CallBackLotteryDrawManager.instance.removeEventListener("event_op_back_buy",onBuy);
         _mc.removeEventListener("enterFrame",onCardOpenEnterFrame);
         TweenLite.killTweensOf(_border);
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeAllChildren(this);
         _mc = null;
         _bagCell = null;
         _border = null;
         _borderTweenLite = null;
         _tweenLite = null;
         _buyBtn = null;
         _manager = null;
         _award = null;
         _maskSp = null;
      }
   }
}
