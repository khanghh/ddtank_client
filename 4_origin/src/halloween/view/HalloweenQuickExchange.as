package halloween.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HalloweenQuickExchange extends BaseAlerFrame
   {
       
      
      private var _itemId:int;
      
      private var _cellNum:int;
      
      private var _cell:BagCell;
      
      private var _textInfo:FilterFrameText;
      
      private var _numBg:Scale9CornerImage;
      
      private var _num:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      public function HalloweenQuickExchange()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("task.taskView.quickUse.titleText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _loc1_.moveEnable = false;
         _loc1_.autoDispose = false;
         info = _loc1_;
         _textInfo = ComponentFactory.Instance.creatComponentByStylename("quickUseFrame.tipsInfo");
         _textInfo.text = LanguageMgr.GetTranslation("quickUseFrame.tipsInfoText");
         addToContent(_textInfo);
         _numBg = ComponentFactory.Instance.creatComponentByStylename("quickUseFrame.itemCell.InputBg");
         addToContent(_numBg);
         _num = ComponentFactory.Instance.creatComponentByStylename("quickUseFrame.numText");
         addToContent(_num);
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("asset.core.quickUse.maxBtn");
         addToContent(_maxBtn);
      }
      
      public function setItemInfo(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_itemId != param1)
         {
            _itemId = param1;
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
            _loc2_ = ItemManager.Instance.getTemplateById(_itemId);
            if(_loc2_)
            {
               _cell = new BagCell(0);
               _cell.setContentSize(49,49);
               _cell.PicPos = new Point(10,9);
               PositionUtils.setPos(_cell,"quickUserFrame.itemcell.cellPos");
               addToContent(_cell);
               LayerManager.Instance.addToLayer(this,2,true,2);
            }
            else
            {
               dispose();
            }
         }
      }
      
      private function updateItemCellCount(param1:int) : void
      {
         _cellNum = param1;
         _num.text = "1";
         _cell.setCount(_cellNum);
         _cell.refreshTbxPos();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         _num.addEventListener("change",__onTextInput);
         _maxBtn.addEventListener("click",__onMouseClick);
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         _num.text = _cellNum.toString();
      }
      
      protected function __onTextInput(param1:Event) : void
      {
         if(int(_num.text) > _cellNum)
         {
            _num.text = _cellNum.toString();
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.sendTrusteeshipUseSpiritItem(_cell.place,_cell.bagType,int(_num.text));
         }
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_response);
         _num.removeEventListener("change",__onTextInput);
         _maxBtn.removeEventListener("click",__onMouseClick);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_textInfo);
         _textInfo = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_num);
         _num = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
