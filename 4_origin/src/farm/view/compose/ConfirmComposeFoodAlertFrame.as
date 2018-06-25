package farm.view.compose
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.control.FarmComposeHouseController;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class ConfirmComposeFoodAlertFrame extends Frame
   {
       
      
      private var _bg3:Scale9CornerImage;
      
      private var _promptTxt:FilterFrameText;
      
      private var _showTxtBG:Image;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _hBox:HBox;
      
      private var _cells:Vector.<ShopItemCell>;
      
      private var _cellInfos:Array;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _currentImg:Bitmap;
      
      public function ConfirmComposeFoodAlertFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var btn:* = null;
         var sp:* = null;
         var itemCell:* = null;
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("farm.confirmComposeFoodAlertFrame.bg3");
         addToContent(_bg3);
         _showTxtBG = ComponentFactory.Instance.creatComponentByStylename("farm.confirmComposeFoodAlertFrame.showTxtBG");
         addToContent(_showTxtBG);
         _promptTxt = ComponentFactory.Instance.creat("farm.confirmComposeFoodAlertFrame.promptTxt");
         _promptTxt.text = LanguageMgr.GetTranslation("ddt.farms.confirmComposeFoodAlertFrame.promptText");
         addToContent(_promptTxt);
         escEnable = true;
         _preBtn = ComponentFactory.Instance.creat("farm.confirmComposeFoodAlertFrame.btnPrePage1");
         addToContent(_preBtn);
         _nextBtn = ComponentFactory.Instance.creat("farm.confirmComposeFoodAlertFrame.btnNextPage1");
         addToContent(_nextBtn);
         _cells = new Vector.<ShopItemCell>();
         _hBox = ComponentFactory.Instance.creat("farm.confirmComposeFoodAlertFrame.cropBox");
         addToContent(_hBox);
         for(i = 0; i < 3; )
         {
            btn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.btnSelectHouseCompose3");
            sp = new Sprite();
            sp.graphics.beginFill(16777215,0);
            sp.graphics.drawRect(0,0,50,50);
            sp.graphics.endFill();
            itemCell = new ShopItemCell(sp);
            itemCell.cellSize = 50;
            btn.addEventListener("click",__selectValue);
            btn.mouseChildren = true;
            btn.addChild(itemCell);
            PositionUtils.setPos(itemCell,"farm.confirmComposeFoodAlertFrame.cellPos");
            _hBox.addChild(btn);
            _cells.push(itemCell);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
         _preBtn.addEventListener("click",__onPageBtnClick);
         _nextBtn.addEventListener("click",__onPageBtnClick);
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
      
      private function initData() : void
      {
         var foodId:int = 0;
         var info:* = null;
         _cellInfos = [];
         var _loc5_:int = 0;
         var _loc4_:* = FarmComposeHouseController.instance().composeHouseModel.foodComposeList;
         for each(var itemInfoVec in FarmComposeHouseController.instance().composeHouseModel.foodComposeList)
         {
            foodId = itemInfoVec[0].FoodID;
            info = ItemManager.Instance.getTemplateById(foodId);
            _cellInfos.push(info);
         }
         _totlePage = _cellInfos.length % 3 == 0?_cellInfos.length / 3 - 1:Number(_cellInfos.length / 3);
         upCells(0);
      }
      
      private function upCells(page:int = 0) : void
      {
         var i:int = 0;
         _currentPage = page;
         var start:int = page * 3;
         for(i = 0; i < _cells.length; )
         {
            if(_cellInfos[i + start])
            {
               _cells[i].info = _cellInfos[i + start];
            }
            i++;
         }
      }
      
      private function __selectValue(e:MouseEvent) : void
      {
         var info:* = null;
         var i:int = 0;
         var obj:* = null;
         SoundManager.instance.play("008");
         var btn:BaseButton = e.currentTarget as BaseButton;
         for(i = 0; i < btn.numChildren; )
         {
            obj = btn.getChildAt(i);
            if(obj is ShopItemCell)
            {
               info = obj.info;
               break;
            }
            i++;
         }
         if(info)
         {
            dispatchEvent(new SelectComposeItemEvent("selectFood",info));
         }
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
         _preBtn.removeEventListener("click",__onPageBtnClick);
         _nextBtn.removeEventListener("click",__onPageBtnClick);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var obj:* = null;
         removeEvent();
         if(_hBox)
         {
            for(i = 0; i < _hBox.numChildren; )
            {
               obj = _hBox.getChildAt(i);
               if(obj is BaseButton)
               {
                  obj.removeEventListener("click",__onPageBtnClick);
               }
               i++;
            }
            _hBox.disposeAllChildren();
            _hBox.dispose();
            _hBox = null;
         }
         if(_promptTxt)
         {
            ObjectUtils.disposeObject(_promptTxt);
         }
         _promptTxt = null;
         if(_bg3)
         {
            ObjectUtils.disposeObject(_bg3);
         }
         _bg3 = null;
         if(_showTxtBG)
         {
            ObjectUtils.disposeObject(_showTxtBG);
         }
         _showTxtBG = null;
         super.dispose();
      }
   }
}
