package drgnBoat.views
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
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class DrgnBoatThreeBtnView extends Sprite implements Disposeable
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
      
      public function DrgnBoatThreeBtnView()
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
         _bg = ComponentFactory.Instance.creatBitmap("drgnBoat.threeBtnBg");
         _leapBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.leapBtn");
         _leapBtn.tipData = LanguageMgr.GetTranslation("drgnBoat.game.leapBtnTipTxt");
         _invisibilityBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.invisibilityBtn");
         _invisibilityBtn.tipData = LanguageMgr.GetTranslation("drgnBoat.game.invisibilityBtnTipTxt");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.cleanBtn");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("drgnBoat.game.cleanBtnTipTxt");
         _missileBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.missileBtn");
         _missileBtn.tipData = LanguageMgr.GetTranslation("drgnBoat.game.missileBtnTipTxt");
         addChild(_bg);
         addChild(_leapBtn);
         addChild(_invisibilityBtn);
         addChild(_cleanBtn);
         addChild(_missileBtn);
         _freeTipList = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creat("drgnBoat.freeTipMc") as MovieClip;
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
         _missileBtn.addEventListener("click",clickHandler,false,0,true);
         DrgnBoatManager.instance.addEventListener("drgnBoatRefreshItemCount",refreshFreeCount);
      }
      
      private function refreshFreeCount(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = DrgnBoatManager.instance.itemFreeCountList;
         _loc3_ = 0;
         while(_loc3_ < 4)
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
         var _loc2_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatLeapPromptShowHide");
         _loc2_.data = {"isShow":false};
         DrgnBoatManager.instance.dispatchEvent(_loc2_);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         var _loc2_:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatLeapPromptShowHide");
         _loc2_.data = {"isShow":true};
         DrgnBoatManager.instance.dispatchEvent(_loc2_);
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
               break;
            case 3:
               _loc2_ = _missileBtn;
         }
         if(_loc2_)
         {
            _loc2_.enable = false;
            setTimeout(enableBtn,5000,_loc2_);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         var _loc4_:* = _loc2_;
         if(_leapBtn !== _loc4_)
         {
            if(_invisibilityBtn !== _loc4_)
            {
               if(_cleanBtn !== _loc4_)
               {
                  if(_missileBtn === _loc4_)
                  {
                     _recordClickTag = 3;
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.missileFrame.frame");
                     LayerManager.Instance.addToLayer(_loc3_,3,true,1);
                     _loc3_.setThreeBtnView(this);
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
         var _loc2_:Object = DrgnBoatManager.instance.getBuyRecordStatus(_recordClickTag + 2);
         var _loc1_:int = DrgnBoatManager.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
         if(_loc2_.isNoPrompt)
         {
            if(_loc2_.isBand && PlayerManager.Instance.Self.BandMoney < _loc1_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               _loc2_.isNoPrompt = false;
            }
            else if(!_loc2_.isBand && PlayerManager.Instance.Self.Money < _loc1_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               _loc2_.isNoPrompt = false;
            }
            else
            {
               sendUseSkillSocket(_recordClickTag,_loc2_.isBand,_freeTipList[_recordClickTag].visible,targetId,targetZone);
               unEnableBtn(_recordClickTag);
               return;
            }
         }
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("drgnBoat.frame.useSkillConfirmTxt" + _recordClickTag,_loc1_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"DrgnBoatBuyConfirmView1",30,true,0);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",useSkillConfirm,false,0,true);
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
            _loc2_ = DrgnBoatManager.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
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
            if((_loc5_ as DrgnBoatBuyConfirmView).isNoPrompt)
            {
               _loc4_ = DrgnBoatManager.instance.getBuyRecordStatus(_recordClickTag + 2);
               _loc4_.isNoPrompt = true;
               _loc4_.isBand = _loc5_.isBand;
            }
            sendUseSkillSocket(_recordClickTag,_loc5_.isBand,_freeTipList[_recordClickTag].visible,targetId,targetZone);
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
            _loc2_ = DrgnBoatManager.instance.dataInfo.useSkillNeedMoney[_recordClickTag];
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            sendUseSkillSocket(_recordClickTag,false,_freeTipList[_recordClickTag].visible,targetId,targetZone);
            unEnableBtn(_recordClickTag);
         }
      }
      
      private function sendUseSkillSocket(param1:int, param2:Boolean, param3:Boolean, param4:int = 0, param5:int = -1) : void
      {
         var _loc6_:* = null;
         if(param1 != 3)
         {
            SocketManager.Instance.out.sendEscortUseSkill(param1,param2,param3,param4,param5);
         }
         else
         {
            _loc6_ = [];
            _loc6_.push(param1);
            _loc6_.push(param2);
            _loc6_.push(param3);
            _loc6_.push(param4);
            _loc6_.push(param5);
            DrgnBoatManager.instance.missileArgArr = _loc6_;
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
         DrgnBoatManager.instance.removeEventListener("drgnBoatRefreshItemCount",refreshFreeCount);
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
