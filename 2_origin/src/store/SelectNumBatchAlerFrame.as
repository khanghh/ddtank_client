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
      
      public function set item(param1:InventoryItemInfo) : void
      {
         _item = param1;
      }
      
      public function set callback(param1:Function) : void
      {
         _callBack = param1;
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.bag.item.openBatch.titleStr"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _loc1_.moveEnable = false;
         _loc1_.autoDispose = false;
         _loc1_.sound = "008";
         info = _loc1_;
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
      
      public function set TitleTxt(param1:String) : void
      {
         this.titleText = param1;
      }
      
      public function set ContentTxt(param1:String) : void
      {
         if(_txt)
         {
            _txt.text = param1;
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
      
      private function changeMaxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_item)
         {
            _inputText.text = String(_item.Count > 99?99:_item.Count);
            _count = int(_inputText.text);
         }
      }
      
      private function inputTextChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_item)
         {
            _loc2_ = _inputText.text;
            _loc3_ = _item.Count > 99?99:_item.Count;
            if(_loc2_ > _loc3_)
            {
               _inputText.text = _loc3_.toString();
            }
            if(_loc2_ < 1)
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
