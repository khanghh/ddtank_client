package farm.viewx
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.Sprite;
   import petsBag.PetsBagManager;
   
   public class FarmFieldsView extends Sprite implements Disposeable
   {
       
      
      private var _fields:Vector.<FarmFieldBlock>;
      
      private var _configmPnl:ConfirmKillCropAlertFrame;
      
      public function FarmFieldsView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         FarmModelController.instance.addEventListener("fieldsInfoReady",__fieldInfoReady);
         FarmModelController.instance.addEventListener("hasSeeding",__hasSeeding);
         FarmModelController.instance.addEventListener("frushField",__frushField);
         FarmModelController.instance.addEventListener("gainField",__gainField);
         FarmModelController.instance.addEventListener("accelerateField",__accelerateField);
         FarmModelController.instance.addEventListener("helperSwitchField",__helperSwitchHandler);
         FarmModelController.instance.addEventListener("helperkeyfield",__helperKeyHandler);
         FarmModelController.instance.addEventListener("killCropField",__onKillcropField);
         FarmModelController.instance.addEventListener("beginHelper",__setFields);
         FarmModelController.instance.addEventListener("stopHelper",__frushField);
      }
      
      private function remvoeEvent() : void
      {
         FarmModelController.instance.removeEventListener("fieldsInfoReady",__fieldInfoReady);
         FarmModelController.instance.removeEventListener("hasSeeding",__hasSeeding);
         FarmModelController.instance.removeEventListener("frushField",__frushField);
         FarmModelController.instance.removeEventListener("gainField",__gainField);
         FarmModelController.instance.removeEventListener("accelerateField",__accelerateField);
         FarmModelController.instance.removeEventListener("helperSwitchField",__helperSwitchHandler);
         FarmModelController.instance.removeEventListener("helperkeyfield",__helperKeyHandler);
         FarmModelController.instance.removeEventListener("killCropField",__onKillcropField);
         FarmModelController.instance.removeEventListener("beginHelper",__setFields);
         FarmModelController.instance.removeEventListener("stopHelper",__frushField);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _fields = new Vector.<FarmFieldBlock>(16);
         _loc2_ = 0;
         while(_loc2_ < 16)
         {
            _loc1_ = new FarmFieldBlock(_loc2_);
            PositionUtils.setPos(_loc1_,"farm.fieldsView.fieldPos" + _loc2_);
            _loc1_.addEventListener("killcropshow",__showComfigKillCrop);
            addChild(_loc1_);
            _fields[_loc2_] = _loc1_;
            _loc2_++;
         }
         __fieldInfoReady(null);
      }
      
      private function __setFields(param1:FarmEvent) : void
      {
         setFieldByHelper();
      }
      
      public function setFieldByHelper() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(PlayerManager.Instance.Self.ID != FarmModelController.instance.model.currentFarmerId)
         {
            return;
         }
         if(!PlayerManager.Instance.Self.isFarmHelper)
         {
            return;
         }
         var _loc1_:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         _loc3_ = 0;
         while(_loc3_ < FarmModelController.instance.model.fieldsInfo.length)
         {
            _loc2_ = (new Date().getTime() - _loc1_[_loc3_].payTime.getTime()) / 3600000;
            if(_loc1_[_loc3_].fieldValidDate > _loc2_ || _loc1_[_loc3_].fieldValidDate == -1)
            {
               _fields[_loc3_].setBeginHelper(FarmModelController.instance.model.helperArray[1]);
            }
            _loc3_++;
         }
      }
      
      protected function __fieldInfoReady(param1:FarmEvent) : void
      {
         upFields();
         upFlagPlace();
         setFieldByHelper();
      }
      
      private function __hasSeeding(param1:FarmEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 16)
         {
            if(_fields[_loc2_].info.fieldID == FarmModelController.instance.model.seedingFieldInfo.fieldID)
            {
               _fields[_loc2_].info = FarmModelController.instance.model.seedingFieldInfo;
               if(PetsBagManager.instance().haveTaskOrderByID(369))
               {
                  PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(103);
               }
               break;
            }
            _loc2_++;
         }
         autoHelperHandler(FarmModelController.instance.model.seedingFieldInfo);
      }
      
      private function __frushField(param1:FarmEvent) : void
      {
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            upFields();
            upFlagPlace();
            setFieldByHelper();
         }
      }
      
      private function __gainField(param1:FarmEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.gainFieldId);
         _loc3_ = 0;
         while(_loc3_ < 16)
         {
            if(_fields[_loc3_].info.fieldID == FarmModelController.instance.model.gainFieldId)
            {
               _fields[_loc3_].info = _loc2_;
               upFlagPlace();
               break;
            }
            _loc3_++;
         }
         if(_loc2_.isAutomatic)
         {
            autoHelperHandler(_loc2_);
         }
      }
      
      private function __accelerateField(param1:FarmEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.matureId);
         _loc3_ = 0;
         while(_loc3_ < 16)
         {
            if(_fields[_loc3_].info.fieldID == FarmModelController.instance.model.matureId)
            {
               _fields[_loc3_].info = _loc2_;
               break;
            }
            _loc3_++;
         }
         autoHelperHandler(_loc2_);
      }
      
      private function __helperSwitchHandler(param1:FarmEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 16)
         {
            if(_fields[_loc2_].info.fieldID == FarmModelController.instance.model.isAutoId)
            {
               _fields[_loc2_].info = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.isAutoId);
               return;
            }
            _loc2_++;
         }
      }
      
      private function __helperKeyHandler(param1:FarmEvent) : void
      {
         var _loc2_:Array = FarmModelController.instance.model.batchFieldIDArray;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _fields[_loc3_].info = FarmModelController.instance.model.getfieldInfoById(_loc3_);
         }
      }
      
      private function __onKillcropField(param1:FarmEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.killCropId);
         _loc3_ = 0;
         while(_loc3_ < 16)
         {
            if(_fields[_loc3_].info.fieldID == FarmModelController.instance.model.killCropId)
            {
               _fields[_loc3_].info = _loc2_;
               return;
            }
            _loc3_++;
         }
      }
      
      private function upFields() : void
      {
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
         var _loc2_:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc5_].fieldID;
            if(_fields[_loc1_])
            {
               _fields[_loc1_].info = _loc2_[_loc5_];
               autoHelperHandler(_fields[_loc1_].info);
               _loc4_.splice(_loc4_.indexOf(_loc1_),1);
            }
            _loc5_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _fields[_loc4_[_loc3_]].info = null;
            _loc3_++;
         }
      }
      
      private function upFlagPlace() : void
      {
         var _loc1_:* = undefined;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [8,9,10,11,12,13,14,15];
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            _loc1_ = FarmModelController.instance.model.fieldsInfo;
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               if(_loc1_[_loc5_].fieldID >= 8 && (_loc1_[_loc5_].isDig || _loc1_[_loc5_].seedID != 0))
               {
                  _loc3_.splice(_loc3_.indexOf(_loc1_[_loc5_].fieldID),1);
                  _fields[_loc1_[_loc5_].fieldID].flag = false;
               }
               _loc5_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               if(_loc2_ == 0)
               {
                  _fields[_loc3_[_loc2_]].flag = true;
               }
               else
               {
                  _fields[_loc3_[_loc2_]].flag = false;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _fields[_loc3_[_loc4_]].flag = false;
               _loc4_++;
            }
         }
      }
      
      private function __showComfigKillCrop(param1:SelectComposeItemEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:FieldVO = param1.data as FieldVO;
         _configmPnl = ComponentFactory.Instance.creatComponentByStylename("farm.confirmKillCropAlertFrame");
         _configmPnl.cropName(ItemManager.Instance.getTemplateById(_loc2_.seedID).Name,_loc2_.isAutomatic);
         _configmPnl.fieldId = _loc2_.fieldID;
         _configmPnl.addEventListener("killcropClick",__killCropClick);
         LayerManager.Instance.addToLayer(_configmPnl,3,true,1);
      }
      
      private function __killCropClick(param1:SelectComposeItemEvent) : void
      {
         var _loc2_:int = param1.data as int;
         if(_loc2_ != -1)
         {
            FarmModelController.instance.killCrop(_loc2_);
         }
         if(_configmPnl)
         {
            _configmPnl.removeEventListener("killcropClick",__killCropClick);
         }
         this.dispatchEvent(new SelectComposeItemEvent("killcropIcon"));
      }
      
      public function autoHelperHandler(param1:FieldVO) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID && param1 && param1.isAutomatic)
         {
            if(param1.seedID == 0 && param1.isDig && param1.autoSeedID != 0)
            {
               _loc4_ = FarmModelController.instance.model.findItemInfo(32,param1.autoSeedID);
               if(_loc4_)
               {
                  if(_loc4_.CategoryID == 32 && _loc4_.Count > 0)
                  {
                     if(_loc4_.Count == 1)
                     {
                        return;
                     }
                  }
               }
            }
            if(param1.seedID != 0 && param1.autoFertilizerID != 0 && param1.AccelerateTime == 0)
            {
               _loc3_ = 1;
               _loc2_ = FarmModelController.instance.model.findItemInfo(33,param1.autoFertilizerID);
               if(_loc2_)
               {
                  if(_loc2_.CategoryID == 33 && _loc2_.Count > 0)
                  {
                     FarmModelController.instance.accelerateField(_loc3_,param1.fieldID,param1.autoFertilizerID);
                     if(_loc2_.Count == 1)
                     {
                        return;
                     }
                  }
               }
            }
            if(param1.plantGrownPhase == 2)
            {
               FarmModelController.instance.getHarvest(param1.fieldID);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            if(_fields[_loc1_])
            {
               _fields[_loc1_].removeEventListener("killcropshow",__showComfigKillCrop);
               ObjectUtils.disposeObject(_fields[_loc1_]);
               _fields[_loc1_] = null;
            }
            _loc1_++;
         }
         remvoeEvent();
         _fields = null;
         if(_configmPnl)
         {
            ObjectUtils.disposeObject(_configmPnl);
         }
         _configmPnl = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get fields() : Vector.<FarmFieldBlock>
      {
         return _fields;
      }
   }
}
