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
         var i:int = 0;
         var field:* = null;
         _fields = new Vector.<FarmFieldBlock>(16);
         for(i = 0; i < 16; )
         {
            field = new FarmFieldBlock(i);
            PositionUtils.setPos(field,"farm.fieldsView.fieldPos" + i);
            field.addEventListener("killcropshow",__showComfigKillCrop);
            addChild(field);
            _fields[i] = field;
            i++;
         }
         __fieldInfoReady(null);
      }
      
      private function __setFields(event:FarmEvent) : void
      {
         setFieldByHelper();
      }
      
      public function setFieldByHelper() : void
      {
         var m:int = 0;
         var nowDate:int = 0;
         if(PlayerManager.Instance.Self.ID != FarmModelController.instance.model.currentFarmerId)
         {
            return;
         }
         if(!PlayerManager.Instance.Self.isFarmHelper)
         {
            return;
         }
         var fieldsInfo:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         for(m = 0; m < FarmModelController.instance.model.fieldsInfo.length; )
         {
            nowDate = (new Date().getTime() - fieldsInfo[m].payTime.getTime()) / 3600000;
            if(fieldsInfo[m].fieldValidDate > nowDate || fieldsInfo[m].fieldValidDate == -1)
            {
               _fields[m].setBeginHelper(FarmModelController.instance.model.helperArray[1]);
            }
            m++;
         }
      }
      
      protected function __fieldInfoReady(event:FarmEvent) : void
      {
         upFields();
         upFlagPlace();
         setFieldByHelper();
      }
      
      private function __hasSeeding(event:FarmEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < 16; )
         {
            if(_fields[i].info.fieldID == FarmModelController.instance.model.seedingFieldInfo.fieldID)
            {
               _fields[i].info = FarmModelController.instance.model.seedingFieldInfo;
               if(PetsBagManager.instance().haveTaskOrderByID(369))
               {
                  PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(103);
               }
               break;
            }
            i++;
         }
         autoHelperHandler(FarmModelController.instance.model.seedingFieldInfo);
      }
      
      private function __frushField(event:FarmEvent) : void
      {
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            upFields();
            upFlagPlace();
            setFieldByHelper();
         }
      }
      
      private function __gainField(event:FarmEvent) : void
      {
         var i:int = 0;
         var field:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.gainFieldId);
         for(i = 0; i < 16; )
         {
            if(_fields[i].info.fieldID == FarmModelController.instance.model.gainFieldId)
            {
               _fields[i].info = field;
               upFlagPlace();
               break;
            }
            i++;
         }
         if(field.isAutomatic)
         {
            autoHelperHandler(field);
         }
      }
      
      private function __accelerateField(event:FarmEvent) : void
      {
         var i:int = 0;
         var field:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.matureId);
         for(i = 0; i < 16; )
         {
            if(_fields[i].info.fieldID == FarmModelController.instance.model.matureId)
            {
               _fields[i].info = field;
               break;
            }
            i++;
         }
         autoHelperHandler(field);
      }
      
      private function __helperSwitchHandler(event:FarmEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < 16; )
         {
            if(_fields[i].info.fieldID == FarmModelController.instance.model.isAutoId)
            {
               _fields[i].info = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.isAutoId);
               return;
            }
            i++;
         }
      }
      
      private function __helperKeyHandler(event:FarmEvent) : void
      {
         var arr:Array = FarmModelController.instance.model.batchFieldIDArray;
         var _loc5_:int = 0;
         var _loc4_:* = arr;
         for each(var fieldId in arr)
         {
            _fields[fieldId].info = FarmModelController.instance.model.getfieldInfoById(fieldId);
         }
      }
      
      private function __onKillcropField(event:FarmEvent) : void
      {
         var i:int = 0;
         var field:FieldVO = FarmModelController.instance.model.getfieldInfoById(FarmModelController.instance.model.killCropId);
         for(i = 0; i < 16; )
         {
            if(_fields[i].info.fieldID == FarmModelController.instance.model.killCropId)
            {
               _fields[i].info = field;
               return;
            }
            i++;
         }
      }
      
      private function upFields() : void
      {
         var i:int = 0;
         var id:int = 0;
         var n:int = 0;
         var placeArr:Array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
         var fieldsInfo:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         for(i = 0; i < fieldsInfo.length; )
         {
            id = fieldsInfo[i].fieldID;
            if(_fields[id])
            {
               _fields[id].info = fieldsInfo[i];
               autoHelperHandler(_fields[id].info);
               placeArr.splice(placeArr.indexOf(id),1);
            }
            i++;
         }
         for(n = 0; n < placeArr.length; )
         {
            _fields[placeArr[n]].info = null;
            n++;
         }
      }
      
      private function upFlagPlace() : void
      {
         var fieldsInfo:* = undefined;
         var i:int = 0;
         var n:int = 0;
         var j:int = 0;
         var placeArr:Array = [8,9,10,11,12,13,14,15];
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            fieldsInfo = FarmModelController.instance.model.fieldsInfo;
            for(i = 0; i < fieldsInfo.length; )
            {
               if(fieldsInfo[i].fieldID >= 8 && (fieldsInfo[i].isDig || fieldsInfo[i].seedID != 0))
               {
                  placeArr.splice(placeArr.indexOf(fieldsInfo[i].fieldID),1);
                  _fields[fieldsInfo[i].fieldID].flag = false;
               }
               i++;
            }
            for(n = 0; n < placeArr.length; )
            {
               if(n == 0)
               {
                  _fields[placeArr[n]].flag = true;
               }
               else
               {
                  _fields[placeArr[n]].flag = false;
               }
               n++;
            }
         }
         else
         {
            j = 0;
            while(j < placeArr.length)
            {
               _fields[placeArr[j]].flag = false;
               j++;
            }
         }
      }
      
      private function __showComfigKillCrop(e:SelectComposeItemEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var field:FieldVO = e.data as FieldVO;
         _configmPnl = ComponentFactory.Instance.creatComponentByStylename("farm.confirmKillCropAlertFrame");
         _configmPnl.cropName(ItemManager.Instance.getTemplateById(field.seedID).Name,field.isAutomatic);
         _configmPnl.fieldId = field.fieldID;
         _configmPnl.addEventListener("killcropClick",__killCropClick);
         LayerManager.Instance.addToLayer(_configmPnl,3,true,1);
      }
      
      private function __killCropClick(e:SelectComposeItemEvent) : void
      {
         var fieldID:int = e.data as int;
         if(fieldID != -1)
         {
            FarmModelController.instance.killCrop(fieldID);
         }
         if(_configmPnl)
         {
            _configmPnl.removeEventListener("killcropClick",__killCropClick);
         }
         this.dispatchEvent(new SelectComposeItemEvent("killcropIcon"));
      }
      
      public function autoHelperHandler(_info:FieldVO) : void
      {
         var seedInfo:* = null;
         var type:int = 0;
         var fertilizerInfo:* = null;
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID && _info && _info.isAutomatic)
         {
            if(_info.seedID == 0 && _info.isDig && _info.autoSeedID != 0)
            {
               seedInfo = FarmModelController.instance.model.findItemInfo(32,_info.autoSeedID);
               if(seedInfo)
               {
                  if(seedInfo.CategoryID == 32 && seedInfo.Count > 0)
                  {
                     if(seedInfo.Count == 1)
                     {
                        return;
                     }
                  }
               }
            }
            if(_info.seedID != 0 && _info.autoFertilizerID != 0 && _info.AccelerateTime == 0)
            {
               type = 1;
               fertilizerInfo = FarmModelController.instance.model.findItemInfo(33,_info.autoFertilizerID);
               if(fertilizerInfo)
               {
                  if(fertilizerInfo.CategoryID == 33 && fertilizerInfo.Count > 0)
                  {
                     FarmModelController.instance.accelerateField(type,_info.fieldID,_info.autoFertilizerID);
                     if(fertilizerInfo.Count == 1)
                     {
                        return;
                     }
                  }
               }
            }
            if(_info.plantGrownPhase == 2)
            {
               FarmModelController.instance.getHarvest(_info.fieldID);
            }
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = 0; i < 16; )
         {
            if(_fields[i])
            {
               _fields[i].removeEventListener("killcropshow",__showComfigKillCrop);
               ObjectUtils.disposeObject(_fields[i]);
               _fields[i] = null;
            }
            i++;
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
