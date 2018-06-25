package farm.view.compose
{
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.control.FarmComposeHouseController;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.view.compose.item.ComposeItem;
   import farm.view.compose.item.ComposeMoveScroll;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import petsBag.PetsBagManager;
   import shop.view.ShopItemCell;
   
   public class FarmComposePnl extends Sprite implements Disposeable
   {
       
      
      private var _selectComposeBtn:BaseButton;
      
      private var _composeActionBtn:SimpleBitmapButton;
      
      private var _itemComposeVec:Vector.<ComposeItem>;
      
      private var _composeScroll:ComposeMoveScroll;
      
      private var _bg1:DisplayObject;
      
      private var _bg2:DisplayObject;
      
      private var _maxCount:int = -1;
      
      private var _foodID:int;
      
      private var _selectComposeBtnShine:IEffect;
      
      private var _result:ShopItemCell;
      
      private var _configmPnl:ConfirmComposeAlertFrame;
      
      private var _confirmComposeFoodAlertFrame:ConfirmComposeFoodAlertFrame;
      
      public function FarmComposePnl()
      {
         super();
         _itemComposeVec = new Vector.<ComposeItem>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var index:int = 0;
         var bg:* = null;
         var item:* = null;
         _bg1 = ComponentFactory.Instance.creat("asset.farmHouse.composebg1");
         addChild(_bg1);
         _bg2 = ComponentFactory.Instance.creat("farm.farmHouse.composebg2");
         addChild(_bg2);
         _composeScroll = new ComposeMoveScroll();
         addChild(_composeScroll);
         var composeScroll:Point = PositionUtils.creatPoint("farm.composeMoveScroll.point");
         _composeScroll.x = composeScroll.x;
         _composeScroll.y = composeScroll.y;
         _selectComposeBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.btnSelectHouseCompose");
         addChild(_selectComposeBtn);
         _composeActionBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.btnComposeAction");
         addChild(_composeActionBtn);
         for(index = 0; index < 4; )
         {
            bg = ComponentFactory.Instance.creat("asset.farm.baseImage5");
            item = ComponentFactory.Instance.creat("farmHouse.composeItem",[bg]);
            PositionUtils.setPos(item,"farm.houseCompose.point" + index);
            _itemComposeVec.push(item);
            addChild(item);
            index++;
         }
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,50,50);
         sp.graphics.endFill();
         _result = new ShopItemCell(sp);
         _result.cellSize = 50;
         PositionUtils.setPos(_result,"farm.composePnl.cellPos");
         _selectComposeBtn.addChild(_result);
         _selectComposeBtn.mouseChildren = true;
         var shineData:Object = {};
         shineData["color"] = "gold";
         _selectComposeBtnShine = EffectManager.Instance.creatEffect(3,_selectComposeBtn,shineData);
         _selectComposeBtnShine.play();
         upComposeBtn();
      }
      
      private function upComposeBtn() : void
      {
         _composeActionBtn.enable = _maxCount > 0;
         playSelectComposeBtnShine();
      }
      
      private function setCellInfo(index:int, info:ItemTemplateInfo, detail:int = 1) : void
      {
         if(index < 0 || index > 4)
         {
            return;
         }
         _itemComposeVec[index].info = info;
         _itemComposeVec[index].useCount = detail;
         if(_maxCount == -1)
         {
            _maxCount = _itemComposeVec[index].maxCount;
         }
         else
         {
            _maxCount = _maxCount > _itemComposeVec[index].maxCount?_itemComposeVec[index].maxCount:int(_maxCount);
         }
      }
      
      private function initEvent() : void
      {
         _composeActionBtn.addEventListener("click",__showComfigCompose);
         _selectComposeBtn.addEventListener("click",__showConfirmComposeFoodAlertFrame);
         _selectComposeBtn.addEventListener("rollOver",__onMouseRollover);
         _selectComposeBtn.addEventListener("rollOut",__onMouseRollout);
         _selectComposeBtn.addEventListener("mouseDown",__onMouseDown);
         PlayerManager.Instance.Self.getBag(14).addEventListener("update",__bagUpdate);
      }
      
      protected function __bagUpdate(event:Event) : void
      {
         update();
      }
      
      private function __showComfigCompose(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_itemComposeVec[0].info != null)
         {
            _configmPnl = ComponentFactory.Instance.creatComponentByStylename("farm.confirmComposeAlert.confirmCompose");
            _configmPnl.maxCount = _maxCount;
            LayerManager.Instance.addToLayer(_configmPnl,3,true,1);
            _configmPnl.addEventListener("compose_count",__configmCount);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.componse.selected.me"));
         }
      }
      
      private function __showConfirmComposeFoodAlertFrame(e:MouseEvent) : void
      {
         stopSelectComposeBtnShine();
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _confirmComposeFoodAlertFrame = ComponentFactory.Instance.creatComponentByStylename("farm.confirmComposeAlert.confirmComposeFoodAlertFrame");
         _confirmComposeFoodAlertFrame.addEventListener("selectFood",__selectFood);
         _confirmComposeFoodAlertFrame.addEventListener("response",__confirmComposeFoodAlertFrameResponse);
         LayerManager.Instance.addToLayer(_confirmComposeFoodAlertFrame,3,true,1);
      }
      
      private function closeConfirmComposeFoodAlertFrame() : void
      {
         if(_confirmComposeFoodAlertFrame)
         {
            _confirmComposeFoodAlertFrame.removeEventListener("selectFood",__selectFood);
            _confirmComposeFoodAlertFrame.dispose();
            _confirmComposeFoodAlertFrame = null;
         }
      }
      
      private function __confirmComposeFoodAlertFrameResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               closeConfirmComposeFoodAlertFrame();
         }
         playSelectComposeBtnShine();
      }
      
      private function __selectFood(e:SelectComposeItemEvent) : void
      {
         stopSelectComposeBtnShine();
         SoundManager.instance.play("008");
         _result.info = e.data as ItemTemplateInfo;
         _foodID = _result.info.TemplateID;
         if(_selectComposeBtn.backgound is MovieClip)
         {
            (_selectComposeBtn.backgound as MovieClip).gotoAndStop(4);
         }
         _maxCount = -1;
         update();
         if(PetsBagManager.instance().haveTaskOrderByID(370))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(110);
         }
         closeConfirmComposeFoodAlertFrame();
      }
      
      private function __configmCount(event:SelectComposeItemEvent) : void
      {
         _configmPnl.removeEventListener("compose_count",__configmCount);
         var count:int = event.data;
         if(_foodID && int(count))
         {
            if(PetsBagManager.instance().haveTaskOrderByID(370))
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(112);
               PetsBagManager.instance().petModel.IsFinishTask5 = true;
            }
            SocketManager.Instance.out.sendCompose(_foodID,count);
         }
      }
      
      public function clearInfo() : void
      {
         var index:int = 0;
         _result.info = null;
         for(index = 0; index < 4; )
         {
            setCellInfo(index,null,0);
            index++;
         }
         if(_selectComposeBtn.backgound is MovieClip)
         {
            (_selectComposeBtn.backgound as MovieClip).gotoAndStop(1);
         }
         upComposeBtn();
      }
      
      private function stopSelectComposeBtnShine() : void
      {
         if(_selectComposeBtn && _selectComposeBtn.backgound is MovieClip && _result.info)
         {
            (_selectComposeBtn.backgound as MovieClip).gotoAndStop(4);
         }
         if(!_result.info && !_confirmComposeFoodAlertFrame)
         {
            _selectComposeBtnShine.stop();
         }
      }
      
      private function playSelectComposeBtnShine() : void
      {
         if(_selectComposeBtn && _selectComposeBtn.backgound is MovieClip && _result.info)
         {
            (_selectComposeBtn.backgound as MovieClip).gotoAndStop(4);
         }
         if(!_result.info && !_confirmComposeFoodAlertFrame)
         {
            _selectComposeBtnShine.play();
         }
      }
      
      private function __onMouseDown(e:MouseEvent) : void
      {
         if(_selectComposeBtn && _selectComposeBtn.backgound is MovieClip && _result.info)
         {
            (_selectComposeBtn.backgound as MovieClip).gotoAndStop(4);
         }
      }
      
      private function __onMouseRollover(e:MouseEvent) : void
      {
         stopSelectComposeBtnShine();
      }
      
      private function __onMouseRollout(e:MouseEvent) : void
      {
         playSelectComposeBtnShine();
      }
      
      private function update() : void
      {
         var index:int = 0;
         if(_foodID != 0)
         {
            var _loc4_:int = 0;
            var _loc3_:* = FarmComposeHouseController.instance().getComposeDetailByID(_foodID);
            for each(var itemInfo in FarmComposeHouseController.instance().getComposeDetailByID(_foodID))
            {
               index++;
               setCellInfo(index,ItemManager.Instance.getTemplateById(itemInfo.VegetableID),itemInfo.NeedCount);
            }
            upComposeBtn();
         }
      }
      
      private function removeEvent() : void
      {
         _composeActionBtn.removeEventListener("click",__showComfigCompose);
         _selectComposeBtn.removeEventListener("click",__showConfirmComposeFoodAlertFrame);
         _selectComposeBtn.removeEventListener("rollOver",__onMouseRollover);
         _selectComposeBtn.removeEventListener("rollOut",__onMouseRollout);
         _selectComposeBtn.removeEventListener("mouseDown",__onMouseDown);
         PlayerManager.Instance.Self.getBag(14).removeEventListener("update",__bagUpdate);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _maxCount = -1;
         clearInfo();
         _foodID = 0;
         var _loc3_:int = 0;
         var _loc2_:* = _itemComposeVec;
         for each(var item in _itemComposeVec)
         {
            if(item)
            {
               ObjectUtils.disposeObject(item);
               item = null;
            }
         }
         _itemComposeVec.splice(0,_itemComposeVec.length);
         if(_selectComposeBtn)
         {
            ObjectUtils.disposeObject(_selectComposeBtn);
            _selectComposeBtn = null;
         }
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
            _bg2 = null;
         }
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
            _bg1 = null;
         }
         if(_composeScroll)
         {
            ObjectUtils.disposeObject(_composeScroll);
            _composeScroll = null;
         }
         if(_composeActionBtn)
         {
            ObjectUtils.disposeObject(_composeActionBtn);
            _composeActionBtn = null;
         }
         if(_result)
         {
            ObjectUtils.disposeObject(_result);
            _result = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_selectComposeBtnShine)
         {
            EffectManager.Instance.removeEffect(_selectComposeBtnShine);
            _selectComposeBtnShine = null;
         }
      }
   }
}
