package floatParade.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import floatParade.FloatParadeEvent;
   import floatParade.FloatParadeManager;
   
   public class FloatParadeThreeBtnView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leapBtn:SimpleBitmapButton;
      
      private var _invisibilityBtn:SimpleBitmapButton;
      
      private var _cleanBtn:SimpleBitmapButton;
      
      private var _missileBtn:SimpleBitmapButton;
      
      private var _recordClickTag:int;
      
      private var _freeTipList:Vector.<MovieClip>;
      
      public var targetId:int = 0;
      
      public var targetZone:int = -1;
      
      public function FloatParadeThreeBtnView()
      {
         super();
         this.x = 885;
         this.y = 258;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("floatParade.threeBtnBg");
         _leapBtn = ComponentFactory.Instance.creatComponentByStylename("floatParade.leapBtn");
         _leapBtn.tipData = LanguageMgr.GetTranslation("floatParade.game.leapBtnTipTxt");
         _invisibilityBtn = ComponentFactory.Instance.creatComponentByStylename("floatParade.invisibilityBtn");
         _invisibilityBtn.tipData = LanguageMgr.GetTranslation("floatParade.game.invisibilityBtnTipTxt");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("floatParade.cleanBtn");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("floatParade.game.cleanBtnTipTxt");
         _missileBtn = ComponentFactory.Instance.creatComponentByStylename("floatParade.missileBtn");
         _missileBtn.tipData = LanguageMgr.GetTranslation("floatParade.game.missileBtnTipTxt");
         addChild(_bg);
         addChild(_leapBtn);
         addChild(_invisibilityBtn);
         addChild(_cleanBtn);
         addChild(_missileBtn);
         _freeTipList = new Vector.<MovieClip>();
         for(i = 0; i < 4; )
         {
            tmp = ComponentFactory.Instance.creat("floatParade.freeTipMc") as MovieClip;
            tmp.x = -36;
            tmp.y = -14 + 44 * i;
            tmp.mouseEnabled = false;
            tmp.mouseChildren = false;
            addChild(tmp);
            _freeTipList.push(tmp);
            i++;
         }
         refreshFreeCount(null);
      }
      
      private function initEvent() : void
      {
         _leapBtn.addEventListener("click",clickHandler,false,0,true);
         _leapBtn.addEventListener("mouseOver",overHandler,false,0,true);
         _leapBtn.addEventListener("mouseOut",outHandler,false,0,true);
         _invisibilityBtn.addEventListener("click",clickHandler,false,0,true);
         _cleanBtn.addEventListener("click",clickHandler,false,0,true);
         _missileBtn.addEventListener("click",clickHandler,false,0,true);
         FloatParadeManager.instance.addEventListener("floatParadeRefreshItemCount",refreshFreeCount);
      }
      
      private function refreshFreeCount(event:Event) : void
      {
         var i:int = 0;
         var tmp:Array = FloatParadeManager.instance.itemFreeCountList;
         for(i = 0; i < 4; )
         {
            if(tmp[i] > 0)
            {
               _freeTipList[i].tf.text = tmp[i].toString();
               _freeTipList[i].visible = true;
            }
            else
            {
               _freeTipList[i].visible = false;
            }
            i++;
         }
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         var tmp:FloatParadeEvent = new FloatParadeEvent("floatParadeLeapPromptShowHide");
         tmp.data = {"isShow":false};
         FloatParadeManager.instance.dispatchEvent(tmp);
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         var tmp:FloatParadeEvent = new FloatParadeEvent("floatParadeLeapPromptShowHide");
         tmp.data = {"isShow":true};
         FloatParadeManager.instance.dispatchEvent(tmp);
      }
      
      private function enableBtn(btn:SimpleBitmapButton) : void
      {
         btn.enable = true;
      }
      
      private function unEnableBtn(tag:int) : void
      {
         var target:* = null;
         switch(int(tag))
         {
            case 0:
               target = _leapBtn;
               break;
            case 1:
               target = _invisibilityBtn;
               break;
            case 2:
               target = _cleanBtn;
               break;
            case 3:
               target = _missileBtn;
         }
         if(target)
         {
            target.enable = false;
            setTimeout(enableBtn,5000,target);
         }
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         var missileFrame:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         trace("selfPlayer.x==================" + FloatParadeManager.instance.selfPlayer.x);
         var target:SimpleBitmapButton = event.target as SimpleBitmapButton;
         var _loc4_:* = target;
         if(_leapBtn !== _loc4_)
         {
            if(_invisibilityBtn !== _loc4_)
            {
               if(_cleanBtn !== _loc4_)
               {
                  if(_missileBtn === _loc4_)
                  {
                     _recordClickTag = 3;
                     missileFrame = ComponentFactory.Instance.creatComponentByStylename("floatParade.missileFrame.frame");
                     LayerManager.Instance.addToLayer(missileFrame,3,true,1);
                     missileFrame.setThreeBtnView(this);
                     return;
                  }
               }
               else
               {
                  _recordClickTag = 2;
               }
            }
            else
            {
               _recordClickTag = 1;
            }
         }
         else
         {
            _recordClickTag = 0;
         }
         useSkill();
      }
      
      public function useSkill() : void
      {
         if(_freeTipList[_recordClickTag].visible)
         {
            sendUseSkillSocket(_recordClickTag,false,true,targetId,targetZone);
            unEnableBtn(_recordClickTag);
            return;
         }
         var tmpObj:Object = FloatParadeManager.instance.getBuyRecordStatus(_recordClickTag + 2);
         var needMoney:int = FloatParadeManager.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
         if(tmpObj.isNoPrompt)
         {
            if(tmpObj.isBand && PlayerManager.Instance.Self.BandMoney < needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               tmpObj.isNoPrompt = false;
            }
            else if(!tmpObj.isBand && PlayerManager.Instance.Self.Money < needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               tmpObj.isNoPrompt = false;
            }
            else
            {
               sendUseSkillSocket(_recordClickTag,tmpObj.isBand,_freeTipList[_recordClickTag].visible,targetId,targetZone);
               unEnableBtn(_recordClickTag);
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("floatParade.frame.useSkillConfirmTxt" + _recordClickTag,needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"FloatParadeBuyConfirmView1",30,true);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",useSkillConfirm,false,0,true);
      }
      
      private function useSkillConfirm(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         var confirmFrame2:* = null;
         var tmpObj:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",useSkillConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needMoney = FloatParadeManager.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < needMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",useSkillReConfirm,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as FloatParadeBuyConfirmView).isNoPrompt)
            {
               tmpObj = FloatParadeManager.instance.getBuyRecordStatus(_recordClickTag + 2);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            sendUseSkillSocket(_recordClickTag,confirmFrame.isBand,_freeTipList[_recordClickTag].visible,targetId,targetZone);
            unEnableBtn(_recordClickTag);
         }
      }
      
      private function useSkillReConfirm(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",useSkillConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needMoney = FloatParadeManager.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            sendUseSkillSocket(_recordClickTag,false,_freeTipList[_recordClickTag].visible,targetId,targetZone);
            unEnableBtn(_recordClickTag);
         }
      }
      
      private function sendUseSkillSocket(type:int, isBand:Boolean, isFree:Boolean, otherId:int = 0, otherZone:int = -1) : void
      {
         var arr:* = null;
         if(type != 3)
         {
            SocketManager.Instance.out.sendEscortUseSkill(type,isBand,isFree,otherId,otherZone);
         }
         else
         {
            arr = [];
            arr.push(type);
            arr.push(isBand);
            arr.push(isFree);
            arr.push(otherId);
            arr.push(otherZone);
            FloatParadeManager.instance.missileArgArr = arr;
            SocketManager.Instance.out.broadcastMissileMC();
         }
      }
      
      private function removeEvent() : void
      {
         _leapBtn.removeEventListener("click",clickHandler);
         _leapBtn.removeEventListener("mouseOver",overHandler);
         _leapBtn.removeEventListener("mouseOut",outHandler);
         _invisibilityBtn.removeEventListener("click",clickHandler);
         _cleanBtn.removeEventListener("click",clickHandler);
         _missileBtn.removeEventListener("click",clickHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeRefreshItemCount",refreshFreeCount);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _leapBtn = null;
         _invisibilityBtn = null;
         _cleanBtn = null;
         _missileBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
