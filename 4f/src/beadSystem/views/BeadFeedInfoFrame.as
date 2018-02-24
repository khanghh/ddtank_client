package beadSystem.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class BeadFeedInfoFrame extends BaseAlerFrame
   {
       
      
      private var _showInfo:FilterFrameText;
      
      private var _prompt:FilterFrameText;
      
      private var _yes:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _textInput:TextInput;
      
      public var isBind:Boolean;
      
      public var itemInfo:InventoryItemInfo;
      
      private var _beadName:String;
      
      public function BeadFeedInfoFrame(){super();}
      
      private function initView() : void{}
      
      public function setBeadName(param1:String) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onTextInputKeyDown(param1:KeyboardEvent) : void{}
      
      private function __confirmhandler(param1:MouseEvent) : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
      
      public function get textInput() : TextInput{return null;}
   }
}
