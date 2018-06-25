package sevenDouble.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
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
   import sevenDouble.SevenDoubleControl;
   import sevenDouble.SevenDoubleManager;
   import sevenDouble.event.SevenDoubleEvent;
   
   public class SevenDoubleThreeBtnView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leapBtn:SimpleBitmapButton;
      
      private var _invisibilityBtn:SimpleBitmapButton;
      
      private var _cleanBtn:SimpleBitmapButton;
      
      private var _recordClickTag:int;
      
      private var _freeTipList:Vector.<MovieClip>;
      
      public function SevenDoubleThreeBtnView()
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
         _bg = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.threeBtnBg");
         _leapBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.leapBtn");
         _leapBtn.tipData = LanguageMgr.GetTranslation("sevenDouble.game.leapBtnTipTxt");
         _invisibilityBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.invisibilityBtn");
         _invisibilityBtn.tipData = LanguageMgr.GetTranslation("sevenDouble.game.invisibilityBtnTipTxt");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.cleanBtn");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("sevenDouble.game.cleanBtnTipTxt");
         addChild(_bg);
         addChild(_leapBtn);
         addChild(_invisibilityBtn);
         addChild(_cleanBtn);
         _freeTipList = new Vector.<MovieClip>();
         for(i = 0; i < 3; )
         {
            tmp = ComponentFactory.Instance.creat("asset.sevenDouble.freeTipMc") as MovieClip;
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
         SevenDoubleControl.instance.addEventListener("sevenDoubleRefreshItemCount",refreshFreeCount);
      }
      
      private function refreshFreeCount(event:Event) : void
      {
         var i:int = 0;
         var tmp:Array = SevenDoubleControl.instance.itemFreeCountList;
         for(i = 0; i < 3; )
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
         var tmp:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleLeapPromptShowHide");
         tmp.data = {"isShow":false};
         SevenDoubleManager.instance.dispatchEvent(tmp);
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         var tmp:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleLeapPromptShowHide");
         tmp.data = {"isShow":true};
         SevenDoubleManager.instance.dispatchEvent(tmp);
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
         }
         if(target)
         {
            target.enable = false;
            setTimeout(enableBtn,5000,target);
         }
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var target:SimpleBitmapButton = event.target as SimpleBitmapButton;
         var _loc6_:* = target;
         if(_leapBtn !== _loc6_)
         {
            if(_invisibilityBtn !== _loc6_)
            {
               if(_cleanBtn === _loc6_)
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
         if(_freeTipList[_recordClickTag].visible)
         {
            SocketManager.Instance.out.sendSevenDoubleUseSkill(_recordClickTag,false,true);
            unEnableBtn(_recordClickTag);
            return;
         }
         var tmpObj:Object = SevenDoubleControl.instance.getBuyRecordStatus(_recordClickTag + 2);
         var needMoney:int = SevenDoubleControl.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
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
               SocketManager.Instance.out.sendSevenDoubleUseSkill(_recordClickTag,tmpObj.isBand,_freeTipList[_recordClickTag].visible);
               unEnableBtn(_recordClickTag);
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.frame.useSkillConfirmTxt" + _recordClickTag,needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SevenDoubleBuyConfirmView1",30,true,1);
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
            needMoney = SevenDoubleControl.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < needMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",useSkillReConfirm,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as SevenDoubleBuyConfirmView).isNoPrompt)
            {
               tmpObj = SevenDoubleControl.instance.getBuyRecordStatus(_recordClickTag + 2);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendSevenDoubleUseSkill(_recordClickTag,confirmFrame.isBand,_freeTipList[_recordClickTag].visible);
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
            needMoney = SevenDoubleControl.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendSevenDoubleUseSkill(_recordClickTag,false,_freeTipList[_recordClickTag].visible);
            unEnableBtn(_recordClickTag);
         }
      }
      
      private function removeEvent() : void
      {
         _leapBtn.removeEventListener("click",clickHandler);
         _leapBtn.removeEventListener("mouseOver",overHandler);
         _leapBtn.removeEventListener("mouseOut",outHandler);
         _invisibilityBtn.removeEventListener("click",clickHandler);
         _cleanBtn.removeEventListener("click",clickHandler);
         SevenDoubleControl.instance.removeEventListener("sevenDoubleRefreshItemCount",refreshFreeCount);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _leapBtn = null;
         _invisibilityBtn = null;
         _cleanBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
