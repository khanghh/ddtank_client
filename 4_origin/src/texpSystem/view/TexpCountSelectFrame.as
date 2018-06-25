package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class TexpCountSelectFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _text:FilterFrameText;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _needText:FilterFrameText;
      
      private var _texpInfo:InventoryItemInfo;
      
      public function TexpCountSelectFrame()
      {
         super();
         intView();
      }
      
      private function intView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("texpSystem.view.TexpCountSelect.frame"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _text = ComponentFactory.Instance.creatComponentByStylename("texpSystem.TexpCountSelectFrame.Text");
         _text.text = LanguageMgr.GetTranslation("texpSystem.view.TexpCountSelect.text");
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         PositionUtils.setPos(_numberSelecter,"texpSystem.expCountSelecterPos");
         _numberSelecter.addEventListener("change",__seleterChange);
         _needText = ComponentFactory.Instance.creatComponentByStylename("texpSystem.TexpCountSelectFrame.NeedText");
         _needText.visible = false;
         addToContent(_text);
         addToContent(_numberSelecter);
         addToContent(_needText);
      }
      
      public function show(needCount:int, max:int, min:int = 1) : void
      {
         _numberSelecter.valueLimit = min + "," + max;
         LayerManager.Instance.addToLayer(this,3,true,1);
         _needText.htmlText = LanguageMgr.GetTranslation("texpSystem.view.TexpCountSelect.CountText",needCount);
         _needText.visible = true;
         if(needCount > max)
         {
            _numberSelecter.currentValue = max;
         }
         else
         {
            _numberSelecter.currentValue = needCount;
         }
      }
      
      private function __seleterChange(event:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function get texpInfo() : InventoryItemInfo
      {
         return _texpInfo;
      }
      
      public function set texpInfo(value:InventoryItemInfo) : void
      {
         _texpInfo = value;
      }
      
      public function get count() : int
      {
         return _numberSelecter.currentValue;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_numberSelecter)
         {
            _numberSelecter.removeEventListener("change",__seleterChange);
         }
         removeView();
      }
      
      private function removeView() : void
      {
         ObjectUtils.disposeObject(_numberSelecter);
         _numberSelecter = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_needText);
         _needText = null;
      }
   }
}
