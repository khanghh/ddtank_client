package store.fineStore.view.pageBringUp.evolution
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.IconLayer;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   import store.FineEvolutionManager;
   import store.StoreController;
   import store.data.EvolutionData;
   import store.data.StoreModel;
   import store.events.StoreDargEvent;
   import store.fineStore.view.pageBringUp.IObserver;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagController;
   
   public class FineEvolutionView extends Sprite implements Disposeable, IObserver
   {
       
      
      private var _leftBg:MovieClip;
      
      private var _bgCell:Bitmap;
      
      private var _progressBar:MovieClip;
      
      private var _evolutionUpCell:EvolutionUpCell;
      
      private var _lvImage:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _disBg:ScaleBitmapImage;
      
      private var _disI:FilterFrameText;
      
      private var _disII:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _lockSelectBtn:BaseButton;
      
      private var _one_button_evolution:BaseButton;
      
      private var _evolutionBtn:BaseButton;
      
      private var _controller:StoreBagController;
      
      private var _mouseLockImg:Sprite;
      
      private var _view:DisplayObject;
      
      private var _leftDrapSprite:FineEvolutionUpLeftDragPanel;
      
      private var _rightDrapSprite:FineEvolutionUpRightFragPanel;
      
      private var _progressTxt:FilterFrameText;
      
      private var _isEatStatus:Boolean;
      
      private var _usingEatMouse:Boolean = false;
      
      private var _mouseEatImg:Sprite;
      
      private var _upgrade:MovieClip;
      
      private var _helpBtn:BaseButton;
      
      private var lastinfo:InventoryItemInfo;
      
      public function FineEvolutionView(con:StoreController)
      {
         super();
         _leftBg = ComponentFactory.Instance.creat("asset.store.evolution.leftBg");
         PositionUtils.setPos(_leftBg,"storeEvolution.leftBgPos");
         _leftBg.gotoAndStop(1);
         addChild(_leftBg);
         _bgCell = ComponentFactory.Instance.creatBitmap("equipretrieve.trieveCell1");
         PositionUtils.setPos(_bgCell,"storeEvolution.itemCellPos");
         addChild(_bgCell);
         _lvImage = ComponentFactory.Instance.creatBitmap("store.evolution.lv");
         addChild(_lvImage);
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("evolution.lvtxt");
         addChild(_lvTxt);
         _progressBar = ComponentFactory.Instance.creat("store.fineforge.forgeProgress");
         PositionUtils.setPos(_progressBar,"evolutionUp.progressPos");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("ddt.store.view.exalt.StoreExaltProgressBar.percentage");
         PositionUtils.setPos(_progressTxt,"evolutionUp.progressTxtPos");
         _progressTxt.mouseEnabled = false;
         _progressTxt.text = "0/0";
         _evolutionUpCell = new EvolutionUpCell(0);
         _evolutionUpCell.info = null;
         _evolutionUpCell.register(this);
         _evolutionUpCell.x = _bgCell.x + 22;
         _evolutionUpCell.y = _bgCell.y + 24;
         addChild(_evolutionUpCell);
         _progressBar.mouseEnabled = false;
         _progressBar.mouseChildren = false;
         _progressBar.gotoAndStop(0);
         addChild(_progressBar);
         addChild(_progressTxt);
         _mouseLockImg = new Sprite();
         _mouseLockImg.addChild(ComponentFactory.Instance.creatBitmap("asset.store.evolution.lockCursor"));
         _disBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtstore.evolution.di");
         addChild(_disBg);
         _disI = ComponentFactory.Instance.creatComponentByStylename("evolution.distxtI");
         _disII = ComponentFactory.Instance.creatComponentByStylename("evolution.distxtII");
         addChild(_disI);
         addChild(_disII);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"store.evolution.help",370,340);
         PositionUtils.setPos(_helpBtn,"storeFine.evolutionUp.helpPos");
         _lockSelectBtn = ComponentFactory.Instance.creatComponentByStylename("evolution.lockSelectBtn");
         addChild(_lockSelectBtn);
         _one_button_evolution = ComponentFactory.Instance.creatComponentByStylename("evolution.one.button.Btn");
         addChild(_one_button_evolution);
         _evolutionBtn = ComponentFactory.Instance.creatComponentByStylename("evolution.Btn");
         addChild(_evolutionBtn);
         _controller = new StoreBagController(con.Model);
         _view = _controller.getView(StoreModel.EVOLUTION_BAG);
         addChild(_view);
         FineEvolutionManager.Instance.CallBack = changeEatState;
         createAcceptDragSprite();
      }
      
      public function get isEatStatus() : Boolean
      {
         return _isEatStatus;
      }
      
      public function set isEatStatus(value:Boolean) : void
      {
         _isEatStatus = value;
      }
      
      private function changeEatState(value:Boolean) : void
      {
         _isEatStatus = value;
         FineEvolutionManager.Instance.canClickBagList = !isEatStatus;
      }
      
      private function createAcceptDragSprite() : void
      {
         _leftDrapSprite = new FineEvolutionUpLeftDragPanel();
         _leftDrapSprite.mouseEnabled = false;
         _leftDrapSprite.mouseChildren = false;
         _leftDrapSprite.graphics.beginFill(0,0);
         _leftDrapSprite.graphics.drawRect(0,0,347,404);
         _leftDrapSprite.graphics.endFill();
         PositionUtils.setPos(_leftDrapSprite,"storeBringUp.dragLeftPos");
         addChild(_leftDrapSprite);
         _rightDrapSprite = new FineEvolutionUpRightFragPanel();
         _rightDrapSprite.mouseEnabled = false;
         _rightDrapSprite.mouseChildren = false;
         _rightDrapSprite.graphics.beginFill(0,0);
         _rightDrapSprite.graphics.drawRect(0,0,374,407);
         _rightDrapSprite.graphics.endFill();
         PositionUtils.setPos(_rightDrapSprite,"storeBringUp.dragRightPos");
         addChild(_rightDrapSprite);
      }
      
      public function initEvent() : void
      {
         _view.addEventListener("itemclick",cellClickHandler,false,0,true);
         _view.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _view.addEventListener("startDarg",startShine);
         _view.addEventListener("stopDarg",stopShine);
         _lockSelectBtn.addEventListener("click",__lockClickHandler);
         _evolutionBtn.addEventListener("click",__evolutionHandler);
         _one_button_evolution.addEventListener("click",__evolutionAllHandler);
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateInventorySlot);
         SocketManager.Instance.addEventListener(PkgEvent.format(384),__socketEvolutionHander);
      }
      
      private function __socketEvolutionHander(e:PkgEvent) : void
      {
         var value:Boolean = e.pkg.readBoolean();
         if(value)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.evolution.success"));
         }
      }
      
      private function __lockClickHandler(evt:MouseEvent) : void
      {
         if(!_usingEatMouse)
         {
            lockStatusChange();
         }
      }
      
      private function lockStatusChange() : void
      {
         FineBringUpController.getInstance().usingLock = !FineBringUpController.getInstance().usingLock;
         if(FineBringUpController.getInstance().usingLock)
         {
            Mouse.hide();
            StageReferance.stage.addChild(_mouseLockImg);
            var _loc1_:Boolean = false;
            _mouseLockImg.mouseEnabled = _loc1_;
            _mouseLockImg.mouseChildren = _loc1_;
            _mouseLockImg.x = StageReferance.stage.mouseX - _mouseLockImg.width * 0.5;
            _mouseLockImg.y = StageReferance.stage.mouseY - _mouseLockImg.height * 0.5;
            _mouseLockImg.startDrag(false);
            StageReferance.stage.addEventListener("click",onLockMouseClick);
         }
         else
         {
            Mouse.show();
            if(_mouseLockImg)
            {
               _mouseLockImg.parent && StageReferance.stage.removeChild(_mouseLockImg);
               _mouseLockImg.stopDrag();
            }
            StageReferance.stage.removeEventListener("click",onLockMouseClick);
         }
      }
      
      protected function onLockMouseClick(e:MouseEvent) : void
      {
         var cell:StoreBagCell = e.target as StoreBagCell;
         if(e.target is StoreBagCell)
         {
            lockStatusChange();
         }
         else if(e.target is IconLayer)
         {
            cell = (e.target as IconLayer).parent.parent as StoreBagCell;
            if(cell && cell.info)
            {
               cell.cellLocked = !cell.cellLocked;
               (cell.info as InventoryItemInfo).cellLocked = cell.cellLocked;
               GameInSocketOut.sendBringUpLockStatusUpdate(cell.bagType,(cell.info as InventoryItemInfo).Place,cell.cellLocked);
            }
            else
            {
               lockStatusChange();
            }
         }
      }
      
      private function __evolutionAllHandler(evt:MouseEvent) : void
      {
         if(!_usingEatMouse && !FineBringUpController.getInstance().usingLock)
         {
            onEatClick(null);
         }
      }
      
      private function __evolutionHandler(evt:MouseEvent) : void
      {
         if(!FineBringUpController.getInstance().usingLock)
         {
            isEatStatus = true;
            evt.stopImmediatePropagation();
            eatStatusChange();
         }
      }
      
      private function eatStatusChange() : void
      {
         _usingEatMouse = !_usingEatMouse;
         FineEvolutionManager.Instance.canClickBagList = !isEatStatus;
         if(_usingEatMouse)
         {
            Mouse.hide();
            if(_mouseEatImg == null)
            {
               _mouseEatImg = new Sprite();
               _mouseEatImg.addChild(ComponentFactory.Instance.creatBitmap("asset.store.evolution.feedIcon"));
            }
            StageReferance.stage.addChild(_mouseEatImg);
            var _loc1_:Boolean = false;
            _mouseEatImg.mouseEnabled = _loc1_;
            _mouseEatImg.mouseChildren = _loc1_;
            _mouseEatImg.x = StageReferance.stage.mouseX - _mouseEatImg.width * 0.5;
            _mouseEatImg.y = StageReferance.stage.mouseY - _mouseEatImg.height * 0.5;
            _mouseEatImg.startDrag(false);
            StageReferance.stage.addEventListener("click",onEatMouseClick);
         }
         else
         {
            _evolutionUpCell && _loc1_;
            _evolutionUpCell && _loc1_;
            Mouse.show();
            if(_mouseEatImg)
            {
               _mouseEatImg.parent && StageReferance.stage.removeChild(_mouseEatImg);
               _mouseEatImg.stopDrag();
            }
            StageReferance.stage.removeEventListener("click",onEatMouseClick);
         }
      }
      
      protected function onEatMouseClick(e:MouseEvent) : void
      {
         var cell:* = null;
         if(e.target is IconLayer)
         {
            cell = e.target.parent.parent as StoreBagCell;
            if(cell && cell.info)
            {
               if(cell.info == this._evolutionUpCell.info)
               {
                  eatStatusChange();
               }
               else
               {
                  if(cell.cellLocked)
                  {
                     if(cell.info.TemplateID == 12572)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatLockedCellIIII"),0,true,1);
                     }
                     else
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatLockedCellII"),0,true,1);
                     }
                     return;
                  }
                  onEatClick(cell.info as InventoryItemInfo);
                  _usingEatMouse = false;
                  StageReferance.stage.removeEventListener("click",onEatMouseClick);
                  Mouse.show();
                  if(_mouseEatImg)
                  {
                     _mouseEatImg.parent && StageReferance.stage.removeChild(_mouseEatImg);
                     _mouseEatImg.stopDrag();
                  }
               }
            }
         }
         else
         {
            isEatStatus = false;
            eatStatusChange();
         }
      }
      
      private function onEatClick($info:InventoryItemInfo) : void
      {
         if(_evolutionUpCell && _evolutionUpCell.info)
         {
            FineEvolutionManager.Instance.eatBeHaviour(_evolutionUpCell.info as InventoryItemInfo,$info);
            eatStatusChange();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.offhand.putEvolutionCell"));
         }
      }
      
      public function removeEvent() : void
      {
         _view.removeEventListener("itemclick",cellClickHandler);
         _view.removeEventListener("doubleclick",__cellDoubleClick);
         _view.removeEventListener("startDarg",startShine);
         _view.removeEventListener("stopDarg",stopShine);
         _lockSelectBtn.removeEventListener("click",__lockClickHandler);
         _evolutionBtn.removeEventListener("click",__evolutionHandler);
         _one_button_evolution.removeEventListener("click",__evolutionHandler);
         if(_upgrade)
         {
            _upgrade.addEventListener("enterFrame",__enterFrameHandler);
         }
         PlayerManager.Instance.removeEventListener("bring_up",__updateInventorySlot);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateInventorySlot);
         SocketManager.Instance.removeEventListener(PkgEvent.format(384),__socketEvolutionHander);
      }
      
      private function playerGradeMc() : void
      {
         if(_upgrade == null)
         {
            _upgrade = ComponentFactory.Instance.creat("store.evolution.success.mc");
            _upgrade.addEventListener("enterFrame",__enterFrameHandler);
            _upgrade.x = 166;
            _upgrade.y = 112;
            addChild(_upgrade);
         }
         _upgrade.visible = true;
         _upgrade.play();
      }
      
      private function __enterFrameHandler(e:Event) : void
      {
         if(_upgrade && _upgrade.currentFrame == _upgrade.totalFrames)
         {
            _upgrade.stop();
            _upgrade.visible = false;
         }
      }
      
      private function __updateInventorySlot(e:BagEvent) : void
      {
         var data:* = null;
         var event:* = null;
         if(FineBringUpController.getInstance().onSending)
         {
            return;
         }
         var __info:InventoryItemInfo = PlayerManager.Instance.Self.getBag(12).getItemAt(0);
         if(__info != null)
         {
            if(lastinfo && lastinfo.ItemID == __info.ItemID)
            {
               data = FineEvolutionManager.Instance.GetNextEvolutionDataByEXP(int(lastinfo.curExp));
               if(data && __info.curExp >= data.Exp)
               {
                  playerGradeMc();
               }
            }
            _evolutionUpCell.info = __info;
            lastinfo = ItemManager.copy(__info);
            data = FineEvolutionManager.Instance.GetNextEvolutionDataByEXP(int(__info.curExp));
            if(data)
            {
               _progressTxt.text = __info.curExp + "/" + data.Exp;
               upDataDisTxt(__info);
            }
            return;
         }
         if(_evolutionUpCell.info)
         {
            event = new LatentEnergyEvent("latentEnergy_equip_move2");
            event.info = _evolutionUpCell.info as InventoryItemInfo;
            event.moveType = 2;
            FineBringUpController.getInstance().dispatchEvent(event);
         }
         _progressTxt.text = "0/0";
         this._disI.text = "";
         this._disII.text = "";
         _lvTxt.text = "";
      }
      
      private function upDataDisTxt(info:InventoryItemInfo) : void
      {
         var nextData:* = null;
         var data:EvolutionData = FineEvolutionManager.Instance.GetEvolutionDataByExp(info.curExp);
         var isMax:Boolean = false;
         var currentValue:* = 0;
         var nextValue:* = 0;
         var lv:int = 0;
         if(data)
         {
            isMax = data.isMax;
            if(!isMax)
            {
               nextData = FineEvolutionManager.Instance.EvolutionDataByLv(data.Level + 1);
            }
            if(info.Property3 == "32")
            {
               currentValue = Number(data.AddBlood / 10);
               if(nextData)
               {
                  nextValue = Number(nextData.AddBlood / 10);
               }
            }
            else if(info.Property3 == "132")
            {
               currentValue = Number(data.ReduceDander / 10);
               if(nextData)
               {
                  nextValue = Number(nextData.ReduceDander / 10);
               }
            }
            else
            {
               currentValue = Number(data.ReduceDamage / 10);
               if(nextData)
               {
                  nextValue = Number(nextData.ReduceDamage / 10);
               }
            }
            lv = data.Level;
         }
         else
         {
            nextData = FineEvolutionManager.Instance.EvolutionDataByLv(1);
            if(info.Property3 == "32")
            {
               if(nextData)
               {
                  nextValue = Number(nextData.AddBlood / 10);
               }
            }
            else if(info.Property3 == "132")
            {
               if(nextData)
               {
                  nextValue = Number(nextData.ReduceDander / 10);
               }
            }
            else if(nextData)
            {
               nextValue = Number(nextData.ReduceDamage / 10);
            }
         }
         var str:String = LanguageMgr.GetTranslation("store.evolution.disTxt");
         var next:String = LanguageMgr.GetTranslation("store.evolution.disTxtII");
         this._disI.text = "";
         this._disII.text = "";
         _lvTxt.text = lv.toString();
         if(info.Property3 == "32")
         {
            str = str + LanguageMgr.GetTranslation("store.evolution.addblood",currentValue.toFixed(2) + "%");
            if(isMax == false)
            {
               next = next + LanguageMgr.GetTranslation("store.evolution.addblood",nextValue.toFixed(2) + "%");
            }
         }
         else if(info.Property3 == "132")
         {
            str = str + LanguageMgr.GetTranslation("store.evolution.reduceRander",currentValue.toFixed(2) + "%");
            if(isMax == false)
            {
               next = next + LanguageMgr.GetTranslation("store.evolution.reduceRander",nextValue.toFixed(2) + "%");
            }
         }
         else
         {
            str = str + LanguageMgr.GetTranslation("store.evolution.ReduceDamage",currentValue.toFixed(2) + "%");
            if(isMax == false)
            {
               next = next + LanguageMgr.GetTranslation("store.evolution.ReduceDamage",nextValue.toFixed(2) + "%");
            }
         }
         if(isMax)
         {
            next = LanguageMgr.GetTranslation("store.EvolutionItemCell.up");
         }
         this._disI.text = str;
         this._disII.text = next;
      }
      
      private function __cellDoubleClick(evt:CellEvent) : void
      {
         evt.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            SoundManager.instance.play("008");
            BaglockedManager.Instance.show();
            return;
         }
         var sourceCell:BagCell = evt.data as StoreBagCell;
         dragDrop(sourceCell);
      }
      
      public function dragDrop(source:BagCell) : void
      {
         var itemInfo:* = null;
         if(source)
         {
            itemInfo = source.itemInfo;
            if(itemInfo && itemInfo.TemplateID != 12572)
            {
               SocketManager.Instance.out.sendMoveGoods(itemInfo.BagType,itemInfo.Place,12,0);
            }
         }
      }
      
      private function cellClickHandler(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var cell:StoreBagCell = event.data as StoreBagCell;
         cell.dragStart();
      }
      
      private function startShine(evt:StoreDargEvent) : void
      {
      }
      
      private function stopShine(evt:StoreDargEvent) : void
      {
      }
      
      public function update(data:Object) : void
      {
         var percent:int = FineEvolutionManager.Instance.progress(data as InventoryItemInfo);
         if(_progressBar.totalFrames >= percent)
         {
            _progressBar && _progressBar.gotoAndStop(percent);
            _progressTxt && _loc3_;
         }
         else
         {
            _progressBar && _progressBar.gotoAndStop(0);
            _progressTxt && _loc3_;
         }
      }
      
      public function dispose() : void
      {
         _controller.dispose();
         _controller = null;
         removeEvent();
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_upgrade);
         _upgrade = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_evolutionUpCell);
         _evolutionUpCell = null;
         ObjectUtils.disposeObject(_disBg);
         _disBg = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_mouseLockImg);
         _mouseLockImg = null;
         ObjectUtils.disposeObject(_leftDrapSprite);
         _leftDrapSprite = null;
         ObjectUtils.disposeObject(_rightDrapSprite);
         _rightDrapSprite = null;
         ObjectUtils.disposeObject(_helpBtn);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
