package ddtKingFloat.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddtKingFloat.DDTKingFloatManager;
   import ddtKingFloat.data.DDTKingFloatCarInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DDTKingFloatFrameItemCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _awardBmp:Bitmap;
      
      private var _currentBoat:Bitmap;
      
      private var _awardInfoTxt1:FilterFrameText;
      
      private var _awardInfoTxt2:FilterFrameText;
      
      private var _defaultTxt:FilterFrameText;
      
      private var _dressUpBtn:TextButton;
      
      private var _index:int;
      
      private var _info:DDTKingFloatCarInfo;
      
      public function DDTKingFloatFrameItemCell(param1:int, param2:DDTKingFloatCarInfo)
      {
         super();
         _index = param1;
         _info = param2;
         initView();
         initEvent();
         refreshView(null);
         if(_dressUpBtn && DDTKingFloatManager.instance.freeCount <= 0)
         {
            _dressUpBtn.enable = false;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.cellBg" + _index);
         addChild(_bg);
         _awardBmp = ComponentFactory.Instance.creat("ddtKing.award");
         addChild(_awardBmp);
         _currentBoat = ComponentFactory.Instance.creat("ddtKing.currentBoat");
         addChild(_currentBoat);
         _currentBoat.visible = false;
         _awardInfoTxt1 = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.awardTxt");
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         _loc1_.TemplateID = _info.awardArr[0].templateId;
         ItemManager.fill(_loc1_);
         _awardInfoTxt1.text = LanguageMgr.GetTranslation("floatParade.race.awardInfo1",_loc1_.Name,_info.awardArr[0].count);
         addChild(_awardInfoTxt1);
         _awardInfoTxt2 = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.awardTxt");
         PositionUtils.setPos(_awardInfoTxt2,"ddtKing.race.awardTxtPos");
         _loc1_ = new InventoryItemInfo();
         _loc1_.TemplateID = _info.awardArr[1].templateId;
         ItemManager.fill(_loc1_);
         _awardInfoTxt2.text = LanguageMgr.GetTranslation("floatParade.race.awardInfo1",_loc1_.Name,_info.awardArr[1].count);
         addChild(_awardInfoTxt2);
         switch(int(_index))
         {
            case 0:
               _defaultTxt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.defaultTxt");
               _defaultTxt.text = LanguageMgr.GetTranslation("floatParade.race.noDress");
               addChild(_defaultTxt);
               break;
            case 1:
               _dressUpBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.dressUpTxtbtn");
               _dressUpBtn.text = LanguageMgr.GetTranslation("floatParade.race.normalDress");
               addChild(_dressUpBtn);
               break;
            case 2:
               _dressUpBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.dressUpTxtbtn");
               _dressUpBtn.text = LanguageMgr.GetTranslation("floatParade.race.luxuriousDress");
               addChild(_dressUpBtn);
         }
      }
      
      private function refreshView(param1:Event) : void
      {
         if(DDTKingFloatManager.instance.carStatus == _index)
         {
            _currentBoat.visible = true;
            if(_index != 0)
            {
               _dressUpBtn.enable = false;
            }
         }
         else
         {
            _currentBoat.visible = false;
            if(DDTKingFloatManager.instance.carStatus > _index && _dressUpBtn)
            {
               _dressUpBtn.enable = false;
            }
         }
      }
      
      private function initEvent() : void
      {
         if(_dressUpBtn)
         {
            _dressUpBtn.addEventListener("click",clickHandler,false,0,true);
         }
         DDTKingFloatManager.instance.addEventListener("floatParadeCarStatusChange",refreshView);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:Object = DDTKingFloatManager.instance.getBuyRecordStatus(0);
         if(_loc2_.isNoPrompt)
         {
            if(_loc2_.isBand && PlayerManager.Instance.Self.BandMoney < _info.needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               _loc2_.isNoPrompt = false;
            }
            else if(!_loc2_.isBand && PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               _loc2_.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendEscortCallCar(_index,_loc2_.isBand);
               return;
            }
         }
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("floatParade.frame.callCarConfirmTxt",_info.needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"ddtKingBuyConfirmView1",30,true,0);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",callConfirm,false,0,true);
      }
      
      private function callConfirm(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",callConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_loc4_.isBand && PlayerManager.Instance.Self.BandMoney < _info.needMoney)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",callCarReConfirm,false,0,true);
               return;
            }
            if(!_loc4_.isBand && PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc4_ as DDTKingFloatBuyConfirmView).isNoPrompt)
            {
               _loc3_ = DDTKingFloatManager.instance.getBuyRecordStatus(0);
               _loc3_.isNoPrompt = true;
               _loc3_.isBand = _loc4_.isBand;
            }
            SocketManager.Instance.out.sendEscortCallCar(_index,_loc4_.isBand);
         }
      }
      
      private function callCarReConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",callCarReConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < _info.needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendEscortCallCar(_index,false);
         }
      }
      
      private function removeEvent() : void
      {
         if(_dressUpBtn)
         {
            _dressUpBtn.removeEventListener("click",clickHandler);
         }
         DDTKingFloatManager.instance.removeEventListener("floatParadeCarStatusChange",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _awardInfoTxt1 = null;
         _awardInfoTxt2 = null;
         _defaultTxt = null;
         _dressUpBtn = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
