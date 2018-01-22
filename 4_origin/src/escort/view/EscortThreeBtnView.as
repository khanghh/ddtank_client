package escort.view
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
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.event.EscortEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class EscortThreeBtnView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leapBtn:SimpleBitmapButton;
      
      private var _invisibilityBtn:SimpleBitmapButton;
      
      private var _cleanBtn:SimpleBitmapButton;
      
      private var _recordClickTag:int;
      
      private var _freeTipList:Vector.<MovieClip>;
      
      public function EscortThreeBtnView()
      {
         super();
         this.x = 885;
         this.y = 258;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.escort.threeBtnBg");
         _leapBtn = ComponentFactory.Instance.creatComponentByStylename("escort.leapBtn");
         _leapBtn.tipData = LanguageMgr.GetTranslation("escort.game.leapBtnTipTxt");
         _invisibilityBtn = ComponentFactory.Instance.creatComponentByStylename("escort.invisibilityBtn");
         _invisibilityBtn.tipData = LanguageMgr.GetTranslation("escort.game.invisibilityBtnTipTxt");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("escort.cleanBtn");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("escort.game.cleanBtnTipTxt");
         addChild(_bg);
         addChild(_leapBtn);
         addChild(_invisibilityBtn);
         addChild(_cleanBtn);
         _freeTipList = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.escort.freeTipMc") as MovieClip;
            _loc1_.x = -36;
            _loc1_.y = -14 + 44 * _loc2_;
            _loc1_.mouseEnabled = false;
            _loc1_.mouseChildren = false;
            addChild(_loc1_);
            _freeTipList.push(_loc1_);
            _loc2_++;
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
         EscortManager.instance.addEventListener("escortRefreshItemCount",refreshFreeCount);
      }
      
      private function refreshFreeCount(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = EscortControl.instance.itemFreeCountList;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(_loc2_[_loc3_] > 0)
            {
               _freeTipList[_loc3_].tf.text = _loc2_[_loc3_].toString();
               _freeTipList[_loc3_].visible = true;
            }
            else
            {
               _freeTipList[_loc3_].visible = false;
            }
            _loc3_++;
         }
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         var _loc2_:EscortEvent = new EscortEvent("escortLeapPromptShowHide");
         _loc2_.data = {"isShow":false};
         EscortManager.instance.dispatchEvent(_loc2_);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         var _loc2_:EscortEvent = new EscortEvent("escortLeapPromptShowHide");
         _loc2_.data = {"isShow":true};
         EscortManager.instance.dispatchEvent(_loc2_);
      }
      
      private function enableBtn(param1:SimpleBitmapButton) : void
      {
         param1.enable = true;
      }
      
      private function unEnableBtn(param1:int) : void
      {
         var _loc2_:* = null;
         switch(int(param1))
         {
            case 0:
               _loc2_ = _leapBtn;
               break;
            case 1:
               _loc2_ = _invisibilityBtn;
               break;
            case 2:
               _loc2_ = _cleanBtn;
         }
         if(_loc2_)
         {
            _loc2_.enable = false;
            setTimeout(enableBtn,5000,_loc2_);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         var _loc6_:* = _loc4_;
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
            SocketManager.Instance.out.sendEscortUseSkill(_recordClickTag,false,true);
            unEnableBtn(_recordClickTag);
            return;
         }
         var _loc3_:Object = EscortControl.instance.getBuyRecordStatus(_recordClickTag + 2);
         var _loc2_:int = EscortControl.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
         if(_loc3_.isNoPrompt)
         {
            if(_loc3_.isBand && PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               _loc3_.isNoPrompt = false;
            }
            else if(!_loc3_.isBand && PlayerManager.Instance.Self.Money < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               _loc3_.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendEscortUseSkill(_recordClickTag,_loc3_.isBand,_freeTipList[_recordClickTag].visible);
               unEnableBtn(_recordClickTag);
               return;
            }
         }
         var _loc5_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.frame.useSkillConfirmTxt" + _recordClickTag,_loc2_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"EscortBuyConfirmView1",30,true);
         _loc5_.moveEnable = false;
         _loc5_.addEventListener("response",useSkillConfirm,false,0,true);
      }
      
      private function useSkillConfirm(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         SoundManager.instance.play("008");
         var _loc5_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc5_.removeEventListener("response",useSkillConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = EscortControl.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(_loc5_.isBand && PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc3_.moveEnable = false;
               _loc3_.addEventListener("response",useSkillReConfirm,false,0,true);
               return;
            }
            if(!_loc5_.isBand && PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc5_ as EscortBuyConfirmView).isNoPrompt)
            {
               _loc4_ = EscortControl.instance.getBuyRecordStatus(_recordClickTag + 2);
               _loc4_.isNoPrompt = true;
               _loc4_.isBand = _loc5_.isBand;
            }
            SocketManager.Instance.out.sendEscortUseSkill(_recordClickTag,_loc5_.isBand,_freeTipList[_recordClickTag].visible);
            unEnableBtn(_recordClickTag);
         }
      }
      
      private function useSkillReConfirm(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",useSkillConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = EscortControl.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendEscortUseSkill(_recordClickTag,false,_freeTipList[_recordClickTag].visible);
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
         EscortManager.instance.removeEventListener("escortRefreshItemCount",refreshFreeCount);
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
