package magicHouse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   
   public class MagicHouseTipFrame extends Frame
   {
       
      
      private var _tipTxt:FilterFrameText;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _item:DoubleSelectedItem;
      
      public function MagicHouseTipFrame()
      {
         super();
         initView();
      }
      
      public function set item(value:DoubleSelectedItem) : void
      {
         _item = value;
      }
      
      public function get item() : DoubleSelectedItem
      {
         return _item;
      }
      
      private function initView() : void
      {
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.tipFrame.tipText");
         addToContent(_tipTxt);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.chargeBoxframe.confirmBtn");
         _okBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         PositionUtils.setPos(_okBtn,"magicHouse.tipFrame.OkBtnPos");
         addToContent(_okBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.chargeBoxframe.cancleBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText");
         PositionUtils.setPos(_cancelBtn,"magicHouse.tipFrame.CancekBtnPos");
         addToContent(_cancelBtn);
         _item = new DoubleSelectedItem();
         _item.x = 144;
         _item.y = 107;
      }
      
      public function get okBtn() : TextButton
      {
         return _okBtn;
      }
      
      public function get cancelBtn() : TextButton
      {
         return _cancelBtn;
      }
      
      public function setTipText(str:String) : void
      {
         this._tipTxt.text = str;
      }
      
      public function setTipHtmlText(str:String) : void
      {
         this._tipTxt.htmlText = str;
      }
      
      public function setFrameWidth($w:int) : void
      {
         this.width = $w;
      }
      
      public function setFrameHeight($h:int) : void
      {
         this.height = $h;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
