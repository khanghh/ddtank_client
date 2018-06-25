package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SelectNumBatchAlerFrame extends BaseAlerFrame
   {
       
      
      private var _item:InventoryItemInfo;
      
      private var _txt:FilterFrameText;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _callBack:Function;
      
      private var _count:int;
      
      public function SelectNumBatchAlerFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set item(value:InventoryItemInfo) : void
      {
         _item = value;
      }
      
      public function set callback(call:Function) : void
      {
         _callBack = call;
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var _alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.bag.item.openBatch.titleStr"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         _alertInfo.autoDispose = false;
         _alertInfo.sound = "008";
         info = _alertInfo;
         _txt = ComponentFactory.Instance.creatComponentByStylename("openBatchView.promptTxt");
         PositionUtils.setPos(_txt,"ddtstore.FineEvolution.SelectTxtPos");
         _txt.text = LanguageMgr.GetTranslation("ddt.bag.item.openBatch.promptStr");
         _inputBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.openBatchView.inputBg");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("openBatchView.inputTxt");
         _inputText.text = "1";
         _count = 1;
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("openBatchView.maxBtn");
         addToContent(_txt);
         addToContent(_inputBg);
         addToContent(_inputText);
         addToContent(_maxBtn);
      }
      
      public function set TitleTxt(msg:String) : void
      {
         this.titleText = msg;
      }
      
      public function set ContentTxt(msg:String) : void
      {
         if(_txt)
         {
            _txt.text = msg;
         }
      }
      
      private function initEvent() : void
      {
         _maxBtn.addEventListener("click",changeMaxHandler,false,0,true);
         _inputText.addEventListener("change",inputTextChangeHandler,false,0,true);
      }
      
      private function removeEvent() : void
      {
         _maxBtn.removeEventListener("click",changeMaxHandler);
         _inputText.removeEventListener("change",inputTextChangeHandler);
      }
      
      private function changeMaxHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_item)
         {
            _inputText.text = String(_item.Count > 99?99:_item.Count);
            _count = int(_inputText.text);
         }
      }
      
      private function inputTextChangeHandler(event:Event) : void
      {
         var num:int = 0;
         var count:int = 0;
         if(_item)
         {
            num = _inputText.text;
            count = _item.Count > 99?99:_item.Count;
            if(num > count)
            {
               _inputText.text = count.toString();
            }
            if(num < 1)
            {
               _inputText.text = "1";
            }
            _count = int(_inputText.text);
         }
      }
      
      public function get Count() : int
      {
         return _count;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _item = null;
         _txt = null;
         _inputBg = null;
         _inputText = null;
         _maxBtn = null;
         _callBack = null;
      }
   }
}
