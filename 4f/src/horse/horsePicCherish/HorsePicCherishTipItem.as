package horse.horsePicCherish
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class HorsePicCherishTipItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _isActive:Boolean;
      
      public function HorsePicCherishTipItem(param1:int){super();}
      
      private function initView() : void{}
      
      public function set isActive(param1:Boolean) : void{}
      
      public function set value(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
