package petsBag.cmd
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.EquipType;
   import ddt.data.PetExperience;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.view.PetFoodNumberSelectFrame;
   
   public class CmdShowPetFoodNumberSelectFrame
   {
       
      
      private var _info:InventoryItemInfo;
      
      public function CmdShowPetFoodNumberSelectFrame()
      {
         super();
      }
      
      public function excute(info:InventoryItemInfo) : void
      {
         info = info;
         moveSpeciallFood = function():void
         {
            if(_info)
            {
               SocketManager.Instance.out.sendClearStoreBag();
            }
            SocketManager.Instance.out.sendMoveGoods(_info.BagType,_info.Place,12,-1,1);
         };
         moveFood = function(count:int):void
         {
            var alert:PetFoodNumberSelectFrame = ComponentFactory.Instance.creatComponentByStylename("petsBag.PetFoodNumberSelectFrame");
            var petInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
            alert.foodInfo = info;
            alert.petInfo = petInfo;
            var upgradeNeeded:int = PetExperience.expericence[PetExperience.MAX_LEVEL - 1] - petInfo.GP;
            var neededFoodMax:int = Math.ceil(upgradeNeeded / info.Property2);
            alert.addEventListener("response",__onFoodAmountResponse);
            if(count == 0)
            {
               alert.show(neededFoodMax);
            }
            else if(neededFoodMax == 0)
            {
               alert.show(count);
            }
            else
            {
               alert.show(Math.min(count,neededFoodMax));
            }
         };
         if(info == null)
         {
            return;
         }
         if(PetsBagManager.instance().petModel.currentPetInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petEquipNo"));
            return;
         }
         _info = info;
         var isSpeciallFood:Boolean = EquipType.isPetSpeciallFood(_info);
         var needMaxFoodValue:int = needMaxFood(PetsBagManager.instance().petModel.currentPetInfo.Hunger,int(_info.Property1));
         var breakGrade:int = PetsBagManager.instance().petModel.currentPetInfo.breakGrade;
         switch(int(breakGrade) - 1)
         {
            case 0:
               breakGrade = 63;
               break;
            case 1:
               breakGrade = 65;
               break;
            case 2:
               breakGrade = 68;
               break;
            case 3:
               breakGrade = 70;
         }
         var playerGrade:int = PlayerManager.Instance.Self.Grade;
         var petsLevel:int = PetsBagManager.instance().petModel.currentPetInfo.Level;
         if(!int(needMaxFoodValue))
         {
            if(petsLevel == breakGrade || petsLevel == playerGrade)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.hungerFull"));
            }
            else if(isSpeciallFood)
            {
               moveSpeciallFood();
            }
            else
            {
               moveFood(_info.Count);
            }
         }
         else if(petsLevel == breakGrade || petsLevel == playerGrade)
         {
            if(isSpeciallFood)
            {
               moveSpeciallFood();
            }
            else
            {
               moveFood(needMaxFoodValue);
            }
         }
         else if(isSpeciallFood)
         {
            moveSpeciallFood();
         }
         else
         {
            moveFood(_info.Count);
         }
      }
      
      protected function __onFoodAmountResponse(event:FrameEvent) : void
      {
         var foodInfo:* = null;
         SoundManager.instance.play("008");
         var frame:PetFoodNumberSelectFrame = PetFoodNumberSelectFrame(event.currentTarget);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               frame.dispose();
               break;
            case 2:
            case 3:
            case 4:
               foodInfo = frame.foodInfo;
               if(_info)
               {
                  SocketManager.Instance.out.sendClearStoreBag();
               }
               SocketManager.Instance.out.sendMoveGoods(foodInfo.BagType,foodInfo.Place,12,0,frame.amount,true);
               frame.dispose();
         }
      }
      
      private function needMaxFood(hunger:int, addHunger:int) : int
      {
         var maxFood:int = 0;
         var limitHunger:int = PetconfigAnalyzer.PetCofnig.MaxHunger - hunger;
         maxFood = Math.ceil(limitHunger / addHunger);
         return maxFood;
      }
   }
}
