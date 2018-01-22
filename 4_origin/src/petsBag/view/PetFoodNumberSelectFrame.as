package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PetExperience;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetFoodNumberSelectFrame extends BaseAlerFrame
   {
       
      
      private var _foodInfo:InventoryItemInfo;
      
      private var _alertInfo:AlertInfo;
      
      private var _petInfo:PetInfo;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _text:FilterFrameText;
      
      private var _needFoodText:FilterFrameText;
      
      private var maxFood:int = 0;
      
      private var neededFoodAmount:int;
      
      public function PetFoodNumberSelectFrame()
      {
         super();
         initView();
      }
      
      public function set petInfo(param1:PetInfo) : void
      {
         _petInfo = param1;
      }
      
      public function set foodInfo(param1:InventoryItemInfo) : void
      {
         _foodInfo = param1;
      }
      
      public function get foodInfo() : InventoryItemInfo
      {
         return _foodInfo;
      }
      
      public function get amount() : int
      {
         return _numberSelecter.currentValue;
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.pets.foodAmountSelect"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _text = ComponentFactory.Instance.creatComponentByStylename("petsBag.PetFoodNumberSelectFrame.Text");
         _text.text = LanguageMgr.GetTranslation("ddt.pets.foodAmountTipText");
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         _numberSelecter.addEventListener("change",__seleterChange);
         PositionUtils.setPos(_numberSelecter,"petsBag.PetFoodNumberSelectFrame.numberSelecterPos");
         _needFoodText = ComponentFactory.Instance.creatComponentByStylename("petsBag.PetFoodNumberSelectFrame.NeedFoodText");
         PositionUtils.setPos(_needFoodText,"petsBag.PetFoodNumberSelectFrame.needFoodTextPos");
         _needFoodText.visible = false;
         addToContent(_text);
         addToContent(_numberSelecter);
         addToContent(_needFoodText);
      }
      
      private function __seleterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function show(param1:int, param2:int = 1) : void
      {
         var _loc9_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         if(_foodInfo.Count >= param1)
         {
            _loc9_ = param1;
         }
         else
         {
            _loc9_ = int(_foodInfo.Count);
         }
         _numberSelecter.valueLimit = param2 + "," + _loc9_;
         LayerManager.Instance.addToLayer(this,3,true,1);
         if(_petInfo)
         {
            _loc6_ = PetExperience.getLevelByGP(_petInfo.GP);
            _loc5_ = PetExperience.expericence[_loc6_] - _petInfo.GP;
            neededFoodAmount = int(Math.ceil(_loc5_ / _foodInfo.Property2));
            _loc4_ = _foodInfo.Property1;
            _loc8_ = PetsBagManager.instance().petModel.currentPetInfo;
            _loc7_ = _loc8_.Level;
            _loc3_ = PlayerManager.Instance.Self.Grade;
            if(_loc7_ == _loc3_ || _loc7_ == PetExperience.MAX_LEVEL)
            {
               _needFoodText.htmlText = LanguageMgr.GetTranslation("ddt.pets.hungerNeedFoodAmount",param1);
               _needFoodText.visible = true;
               if(_foodInfo.Count >= param1)
               {
                  _numberSelecter.currentValue = param1;
               }
               else
               {
                  _numberSelecter.currentValue = _foodInfo.Count;
               }
               _numberSelecter.validate();
            }
            else
            {
               _needFoodText.htmlText = LanguageMgr.GetTranslation("ddt.pets.upgradeNeedFoodAmount",neededFoodAmount);
               _needFoodText.visible = true;
               _numberSelecter.currentValue = neededFoodAmount;
               _numberSelecter.validate();
            }
         }
      }
      
      private function needMaxFood(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = PetconfigAnalyzer.PetCofnig.MaxHunger - param1;
         _loc3_ = Math.ceil(_loc4_ / param2);
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _numberSelecter.removeEventListener("change",__seleterChange);
         removeView();
      }
      
      private function removeView() : void
      {
         ObjectUtils.disposeObject(_numberSelecter);
         _numberSelecter = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_needFoodText);
         _needFoodText = null;
      }
   }
}
