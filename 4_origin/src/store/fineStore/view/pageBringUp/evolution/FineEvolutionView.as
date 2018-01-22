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
      
      public function FineEvolutionView(param1:StoreController)
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
         _controller = new StoreBagController(param1.Model);
         _view = _controller.getView(StoreModel.EVOLUTION_BAG);
         addChild(_view);
         FineEvolutionManager.Instance.CallBack = changeEatState;
         createAcceptDragSprite();
      }
      
      public function get isEatStatus() : Boolean
      {
         return _isEatStatus;
      }
      
      public function set isEatStatus(param1:Boolean) : void
      {
         _isEatStatus = param1;
      }
      
      private function changeEatState(param1:Boolean) : void
      {
         _isEatStatus = param1;
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
      
      private function __socketEvolutionHander(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.evolution.success"));
         }
      }
      
      private function __lockClickHandler(param1:MouseEvent) : void
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
      
      protected function onLockMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:StoreBagCell = param1.target as StoreBagCell;
         if(param1.target is StoreBagCell)
         {
            lockStatusChange();
         }
         else if(param1.target is IconLayer)
         {
            _loc2_ = (param1.target as IconLayer).parent.parent as StoreBagCell;
            if(_loc2_ && _loc2_.info)
            {
               _loc2_.cellLocked = !_loc2_.cellLocked;
               (_loc2_.info as InventoryItemInfo).cellLocked = _loc2_.cellLocked;
               GameInSocketOut.sendBringUpLockStatusUpdate(_loc2_.bagType,(_loc2_.info as InventoryItemInfo).Place,_loc2_.cellLocked);
            }
            else
            {
               lockStatusChange();
            }
         }
      }
      
      private function __evolutionAllHandler(param1:MouseEvent) : void
      {
         if(!_usingEatMouse && !FineBringUpController.getInstance().usingLock)
         {
            onEatClick(null);
         }
      }
      
      private function __evolutionHandler(param1:MouseEvent) : void
      {
         if(!FineBringUpController.getInstance().usingLock)
         {
            isEatStatus = true;
            param1.stopImmediatePropagation();
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
      
      protected function onEatMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(param1.target is IconLayer)
         {
            _loc2_ = param1.target.parent.parent as StoreBagCell;
            if(_loc2_ && _loc2_.info)
            {
               if(_loc2_.info == this._evolutionUpCell.info)
               {
                  eatStatusChange();
               }
               else
               {
                  if(_loc2_.cellLocked)
                  {
                     if(_loc2_.info.TemplateID == 12572)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatLockedCellIIII"),0,true,1);
                     }
                     else
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatLockedCellII"),0,true,1);
                     }
                     return;
                  }
                  onEatClick(_loc2_.info as InventoryItemInfo);
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
      
      private function onEatClick(param1:InventoryItemInfo) : void
      {
         if(_evolutionUpCell && _evolutionUpCell.info)
         {
            FineEvolutionManager.Instance.eatBeHaviour(_evolutionUpCell.info as InventoryItemInfo,param1);
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
      
      private function __enterFrameHandler(param1:Event) : void
      {
         if(_upgrade && _upgrade.currentFrame == _upgrade.totalFrames)
         {
            _upgrade.stop();
            _upgrade.visible = false;
         }
      }
      
      private function __updateInventorySlot(param1:BagEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(FineBringUpController.getInstance().onSending)
         {
            return;
         }
         var _loc4_:InventoryItemInfo = PlayerManager.Instance.Self.getBag(12).getItemAt(0);
         if(_loc4_ != null)
         {
            if(lastinfo && lastinfo.ItemID == _loc4_.ItemID)
            {
               _loc3_ = FineEvolutionManager.Instance.GetNextEvolutionDataByEXP(int(lastinfo.curExp));
               if(_loc3_ && _loc4_.curExp >= _loc3_.Exp)
               {
                  playerGradeMc();
               }
            }
            _evolutionUpCell.info = _loc4_;
            lastinfo = ItemManager.copy(_loc4_);
            _loc3_ = FineEvolutionManager.Instance.GetNextEvolutionDataByEXP(int(_loc4_.curExp));
            if(_loc3_)
            {
               _progressTxt.text = _loc4_.curExp + "/" + _loc3_.Exp;
               upDataDisTxt(_loc4_);
            }
            return;
         }
         if(_evolutionUpCell.info)
         {
            _loc2_ = new LatentEnergyEvent("latentEnergy_equip_move2");
            _loc2_.info = _evolutionUpCell.info as InventoryItemInfo;
            _loc2_.moveType = 2;
            FineBringUpController.getInstance().dispatchEvent(_loc2_);
         }
         _progressTxt.text = "0/0";
         this._disI.text = "";
         this._disII.text = "";
         _lvTxt.text = "";
      }
      
      private function upDataDisTxt(param1:InventoryItemInfo) : void
      {
         var _loc2_:* = null;
         var _loc6_:EvolutionData = FineEvolutionManager.Instance.GetEvolutionDataByExp(param1.curExp);
         var _loc3_:Boolean = false;
         var _loc9_:* = 0;
         var _loc8_:* = 0;
         var _loc7_:int = 0;
         if(_loc6_)
         {
            _loc3_ = _loc6_.isMax;
            if(!_loc3_)
            {
               _loc2_ = FineEvolutionManager.Instance.EvolutionDataByLv(_loc6_.Level + 1);
            }
            if(param1.Property3 == "32")
            {
               _loc9_ = Number(_loc6_.AddBlood / 10);
               if(_loc2_)
               {
                  _loc8_ = Number(_loc2_.AddBlood / 10);
               }
            }
            else
            {
               _loc9_ = Number(_loc6_.ReduceDamage / 10);
               if(_loc2_)
               {
                  _loc8_ = Number(_loc2_.ReduceDamage / 10);
               }
            }
            _loc7_ = _loc6_.Level;
         }
         else
         {
            _loc2_ = FineEvolutionManager.Instance.EvolutionDataByLv(1);
            if(param1.Property3 == "32")
            {
               if(_loc2_)
               {
                  _loc8_ = Number(_loc2_.AddBlood / 10);
               }
            }
            else if(_loc2_)
            {
               _loc8_ = Number(_loc2_.ReduceDamage / 10);
            }
         }
         var _loc4_:String = LanguageMgr.GetTranslation("store.evolution.disTxt");
         var _loc5_:String = LanguageMgr.GetTranslation("store.evolution.disTxtII");
         this._disI.text = "";
         this._disII.text = "";
         _lvTxt.text = _loc7_.toString();
         if(param1.Property3 == "32")
         {
            _loc4_ = _loc4_ + LanguageMgr.GetTranslation("store.evolution.addblood",_loc9_.toFixed(2) + "%");
            if(_loc3_ == false)
            {
               _loc5_ = _loc5_ + LanguageMgr.GetTranslation("store.evolution.addblood",_loc8_.toFixed(2) + "%");
            }
         }
         else
         {
            _loc4_ = _loc4_ + LanguageMgr.GetTranslation("store.evolution.ReduceDamage",_loc9_.toFixed(2) + "%");
            if(_loc3_ == false)
            {
               _loc5_ = _loc5_ + LanguageMgr.GetTranslation("store.evolution.ReduceDamage",_loc8_.toFixed(2) + "%");
            }
         }
         if(_loc3_)
         {
            _loc5_ = LanguageMgr.GetTranslation("store.EvolutionItemCell.up");
         }
         this._disI.text = _loc4_;
         this._disII.text = _loc5_;
      }
      
      private function __cellDoubleClick(param1:CellEvent) : void
      {
         param1.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            SoundManager.instance.play("008");
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BagCell = param1.data as StoreBagCell;
         dragDrop(_loc2_);
      }
      
      public function dragDrop(param1:BagCell) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = param1.itemInfo;
            if(_loc2_ && _loc2_.TemplateID != 12572)
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0);
            }
         }
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:StoreBagCell = param1.data as StoreBagCell;
         _loc2_.dragStart();
      }
      
      private function startShine(param1:StoreDargEvent) : void
      {
      }
      
      private function stopShine(param1:StoreDargEvent) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:int = FineEvolutionManager.Instance.progress(param1 as InventoryItemInfo);
         if(_progressBar.totalFrames >= _loc2_)
         {
            _progressBar && _progressBar.gotoAndStop(_loc2_);
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
