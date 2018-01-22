package catchInsect.componets
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class IndivPrizeCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _requestTxt:FilterFrameText;
      
      private var _cellBg:Bitmap;
      
      private var _cell:BagCell;
      
      private var _getPrizeBtn:SimpleBitmapButton;
      
      private var _templateId:int;
      
      public function IndivPrizeCell()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("catchInsect.prizeItemBg");
         addChild(_bg);
         _requestTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.requestTxt");
         addChild(_requestTxt);
         _requestTxt.text = "";
         _cellBg = ComponentFactory.Instance.creat("catchInsect.cellBg");
         addChild(_cellBg);
         _cell = new BagCell(0);
         PositionUtils.setPos(_cell,"catchInsect.cellPos");
         addChild(_cell);
         _cell.setBgVisible(false);
         _getPrizeBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.getPrizeBtn");
         addChild(_getPrizeBtn);
      }
      
      private function initEvents() : void
      {
         _getPrizeBtn.addEventListener("click",__getPrizeBtnClick);
      }
      
      protected function __getPrizeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.getInsectPrize(_templateId);
      }
      
      public function setData(param1:int, param2:int) : void
      {
         _templateId = param1;
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = _templateId;
         ItemManager.fill(_loc3_);
         _loc3_.IsBinds = true;
         _cell.info = _loc3_;
         _cell.setCountNotVisible();
         _requestTxt.text = LanguageMgr.GetTranslation("catchInsect.needScore",param2);
      }
      
      public function setStatus(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               _getPrizeBtn.enable = true;
               break;
            case 1:
               _getPrizeBtn.enable = false;
         }
      }
      
      private function removeEvents() : void
      {
         _getPrizeBtn.removeEventListener("click",__getPrizeBtnClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_cellBg);
         _cell = null;
         ObjectUtils.disposeObject(_getPrizeBtn);
         _getPrizeBtn = null;
         ObjectUtils.disposeObject(_requestTxt);
         _requestTxt = null;
      }
   }
}
