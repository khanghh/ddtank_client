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
      
      public function excute(param1:InventoryItemInfo) : void
      {
         info = param1;
         moveSpeciallFood = function():void
         {
            if(_info)
            {
               SocketManager.Instance.out.sendClearStoreBag();
            }
            SocketManager.Instance.out.sendMoveGoods(_info.BagType,_info.Place,12,-1,1);
         };
         moveFood = function(param1:int):void
         {
            var _loc3_:PetFoodNumberSelectFrame = ComponentFactory.Instance.creatComponentByStylename("petsBag.PetFoodNumberSelectFrame");
            var _loc5_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
            _loc3_.foodInfo = info;
            _loc3_.petInfo = _loc5_;
            var _loc2_:int = PetExperience.expericence[PetExperience.MAX_LEVEL - 1] - _loc5_.GP;
            var _loc4_:int = Math.ceil(_loc2_ / info.Property2);
            _loc3_.addEventListener("response",__onFoodAmountResponse);
            if(param1 == 0)
            {
               _loc3_.show(_loc4_);
            }
            else if(_loc4_ == 0)
            {
               _loc3_.show(param1);
            }
            else
            {
               _loc3_.show(Math.min(param1,_loc4_));
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
      
      protected function __onFoodAmountResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:PetFoodNumberSelectFrame = PetFoodNumberSelectFrame(param1.currentTarget);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_.dispose();
               break;
            case 2:
            case 3:
            case 4:
               _loc3_ = _loc2_.foodInfo;
               if(_info)
               {
                  SocketManager.Instance.out.sendClearStoreBag();
               }
               SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,0,_loc2_.amount,true);
               _loc2_.dispose();
         }
      }
      
      private function needMaxFood(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = PetconfigAnalyzer.PetCofnig.MaxHunger - param1;
         _loc3_ = Math.ceil(_loc4_ / param2);
         return _loc3_;
      }
   }
}
