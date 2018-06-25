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
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("task.taskView.quickUse.titleText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         alertInfo.moveEnable = false;
         alertInfo.autoDispose = false;
         info = alertInfo;
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
      
      public function setItemInfo(itemId:int) : void
      {
         var bg:* = null;
         var itemInfo:* = null;
         if(_itemId != itemId)
         {
            _itemId = itemId;
            bg = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
            itemInfo = ItemManager.Instance.getTemplateById(_itemId);
            if(itemInfo)
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
      
      private function updateItemCellCount(needNum:int) : void
      {
         _cellNum = needNum;
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
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         _num.text = _cellNum.toString();
      }
      
      protected function __onTextInput(event:Event) : void
      {
         if(int(_num.text) > _cellNum)
         {
            _num.text = _cellNum.toString();
         }
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 3 || e.responseCode == 2)
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
