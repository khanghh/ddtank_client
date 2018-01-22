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
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
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
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("farmHouse.btnSelectHouseCompose3");
            _loc2_ = new Sprite();
            _loc2_.graphics.beginFill(16777215,0);
            _loc2_.graphics.drawRect(0,0,50,50);
            _loc2_.graphics.endFill();
            _loc3_ = new ShopItemCell(_loc2_);
            _loc3_.cellSize = 50;
            _loc1_.addEventListener("click",__selectValue);
            _loc1_.mouseChildren = true;
            _loc1_.addChild(_loc3_);
            PositionUtils.setPos(_loc3_,"farm.confirmComposeFoodAlertFrame.cellPos");
            _hBox.addChild(_loc1_);
            _cells.push(_loc3_);
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
         _preBtn.addEventListener("click",__onPageBtnClick);
         _nextBtn.addEventListener("click",__onPageBtnClick);
      }
      
      private function __onPageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
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
         var _loc1_:int = 0;
         var _loc3_:* = null;
         _cellInfos = [];
         var _loc5_:int = 0;
         var _loc4_:* = FarmComposeHouseController.instance().composeHouseModel.foodComposeList;
         for each(var _loc2_ in FarmComposeHouseController.instance().composeHouseModel.foodComposeList)
         {
            _loc1_ = _loc2_[0].FoodID;
            _loc3_ = ItemManager.Instance.getTemplateById(_loc1_);
            _cellInfos.push(_loc3_);
         }
         _totlePage = _cellInfos.length % 3 == 0?_cellInfos.length / 3 - 1:Number(_cellInfos.length / 3);
         upCells(0);
      }
      
      private function upCells(param1:int = 0) : void
      {
         var _loc3_:int = 0;
         _currentPage = param1;
         var _loc2_:int = param1 * 3;
         _loc3_ = 0;
         while(_loc3_ < _cells.length)
         {
            if(_cellInfos[_loc3_ + _loc2_])
            {
               _cells[_loc3_].info = _cellInfos[_loc3_ + _loc2_];
            }
            _loc3_++;
         }
      }
      
      private function __selectValue(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:BaseButton = param1.currentTarget as BaseButton;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.numChildren)
         {
            _loc3_ = _loc2_.getChildAt(_loc4_);
            if(_loc3_ is ShopItemCell)
            {
               _loc5_ = _loc3_.info;
               break;
            }
            _loc4_++;
         }
         if(_loc5_)
         {
            dispatchEvent(new SelectComposeItemEvent("selectFood",_loc5_));
         }
      }
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         removeEvent();
         if(_hBox)
         {
            _loc2_ = 0;
            while(_loc2_ < _hBox.numChildren)
            {
               _loc1_ = _hBox.getChildAt(_loc2_);
               if(_loc1_ is BaseButton)
               {
                  _loc1_.removeEventListener("click",__onPageBtnClick);
               }
               _loc2_++;
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
