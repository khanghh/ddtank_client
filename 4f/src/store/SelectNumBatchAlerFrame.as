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
      
      public function SelectNumBatchAlerFrame(){super();}
      
      public function set item(param1:InventoryItemInfo) : void{}
      
      public function set callback(param1:Function) : void{}
      
      private function initView() : void{}
      
      public function set TitleTxt(param1:String) : void{}
      
      public function set ContentTxt(param1:String) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function changeMaxHandler(param1:MouseEvent) : void{}
      
      private function inputTextChangeHandler(param1:Event) : void{}
      
      public function get Count() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
