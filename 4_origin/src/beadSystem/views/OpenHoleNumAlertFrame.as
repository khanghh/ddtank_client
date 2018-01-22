package beadSystem.views
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class OpenHoleNumAlertFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _cellBg:ScaleBitmapImage;
      
      private var _cell:BagCell;
      
      private var _descript:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var maxLimit:int;
      
      private var submitFunc:Function;
      
      public var curItemID:int = 0;
      
      public function OpenHoleNumAlertFrame()
      {
         super();
      }
      
      public function initAlert() : void
      {
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("store.Embed.batchOpenHoleTileText"),LanguageMgr.GetTranslation("ok"),"",true,false);
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         escEnable = true;
         _cellBg = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
         PositionUtils.setPos(_cellBg,"gemstone.alertFrame.cellbgPos");
         addToContent(_cellBg);
         var _loc1_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(curItemID);
         _cell = new BagCell(0,_loc1_);
         PositionUtils.setPos(_cell,"gemstone.alertFrame.cellPos");
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         maxLimit = _loc2_.getItemCountByTemplateId(curItemID);
         _cell.setCount(maxLimit);
         addToContent(_cell);
         _descript = ComponentFactory.Instance.creatComponentByStylename("gemstone.alertFrame.descriptTxt");
         _descript.text = LanguageMgr.GetTranslation("store.Embed.batchOpenHoleText");
         addToContent(_descript);
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("gemstone.alertFrame.inputBg");
         addToContent(_inputBg);
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("gemstone.alertFrame.inputTxt");
         _inputTxt.text = "1";
         _inputTxt.restrict = "0-9";
         addToContent(_inputTxt);
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("gemstone.alertFrame.maxBtn");
         addToContent(_maxBtn);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _inputTxt.addEventListener("change",__inputChange);
         _maxBtn.addEventListener("click",__maxBtnClick);
      }
      
      protected function __maxBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _inputTxt.text = maxLimit.toString();
      }
      
      protected function __inputChange(param1:Event) : void
      {
         var _loc2_:int = parseInt(_inputTxt.text);
         if(_loc2_ <= 0)
         {
            _inputTxt.text = "1";
         }
         else if(_loc2_ > maxLimit)
         {
            _inputTxt.text = maxLimit.toString();
         }
      }
      
      protected function _response(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            default:
            default:
            default:
            case 3:
               _loc2_ = parseInt(_inputTxt.text);
               submitFunc(_loc2_);
         }
         ObjectUtils.disposeObject(this);
      }
      
      public function callBack(param1:Function) : void
      {
         submitFunc = param1;
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         _inputTxt.removeEventListener("change",__inputChange);
         _maxBtn.removeEventListener("click",__maxBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_cellBg);
         ObjectUtils.disposeObject(_cell);
         ObjectUtils.disposeObject(_descript);
         ObjectUtils.disposeObject(_inputBg);
         ObjectUtils.disposeObject(_inputTxt);
         ObjectUtils.disposeObject(_maxBtn);
         super.dispose();
      }
   }
}
