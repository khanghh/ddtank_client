package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaDutyInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class JobManageItem extends Sprite implements Disposeable
   {
       
      
      private var _name:FilterFrameText;
      
      private var _btn:TextButton;
      
      private var _light:Bitmap;
      
      private var _nameBG:Scale9CornerImage;
      
      private var _dutyInfo:ConsortiaDutyInfo;
      
      private var _editable:Boolean;
      
      private var _selected:Boolean;
      
      public function JobManageItem(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function set dutyInfo(param1:ConsortiaDutyInfo) : void{}
      
      private function __btnClickHandler(param1:MouseEvent) : void{}
      
      public function set editable(param1:Boolean) : void{}
      
      public function get editable() : Boolean{return false;}
      
      public function get upText() : Boolean{return false;}
      
      private function setDefultName() : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      private function __mouseOverHandler(param1:MouseEvent) : void{}
      
      private function __mouseOutHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
