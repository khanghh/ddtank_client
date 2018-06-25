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
      
      public function set petInfo(val:PetInfo) : void
      {
         _petInfo = val;
      }
      
      public function set foodInfo(val:InventoryItemInfo) : void
      {
         _foodInfo = val;
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
      
      private function __seleterChange(event:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function show(max:int, min:int = 1) : void
      {
         var limitNum:* = 0;
         var level:int = 0;
         var upgradeNeeded:int = 0;
         var addHunger:int = 0;
         var currentPet:* = null;
         var petLevel:int = 0;
         var playerLevel:int = 0;
         if(_foodInfo.Count >= max)
         {
            limitNum = max;
         }
         else
         {
            limitNum = int(_foodInfo.Count);
         }
         _numberSelecter.valueLimit = min + "," + limitNum;
         LayerManager.Instance.addToLayer(this,3,true,1);
         if(_petInfo)
         {
            level = PetExperience.getLevelByGP(_petInfo.GP);
            upgradeNeeded = PetExperience.expericence[level] - _petInfo.GP;
            neededFoodAmount = int(Math.ceil(upgradeNeeded / _foodInfo.Property2));
            addHunger = _foodInfo.Property1;
            currentPet = PetsBagManager.instance().petModel.currentPetInfo;
            petLevel = currentPet.Level;
            playerLevel = PlayerManager.Instance.Self.Grade;
            if(petLevel == playerLevel || petLevel == PetExperience.MAX_LEVEL)
            {
               _needFoodText.htmlText = LanguageMgr.GetTranslation("ddt.pets.hungerNeedFoodAmount",max);
               _needFoodText.visible = true;
               if(_foodInfo.Count >= max)
               {
                  _numberSelecter.currentValue = max;
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
      
      private function needMaxFood(hunger:int, addHunger:int) : int
      {
         var maxFood:int = 0;
         var limitHunger:int = PetconfigAnalyzer.PetCofnig.MaxHunger - hunger;
         maxFood = Math.ceil(limitHunger / addHunger);
         return maxFood;
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
