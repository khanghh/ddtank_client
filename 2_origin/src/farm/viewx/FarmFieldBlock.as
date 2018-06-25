package farm.viewx
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   import petsBag.PetsBagManager;
   
   public class FarmFieldBlock extends Sprite implements Disposeable, IAcceptDrag
   {
       
      
      private var _fieldId:int;
      
      private var _info:FieldVO;
      
      private var _picPath:String;
      
      private var _field:ScaleFrameImage;
      
      private var _flag:SimpleBitmapButton;
      
      private var _hitArea:Sprite;
      
      private var _loadingasset:MovieClip;
      
      private var _loader:DisplayLoader;
      
      private var _type:int = -1;
      
      private var _plant:BaseButton;
      
      private var _countdown:CountdownView;
      
      public function FarmFieldBlock(id:int)
      {
         super();
         _fieldId = id;
         initView();
         initEvent();
      }
      
      public function set flag(value:Boolean) : void
      {
         if(value)
         {
            if(_flag == null)
            {
               _flag = ComponentFactory.Instance.creatComponentByStylename("farm.flag");
               _flag.addEventListener("click",__flagClickHandler);
               addChild(_flag);
            }
         }
         else
         {
            if(_flag)
            {
               ObjectUtils.disposeObject(_flag);
            }
            _flag = null;
         }
      }
      
      public function get info() : FieldVO
      {
         return _info;
      }
      
      public function set info(info:FieldVO) : void
      {
         if(_info != info)
         {
            _type = -1;
         }
         _info = info;
         if(_info)
         {
            if(_info.isDig)
            {
               _field.setFrame(1);
               this.addEventListener("mouseOver",__onMouseOver);
               this.addEventListener("mouseOut",__onMouseOut);
               this.addEventListener("click",__onMouseClick);
               if(_flag)
               {
                  ObjectUtils.disposeObject(_flag);
               }
               _flag = null;
            }
            else
            {
               _field.setFrame(2);
            }
            if(_info.seedID != 0)
            {
               this.removeEventListener("click",__onMouseClick);
               _picPath = ItemManager.Instance.getTemplateById(_info.seedID).Pic;
               loadIcon(_info.plantGrownPhase);
               upTips();
            }
            else
            {
               _type = -1;
               if(_plant)
               {
                  _plant.visible = false;
               }
            }
         }
         else
         {
            _type = -1;
            _field.setFrame(2);
            if(_flag)
            {
               ObjectUtils.disposeObject(_flag);
            }
            _flag = null;
            _plant.visible = false;
         }
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         this.dispatchEvent(new FarmEvent("fieldblockclick"));
      }
      
      private function upTips() : void
      {
         var name:* = null;
         var str:* = null;
         if(_info && _info.seedID != 0)
         {
            name = ItemManager.Instance.getTemplateById(info.seedID).Name;
            str = "";
            if(_info.plantGrownPhase == 2)
            {
               str = LanguageMgr.GetTranslation("ddt.farm.goods.grown",_info.gainCount,ItemManager.Instance.getTemplateById(_info.seedID).Property2);
            }
            else if(_info.realNeedTime > 0)
            {
               if(_info.realNeedTime / 60 == 0)
               {
                  str = LanguageMgr.GetTranslation("ddt.farm.goods.mini",_info.realNeedTime % 60);
               }
               else
               {
                  str = LanguageMgr.GetTranslation("ddt.farm.goods.houer",int(_info.realNeedTime / 60),_info.realNeedTime % 60);
               }
               _countdown.setCountdown(_info.fieldID);
            }
            else
            {
               str = LanguageMgr.GetTranslation("ddt.farm.goods.houer",0,0);
            }
            if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID && _info.realNeedTime > 0)
            {
               _countdown.setFastBtnEnable(true);
            }
            else
            {
               _countdown.setFastBtnEnable(false);
            }
            _plant.tipData = LanguageMgr.GetTranslation("ddt.farm.goods.name",name,str);
         }
      }
      
      private function initEvent() : void
      {
      }
      
      public function setBeginHelper(seedID:int) : void
      {
         _picPath = ItemManager.Instance.getTemplateById(seedID).Pic;
         loadIcon(0);
         _plant.tipData = LanguageMgr.GetTranslation("ddt.farms.fieldBlockSeedTips");
      }
      
      private function __onMouseOver(evt:MouseEvent) : void
      {
         if(_info)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      private function __onMouseOut(evt:MouseEvent) : void
      {
         filters = [];
      }
      
      private function initView() : void
      {
         _field = ComponentFactory.Instance.creatComponentByStylename("farm.fieldbg");
         addChild(_field);
         _hitArea = PNGHitAreaFactory.drawHitArea(DisplayUtils.getDisplayBitmapData(_field));
         hitArea = _hitArea;
         _hitArea.alpha = 0;
         addChild(_hitArea);
         _plant = ComponentFactory.Instance.creatComponentByStylename("farm.plant");
         addChild(_plant);
         _plant.visible = false;
         _plant.addEventListener("click",__plantClickHandler);
         FarmModelController.instance.addEventListener("frushField",__frush);
         FarmModelController.instance.addEventListener("accelerateField",__accelerate);
         _countdown = new CountdownView();
         PositionUtils.setPos(_countdown,"assets.farm.countdownPos");
         addChild(_countdown);
         _countdown.visible = false;
      }
      
      protected function __accelerate(event:Event) : void
      {
         if(FarmModelController.instance.model.matureId == _fieldId)
         {
            upTips();
         }
      }
      
      protected function __frush(event:Event) : void
      {
         upTips();
      }
      
      private function __plantClickHandler(event:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.isFarmHelper && PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
         {
            return;
         }
         if(_info.plantGrownPhase == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            FarmModelController.instance.getHarvest(_info.fieldID);
            petFarmGuilde();
            FarmModelController.instance.updateFriendListStolen();
         }
         else
         {
            event.stopImmediatePropagation();
            _countdown.visible = true;
            stage.addEventListener("click",__onClick);
         }
      }
      
      protected function __onClick(event:MouseEvent) : void
      {
         if(_countdown)
         {
            SoundManager.instance.play("008");
            _countdown.visible = false;
            stage.removeEventListener("click",__onClick);
         }
      }
      
      private function petFarmGuilde() : void
      {
         if(PetsBagManager.instance().haveTaskOrderByID(370))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(107);
         }
      }
      
      private function loadIcon(type:int) : void
      {
         if(_type == type)
         {
            return;
         }
         _type = type;
         _loadingasset = ComponentFactory.Instance.creat("bagAndInfo.cell.BaseCellLoadingAsset");
         PositionUtils.setPos(_loadingasset,"farm.farmFieldBlock.pos");
         addChild(_loadingasset);
         if(_loader)
         {
            _loader = null;
         }
         if(_plant)
         {
            ObjectUtils.disposeObject(_plant);
            _plant = null;
         }
         if(!_plant)
         {
            _plant = ComponentFactory.Instance.creatComponentByStylename("farm.plant");
            addChildAt(_plant,this.numChildren - 2);
            _plant.addEventListener("click",__plantClickHandler);
         }
         _loader = LoadResourceManager.Instance.createLoader(PathManager.solveFieldPlantPath(_picPath,type),0);
         _loader.addEventListener("complete",__complete);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      private function __complete(event:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__complete);
         if(_loader.isSuccess)
         {
            _plant.backgound = _loader.content as Bitmap;
            _plant.visible = true;
            if(_loadingasset)
            {
               ObjectUtils.disposeObject(_loadingasset);
            }
            _loadingasset = null;
         }
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var seedInfo:* = null;
         var type:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var linkCls:String = getQualifiedClassName(effect.source);
         if(effect.source is FarmKillCropCell)
         {
            if(_info && _info.seedID != 0)
            {
               dispatchEvent(new SelectComposeItemEvent("killcropshow",_info));
            }
            else
            {
               DragManager.acceptDrag(this);
            }
         }
         else if(effect.source && getQualifiedClassName(effect.source) == "farm.viewx::FarmCell")
         {
            seedInfo = effect.data as InventoryItemInfo;
            if(seedInfo)
            {
               if(_info && _info.seedID == 0 && _info.isDig && seedInfo.CategoryID == 32 && seedInfo.Count > 0)
               {
                  FarmModelController.instance.sowSeed(_fieldId,seedInfo.TemplateID);
                  if(seedInfo.Count == 1)
                  {
                     return;
                  }
               }
               else if(_info && _info.seedID != 0 && seedInfo.CategoryID == 33 && seedInfo.Count > 0)
               {
                  type = 0;
                  FarmModelController.instance.accelerateField(type,_fieldId,seedInfo.TemplateID);
                  if(PetsBagManager.instance().haveTaskOrderByID(369))
                  {
                     PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(106);
                  }
                  if(seedInfo.Count == 1)
                  {
                     return;
                  }
               }
               DragManager.acceptDrag(this);
            }
         }
         else
         {
            DragManager.acceptDrag(null);
         }
      }
      
      private function __flagClickHandler(event:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.isFarmHelper)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farms.fieldBlockSeedTips"));
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         FarmModelController.instance.openPayFieldFrame(_fieldId);
      }
      
      public function dispose() : void
      {
         if(_info && _info.isDig)
         {
            this.removeEventListener("mouseOver",__onMouseOver);
         }
         if(_info && _info.isDig)
         {
            this.removeEventListener("mouseOut",__onMouseOut);
         }
         if(_info && _info.isDig)
         {
            this.removeEventListener("click",__onMouseClick);
         }
         _info = null;
         _loader = null;
         FarmModelController.instance.removeEventListener("frushField",__frush);
         FarmModelController.instance.removeEventListener("accelerateField",__accelerate);
         if(_flag)
         {
            _flag.removeEventListener("click",__flagClickHandler);
         }
         _plant.removeEventListener("click",__plantClickHandler);
         if(_plant)
         {
            ObjectUtils.disposeObject(_plant);
         }
         _plant = null;
         if(_field)
         {
            ObjectUtils.disposeObject(_field);
         }
         _field = null;
         if(_flag)
         {
            ObjectUtils.disposeObject(_flag);
         }
         _flag = null;
         if(_hitArea)
         {
            ObjectUtils.disposeObject(_hitArea);
         }
         _hitArea = null;
         if(_loadingasset)
         {
            ObjectUtils.disposeObject(_loadingasset);
         }
         _loadingasset = null;
         if(_countdown)
         {
            _countdown.dispose();
            _countdown = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
