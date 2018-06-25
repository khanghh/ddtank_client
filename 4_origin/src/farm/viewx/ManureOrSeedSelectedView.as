package farm.viewx
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   import shop.manager.ShopBuyManager;
   
   public class ManureOrSeedSelectedView extends Sprite implements Disposeable
   {
      
      public static const SEED:int = 1;
      
      public static const MANURE:int = 2;
      
      public static const manureIdArr:Array = [333101,333102,333103,333104];
       
      
      private var manureVec:Array;
      
      private var _manureSelectViewBg:ScaleBitmapImage;
      
      private var _title:ScaleFrameImage;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _hBox:HBox;
      
      private var _cells:Vector.<FarmCell>;
      
      private var _type:int;
      
      private var _cellInfos:Array;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _currentCell:FarmCell;
      
      private var _currentImg:Bitmap;
      
      private var _isHelping:Boolean;
      
      public function ManureOrSeedSelectedView(isHelping:Boolean = false)
      {
         super();
         _isHelping = isHelping;
         initView();
         initEvent();
      }
      
      public function set viewType(value:int) : void
      {
         _type = value;
         cellInfos();
         upCells(0);
         visible = true;
         _title.setFrame(_type);
         if(_type == 1)
         {
            if(PetsBagManager.instance().haveTaskOrderByID(369))
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(101);
               PetsBagManager.instance().showPetFarmGuildArrow(102,0,"farmTrainer.selectSeedArrowPos","asset.farmTrainer.selectSeed","farmTrainer.selectSeedTipPos",this);
            }
         }
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__onClose);
         _preBtn.addEventListener("click",__onPageBtnClick);
         _nextBtn.addEventListener("click",__onPageBtnClick);
         PlayerManager.Instance.Self.getBag(13).addEventListener("update",__bagUpdate);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__onClose);
         _preBtn.removeEventListener("click",__onPageBtnClick);
         _nextBtn.removeEventListener("click",__onPageBtnClick);
         PlayerManager.Instance.Self.getBag(13).removeEventListener("update",__bagUpdate);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var n:int = 0;
         var inv:* = null;
         _manureSelectViewBg = ComponentFactory.Instance.creatComponentByStylename("farm.manureselectViewBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("farm.selectedView.title");
         _title.setFrame(_type);
         _preBtn = ComponentFactory.Instance.creat("farm.btnPrePage1");
         _nextBtn = ComponentFactory.Instance.creat("farm.btnNextPage1");
         _closeBtn = ComponentFactory.Instance.creat("farm.seedselectcloseBtn");
         _hBox = ComponentFactory.Instance.creat("farm.cropBox");
         addChild(_manureSelectViewBg);
         addChild(_title);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_closeBtn);
         addChild(_hBox);
         _cells = new Vector.<FarmCell>(3);
         for(i = 0; i < 3; )
         {
            _cells[i] = new FarmCell();
            _cells[i].addEventListener("click",__clickHandler);
            _hBox.addChild(_cells[i]);
            i++;
         }
         manureVec = [];
         for(n = 0; n < manureIdArr.length; )
         {
            inv = new InventoryItemInfo();
            inv.TemplateID = manureIdArr[n];
            ObjectUtils.copyProperties(inv,ItemManager.Instance.getTemplateById(inv.TemplateID));
            manureVec.push(inv);
            n++;
         }
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.visible = false;
         _currentCell = event.currentTarget as FarmCell;
         if(_currentCell.itemInfo.Count != 0)
         {
            if(!_isHelping)
            {
               _currentCell.dragStart();
               if(_type == 1)
               {
                  if(PetsBagManager.instance().haveTaskOrderByID(369))
                  {
                     PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(102);
                     PetsBagManager.instance().showPetFarmGuildArrow(103,-150,"farmTrainer.seedFieldArrowPos","asset.farmTrainer.seedField","farmTrainer.seedFieldTipPos");
                  }
               }
               else if(_type == 2)
               {
                  if(PetsBagManager.instance().haveTaskOrderByID(369))
                  {
                     PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(105);
                     PetsBagManager.instance().showPetFarmGuildArrow(106,-150,"farmTrainer.useFertilizerArrowPos","asset.farmTrainer.useFertilizer","farmTrainer.useFertilizerTipPos");
                  }
               }
            }
         }
         else
         {
            ShopBuyManager.Instance.buyFarmShop(_currentCell.itemInfo.TemplateID);
         }
      }
      
      private function __bagUpdate(event:BagEvent) : void
      {
         cellInfos();
         upCells(_currentPage);
      }
      
      private function __onClose(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         visible = false;
         PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(102);
         PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(105);
      }
      
      private function __onPageBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = e.currentTarget;
         if(_preBtn !== _loc2_)
         {
            if(_nextBtn === _loc2_)
            {
               _currentPage = _currentPage + 1 > _totlePage?_totlePage:_currentPage + 1;
            }
         }
         else
         {
            _currentPage = _currentPage - 1 < 0?0:Number(_currentPage - 1);
         }
         upCells(_currentPage);
      }
      
      private function cellInfos() : void
      {
         var i:int = 0;
         var n:int = 0;
         var tempInfos:Array = _type == 1?PlayerManager.Instance.Self.getBag(13).findItems(32):PlayerManager.Instance.Self.getBag(13).findItems(33);
         if(_type == 2)
         {
            for(i = 0; i < manureVec.length; )
            {
               manureVec[i].Count = 0;
               for(n = 0; n < tempInfos.length; )
               {
                  if(tempInfos[n].TemplateID == manureVec[i].TemplateID)
                  {
                     ObjectUtils.copyProperties(manureVec[i],tempInfos[n]);
                     break;
                  }
                  n++;
               }
               i++;
            }
            _cellInfos = manureVec;
         }
         else
         {
            tempInfos.sortOn("TemplateID",16);
            _cellInfos = tempInfos;
         }
         _totlePage = _cellInfos.length % 3 == 0?_cellInfos.length / 3 - 1:Number(_cellInfos.length / 3);
      }
      
      private function upCells(page:int = 0) : void
      {
         var i:int = 0;
         _currentPage = page;
         var start:int = page * 3;
         for(i = 0; i < 3; )
         {
            if(_cellInfos[i + start])
            {
               _cells[i].itemInfo = _cellInfos[i + start];
               if(_cells[i].itemInfo.Count > 0)
               {
                  _cells[i].visible = true;
               }
               else
               {
                  _cells[i].visible = false;
               }
            }
            else
            {
               _cells[i].visible = false;
            }
            i++;
         }
      }
      
      private function compareFun(x:int, y:int) : Number
      {
         if(x < y)
         {
            return 1;
         }
         if(x > y)
         {
            return -1;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         for(i = 0; i < 3; )
         {
            if(_cells[i])
            {
               ObjectUtils.disposeObject(_cells[i]);
               _cells[i].removeEventListener("click",__clickHandler);
            }
            _cells[i] = null;
            i++;
         }
         _cells = null;
         if(_manureSelectViewBg)
         {
            ObjectUtils.disposeObject(_manureSelectViewBg);
         }
         _manureSelectViewBg = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
         }
         _hBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
